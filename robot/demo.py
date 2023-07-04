import keyboard

from robot.grid import Grid
from hdc.hypervector import Hypervector
from hdc.encoder import Encoder
from hdc.train import Binder, Bundler

class Demo(object):

    def __init__(self, dimensions: int = 10000) -> None:
        self.dimensions = dimensions
        self.map = [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1],
            [1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1],
            [1, 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 1],
            [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1],
            [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
            [1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 3, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]
        self.mode = ""
        self.program_hvs = []
        self.final_prog_hv = None
        self.last_move = "none"
        self.grid_x = len(self.map[0])
        self.grid_y = len(self.map)
        self.last_col = len(self.map[0]) - 1        
        self.hvs = {}
        self.grid = Grid("Robot HDC Navigation", self.map)
        self.binder = Binder("xor")
        self.bundler = Bundler("majority")
        self.grid.add_button("Train", self.beginTrain, 0, self.last_col+1)
        self.grid.add_button("Recal", self.beginRecall, 1, self.last_col+1)
        self.grid.add_button("Recal Step", self.recallStep, 2, self.last_col+1)
        self.grid.add_button("Reset", self.resetBoard, 10, self.last_col+1)
        self.update_logs()
        self.move_callback = None
        keyboard.on_press_key("left", self.key_west)
        keyboard.on_press_key("up", self.key_north)
        keyboard.on_press_key("down", self.key_south)
        keyboard.on_press_key("right", self.key_east)
        self.grid.update_window()

    def setup_hypervectors(self) -> None:
        self.enc = Encoder()
        # Encodings for Object sensors
        self.enc.create_set_encoding("object_north", "binary", self.dimensions)
        self.enc.create_set_encoding("object_east", "binary", self.dimensions)
        self.enc.create_set_encoding("object_south", "binary", self.dimensions)
        self.enc.create_set_encoding("object_west", "binary", self.dimensions)
        self.enc.create_set_encoding("object_not_north", "binary", self.dimensions)
        self.enc.create_set_encoding("object_not_east", "binary", self.dimensions)
        self.enc.create_set_encoding("object_not_south", "binary", self.dimensions)
        self.enc.create_set_encoding("object_not_west", "binary", self.dimensions)
        # Encodings for Object sensor IDs
        self.enc.create_set_encoding("id_object_north", "binary", self.dimensions)
        self.enc.create_set_encoding("id_object_east", "binary", self.dimensions)
        self.enc.create_set_encoding("id_object_south", "binary", self.dimensions)
        self.enc.create_set_encoding("id_object_west", "binary", self.dimensions)
        # Encodings for Target sensors
        self.enc.create_range_encoding("target_x", "binary", self.dimensions, -self.grid_x, self.grid_x, 2*self.grid_x)
        self.enc.create_range_encoding("target_y", "binary", self.dimensions, -self.grid_y, self.grid_y, 2*self.grid_y)
        # Encodings for Target sensor IDs
        self.enc.create_set_encoding("id_target_x", "binary", self.dimensions)
        self.enc.create_set_encoding("id_target_y", "binary", self.dimensions)
        # Encodings for Lastmove sensor
        self.enc.create_set_encoding("last_move_north", "binary", self.dimensions)
        self.enc.create_set_encoding("last_move_east", "binary", self.dimensions)
        self.enc.create_set_encoding("last_move_south", "binary", self.dimensions)
        self.enc.create_set_encoding("last_move_west", "binary", self.dimensions)
        self.enc.create_set_encoding("last_move_none", "binary", self.dimensions)
        # Encodings for Lastmove sensor IDs
        self.enc.create_set_encoding("id_last_move", "binary", self.dimensions)
        # Encodings for Actuator moves
        self.enc.create_set_encoding("actuator_north", "binary", self.dimensions)
        self.enc.create_set_encoding("actuator_east", "binary", self.dimensions)
        self.enc.create_set_encoding("actuator_south", "binary", self.dimensions)
        self.enc.create_set_encoding("actuator_west", "binary", self.dimensions)
        # Encodings for Actuator IDs
        self.enc.create_set_encoding("id_actuator", "binary", self.dimensions)
        # Create empty Program Hypervectors for training
        self.program_hvs = []

    def is_wall_west(self) -> bool:
        rob_pos = self.grid.rob_pos
        return self.map[rob_pos[0]][rob_pos[1]-1] == 1
    
    def is_wall_east(self) -> bool:
        rob_pos = self.grid.rob_pos
        return self.map[rob_pos[0]][rob_pos[1]+1] == 1

    def is_wall_north(self) -> bool:
        rob_pos = self.grid.rob_pos
        return self.map[rob_pos[0]-1][rob_pos[1]] == 1

    def is_wall_south(self) -> bool:
        rob_pos = self.grid.rob_pos
        return self.map[rob_pos[0]+1][rob_pos[1]] == 1
    
    def distance_y(self) -> int:
        rob_pos = self.grid.rob_pos
        goal_pos = self.grid.goal_pos
        return goal_pos[0] - rob_pos[0]
    
    def distance_x(self) -> int:
        rob_pos = self.grid.rob_pos
        goal_pos = self.grid.goal_pos
        return goal_pos[1] - rob_pos[1]
    
    def bind_sensor_hv(self) -> Hypervector:
        # Bind the Object Sensor HVs       
        if self.is_wall_north():
            ob1 = self.binder.bind(self.enc.encode_set("object_north"), self.enc.encode_set("id_object_north"))
        else:
            ob1 = self.binder.bind(self.enc.encode_set("object_not_north"), self.enc.encode_set("id_object_north"))
        if self.is_wall_south():
            ob2 = self.binder.bind(self.enc.encode_set("object_south"), self.enc.encode_set("id_object_south"))
        else:
            ob2 = self.binder.bind(self.enc.encode_set("object_not_south"), self.enc.encode_set("id_object_south"))
        if self.is_wall_east():
            ob3 = self.binder.bind(self.enc.encode_set("object_east"), self.enc.encode_set("id_object_east"))
        else:
            ob3 = self.binder.bind(self.enc.encode_set("object_not_east"), self.enc.encode_set("id_object_east"))
        if self.is_wall_west():
            ob4 = self.binder.bind(self.enc.encode_set("object_west"), self.enc.encode_set("id_object_west"))
        else:
            ob4 = self.binder.bind(self.enc.encode_set("object_not_west"), self.enc.encode_set("id_object_west"))
        ob = self.binder.bind(ob1, ob2, ob3, ob4)
        # Bundle the Target and Lastmove HVs
        targx = self.binder.bind(self.enc.encode_range("target_x", self.distance_x()), self.enc.encode_set("id_target_x"))
        targy = self.binder.bind(self.enc.encode_range("target_y", self.distance_y()), self.enc.encode_set("id_target_y"))
        if self.last_move == "east":
            lastmove = self.binder.bind(self.enc.encode_set("last_move_east"), self.enc.encode_set("id_last_move"))
        elif self.last_move == "west":
            lastmove = self.binder.bind(self.enc.encode_set("last_move_west"), self.enc.encode_set("id_last_move"))
        elif self.last_move == "north":
            lastmove = self.binder.bind(self.enc.encode_set("last_move_north"), self.enc.encode_set("id_last_move"))
        elif self.last_move == "south":
            lastmove = self.binder.bind(self.enc.encode_set("last_move_south"), self.enc.encode_set("id_last_move"))
        else:
            lastmove = self.binder.bind(self.enc.encode_set("last_move_none"), self.enc.encode_set("id_last_move"))
        constraints = self.bundler.bundle(targx, targy, lastmove)
        # Bind the full Sensor HVs
        sensor_encoding = self.binder.bind(ob, constraints)
        return sensor_encoding

    def add_program_hv(self, dir: int) -> None: 
        sensor_encoding = self.bind_sensor_hv()
        # Create the Actuator HVs
        if dir == 1:
            actuator = self.binder.bind(self.enc.encode_set("actuator_north"), self.enc.encode_set("id_actuator"))
        elif dir == 2:
            actuator = self.binder.bind(self.enc.encode_set("actuator_east"), self.enc.encode_set("id_actuator"))
        elif dir == 3:
            actuator = self.binder.bind(self.enc.encode_set("actuator_south"), self.enc.encode_set("id_actuator"))
        else:
            actuator = self.binder.bind(self.enc.encode_set("actuator_west"), self.enc.encode_set("id_actuator"))
        # Bind the Program Hypervector
        prog_hv = self.binder.bind(sensor_encoding, actuator)
        # Accumulate the Program Hypervector
        self.program_hvs.append(prog_hv)

    def recal_program_actuator(self) -> int:
        # Recall by "unbinding" sensors and actuator ID
        recal_hv = self.binder.bind(self.final_prog_hv, self.bind_sensor_hv())
        actuator_hv = self.binder.bind(recal_hv, self.enc.encode_set("id_actuator"))
        # Get cosine similarity for all options
        op1 = actuator_hv.cosine_similarity(self.enc.encode_set("actuator_north"))
        op2 = actuator_hv.cosine_similarity(self.enc.encode_set("actuator_east"))
        op3 = actuator_hv.cosine_similarity(self.enc.encode_set("actuator_south"))
        op4 = actuator_hv.cosine_similarity(self.enc.encode_set("actuator_west"))
        options = sorted([(op1, 1), (op2, 2), (op3, 3), (op4, 4)])        
        self.grid.add_label(f"Cosine Sim:\nN({round(op1, 3)})\nW({round(op4, 3)})\nE({round(op2, 3)})\nS({round(op3, 3)})", 11, self.last_col+1)
        return options[3][1], options

    def update_logs(self):
        if self.is_wall_west():
            self.grid.add_label("Obj West: Wall", 5, self.last_col+1)
        else:
            self.grid.add_label("Obj West: Space", 5, self.last_col+1)
        if self.is_wall_east():
            self.grid.add_label("Obj East: Wall", 6, self.last_col+1)
        else:
            self.grid.add_label("Obj East: Space", 6, self.last_col+1)
        if self.is_wall_north():
            self.grid.add_label("Obj North: Wall", 3, self.last_col+1)
        else:
            self.grid.add_label("Obj North: Space", 3, self.last_col+1)                
        if self.is_wall_south():
            self.grid.add_label("Obj South: Wall", 4, self.last_col+1)
        else:
            self.grid.add_label("Obj South: Space", 4, self.last_col+1)
        self.grid.add_label(f"Target X: {self.distance_x()}", 7, self.last_col+1)
        self.grid.add_label(f"Target Y: {self.distance_y()}", 8, self.last_col+1)
        self.grid.add_label(f"# Prog HVs: {len(self.program_hvs)}", 9, self.last_col+1)          

    def key_east(self, KeyboardEvent):
        if self.mode == "train":
            self.move_callback = self.move_robot_east
            self.add_program_hv(2)
            self.last_move = "east"
        else:
            print("Cannot manually move outside of train mode...")

    def key_west(self, KeyboardEvent):
        if self.mode == "train":
            self.move_callback = self.move_robot_west
            self.add_program_hv(4)
            self.last_move = "west"
        else:
            print("Cannot manually move outside of train mode...")

    def key_north(self, KeyboardEvent):
        if self.mode == "train":
            self.move_callback = self.move_robot_north
            self.add_program_hv(1)
            self.last_move = "north"
        else:
            print("Cannot manually move outside of train mode...")

    def key_south(self, KeyboardEvent):
        if self.mode == "train":
            self.move_callback = self.move_robot_south
            self.add_program_hv(3)
            self.last_move = "south"
        else:
            print("Cannot manually move outside of train mode...")

    def move_robot_west(self):
        rob_pos = self.grid.rob_pos
        if self.map[rob_pos[0]][rob_pos[1]-1] != 1:                
            self.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.grid.set_grid_tile(2, rob_pos[0], rob_pos[1]-1)
        else:
            print("Cannot move West into Wall...")

    def move_robot_south(self):
        rob_pos = self.grid.rob_pos
        if self.map[rob_pos[0]+1][rob_pos[1]] != 1:                
            self.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.grid.set_grid_tile(2, rob_pos[0]+1, rob_pos[1])
        else:
            print("Cannot move South into Wall...")

    def move_robot_east(self):
        rob_pos = self.grid.rob_pos
        if self.map[rob_pos[0]][rob_pos[1]+1] != 1:                
            self.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.grid.set_grid_tile(2, rob_pos[0], rob_pos[1]+1)
        else:
            print("Cannot move East into Wall...")

    def move_robot_north(self):
        rob_pos = self.grid.rob_pos
        if self.map[rob_pos[0]-1][rob_pos[1]] != 1:                
            self.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.grid.set_grid_tile(2, rob_pos[0]-1, rob_pos[1])
        else:
            print("Cannot move North into Wall...")

    def beginTrain(self):
        print("Beginning Training!")
        self.mode = "train"
        self.last_move = "none"
        self.program_hvs = []
        self.setup_hypervectors()
        self.grid.reset_grid()

    def beginRecall(self):
        print("Beginning Recall!")
        self.mode = "recal"
        self.last_move = "none"
        self.final_prog_hv = self.bundler.bundle(*self.program_hvs)
        self.grid.reset_grid()

    def recallStep(self):
        print("\tRecall Step...")
        move, options = self.recal_program_actuator()
        if move == 1:
            print(f"\t\tHeading North : {options}")
            self.move_robot_north()
        elif move == 2:
            print(f"\t\tHeading East : {options}")
            self.move_robot_east()
        elif move == 3:
            print(f"\t\tHeading South : {options}")
            self.move_robot_south()
        else:
            print(f"\t\tHeading West : {options}")
            self.move_robot_west()

    def resetBoard(self):
        print("Resetting Board!")
        self.grid.reset_grid()
        self.last_move = "none"


    def run(self):
        self.move_callback = self.move_robot_east()
        while(1):
            if self.move_callback != None:
                self.move_callback()
                self.move_callback = None
            self.update_logs()
            self.grid.update_window()

