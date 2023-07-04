import os
import sys

import matplotlib.pyplot as plt

SRC_PATH = os.path.abspath(".")
print(f"Source Path Is: {SRC_PATH}")
sys.path.insert(0, SRC_PATH)

from robot.demo import Demo


class RobotText(object):

    def __init__(self) -> None:
        self.demo = Demo(10_000)
        self.demo.setup_hypervectors()

    def move_robot_west(self):
        rob_pos = self.demo.grid.rob_pos
        if self.demo.map[rob_pos[0]][rob_pos[1]-1] != 1:
            self.demo.add_program_hv(4)
            self.demo.last_move = "west"
            self.demo.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.demo.grid.set_grid_tile(2, rob_pos[0], rob_pos[1]-1)
        else:
            print("Cannot move West into Wall...")

    def move_robot_south(self):
        rob_pos = self.demo.grid.rob_pos
        if self.demo.map[rob_pos[0]+1][rob_pos[1]] != 1:
            self.demo.add_program_hv(3)
            self.demo.last_move = "south"
            self.demo.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.demo.grid.set_grid_tile(2, rob_pos[0]+1, rob_pos[1])
        else:
            print("Cannot move South into Wall...")

    def move_robot_east(self):
        rob_pos = self.demo.grid.rob_pos
        if self.demo.map[rob_pos[0]][rob_pos[1]+1] != 1:
            self.demo.add_program_hv(2)
            self.demo.last_move = "east"
            self.demo.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.demo.grid.set_grid_tile(2, rob_pos[0], rob_pos[1]+1)
        else:
            print("Cannot move East into Wall...")

    def move_robot_north(self):
        rob_pos = self.demo.grid.rob_pos
        if self.demo.map[rob_pos[0]-1][rob_pos[1]] != 1:
            self.demo.add_program_hv(1)
            self.demo.last_move = "north"
            self.demo.grid.set_grid_tile(4, rob_pos[0], rob_pos[1])
            self.demo.grid.set_grid_tile(2, rob_pos[0]-1, rob_pos[1])
        else:
            print("Cannot move North into Wall...")

    def run(self):
        print(f"Robot Train starts at {self.demo.grid.rob_pos}")

        # Create the first HV encoding
        num_moves = 14
        move_order = [2, 2, 3, 3, 3, 2, 2, 3, 2, 2, 1, 2, 2, 3]

        self.move_robot_east()
        self.move_robot_east()

        self.move_robot_south()
        self.move_robot_south()
        self.move_robot_south()

        self.move_robot_east()
        self.move_robot_east()

        self.move_robot_south()

        self.move_robot_east()
        self.move_robot_east()

        self.move_robot_north()

        self.move_robot_east()
        self.move_robot_east()

        self.move_robot_south()

        self.demo.last_move = "none"
        print("")
        self.demo.final_prog_hv = self.demo.bundler.bundle(*self.demo.program_hvs)
        self.demo.grid.reset_grid()
        self.demo.program_hvs = []

        print(f"Robot Recal starts at {self.demo.grid.rob_pos}")

        # Try to recall the move
        for i in range(num_moves):
            dir, options = self.demo.recal_program_actuator()
            print(f"I think move {dir} : {options}")
            if dir == move_order[i]:
                print("\tCorrect!")
            else:
                print("\tIncorrect!")
            if dir == 1:
                self.move_robot_north()
            elif dir == 2:
                self.move_robot_east()
            elif dir == 3:
                self.move_robot_south()
            else:
                self.move_robot_west()


class DemoResults(object):

    def __init__(self) -> None:
        self.cs = [
            (1, [1.0000000000000002]),
            (2, [0.868642204694135, 0.8778046769289276]),
            (4, [0.7234339106683111, 0.7201039937781992, 0.720599743108915, 0.7224846705532143]),
            (5, [0.5564953870996158, 0.559473049687375, 0.8143776634679728, 0.9330613018324236, 0.9323321028573047]),
            (7, [0.7179839053002091, 0.6492299616001729, 0.646580139537863, 0.7769828004874001, 0.7747663039092462, 0.6557581534472647, 0.7251269072284258]),
            (10, [0.6665360197441165, 0.6328704456648271, 0.7062287098740371, 0.712314172298723, 0.7116696958104051, 0.6911926962852039, 0.767518663258482, 0.7064716554276249, 0.6919750493945768, 0.7677936831153728]),
            (14, [0.6422147870884142, 0.5988101577719713, 0.7775124693104011, 0.7095640626762584, 0.7093201114660596, 0.6620435492641422, 0.6718714331710242, 0.7786094888709785, 0.6609857664290709, 0.6711411641570141, 0.577914681205431, 0.585941990028505, 0.5801980913843562, 0.7772076819724217])
        ]
        self.avg_cs = [( self.cs[i][0], sum(self.cs[i][1]) / len(self.cs[i][1]) ) for i in range(len(self.cs))]
        self.max_cs = [( self.cs[i][0], max(self.cs[i][1]) ) for i in range(len(self.cs))]
        self.min_cs = [( self.cs[i][0], min(self.cs[i][1]) ) for i in range(len(self.cs))]

    def run(self):
        print(f"Avg. Cosine Similarity: {self.avg_cs}")
        print(f"Max Cosine Similarity: {self.max_cs}")
        print(f"Min Cosine Similarity: {self.min_cs}")
        plt.plot(*zip(*self.avg_cs), label = "Average")
        plt.plot(*zip(*self.max_cs), label = "Maximum")
        plt.plot(*zip(*self.min_cs), label = "Minumum")
        plt.xlabel("Number of Bundled Hypervectors")
        plt.ylabel("Selected Actuator Hypervector Cosine Similarity")
        plt.title("Ability to Recover Hypervectors")
        plt.show()



if __name__ == '__main__':
    if sys.argv[1] == "text":
    # Text based
        demo = RobotText()
        demo.run()
    elif sys.argv[1] == "live":
    # Live interactive
        demo = Demo(10_000)
        demo.run()
    elif sys.argv[1] == "plot":
    # Similarity results
        demo = DemoResults()
        demo.run()