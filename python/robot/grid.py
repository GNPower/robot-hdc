import tkinter as tk
from typing import List, Callable
from PIL import Image, ImageTk

class Grid(object):

    def __init__(self, title: str, grid: List[List[int]], tile_size: int = 64) -> None:
        self.window = tk.Tk()
        self.window.title(title)
        self.tile_size = tile_size
        self.initial_grid = grid
        self.rob_pos = [0,0]
        self.goal_pos = [0,0]
        self.reset_grid()

    def set_grid_tile(self, val: int, row: int, col: int) -> None:
        if val == 1:
            tile = self.open_img("robot/wall.png", self.tile_size)            
        elif val == 2:
            tile = self.open_img("robot/rob.png", self.tile_size)
            self.rob_pos = [row,col]
        elif val == 3:
            tile = self.open_img("robot/goal.png", self.tile_size) 
            self.goal_pos = [row,col]
        else:
            tile = self.open_img("robot/tile.png", self.tile_size)   
        tile.grid(row = row, column = col)

    def reset_grid(self) -> None:
        for i, row in enumerate(self.initial_grid):
            for j, val in enumerate(row):    
                self.set_grid_tile(val, i, j)            

    def add_button(self, text: str, callbackref: Callable, row: int, col: int) -> None:
        button = tk.Button(self.window, text = text, command = callbackref)
        button.grid(row = row, column = col)

    def add_label(self, text: str, row: int, col: int) -> None:
        label = tk.Label(self.window, text = text)
        label.grid(row = row, column = col)

    def open_img(self, file: str, pixels: int) -> tk.Label:
        img = Image.open(file)
        img = img.resize((pixels, pixels), Image.LANCZOS)
        img = ImageTk.PhotoImage(img)
        panel = tk.Label(self.window, image=img)
        panel.image = img
        return panel
    
    def update_window(self) -> None:
        self.window.update()