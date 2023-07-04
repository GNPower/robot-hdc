import numpy as np

class Colours0(object):

    def __init__(self) -> None:
        self.N = 10_000

    def _hdc(self) -> np.array:
        return np.random.choice([-1,1], self.N)
    
    def _bundle(self, matrix: np.matrix) -> np.array:
        return np.sum(axis=2)
    
    def _bundle(self, *arrays: np.array) -> np.array:
        res = np.zeros(arrays[0].size, dtype=np.int32)
        for array in arrays:
            print(f"Summing arrays {res} ans {array}")
            res = np.sum(res, array, axis=0)
        return res

    def run(self) -> None:
        print(f"Running Demo: Colours - Using numpy with vector elements (-1 | 1)")
        x = self._hdc()
        y = self._hdc()
        print(f"\t Vector of length {len(x)} with sample contents {x}")
        print(f"\t Hamming distance of two random vectors is {np.sum(x == y)}")
        print()
        print(f"\t Bundling two vectors x & y with majority results in {self._bundle(x,y)}")

    