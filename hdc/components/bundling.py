from math import cos, sin
import cmath
import numpy as np
import scipy
from numpy.typing import ArrayLike
from typing import Callable

BundliongOp = Callable[[np.ndarray, np.ndarray], np.ndarray]

def ElementAddition(*hypervectors: np.ndarray) -> np.ndarray:
    shape = len(hypervectors[0].shape)
    if shape == 1:
        return sum(hypervectors)
    elif shape == 2:
        hvs = hypervectors[0]
        return sum(hvs)
    else:
        raise TypeError("Only a set of 1D arrays or a single 2D array is supported for bundling")


def ElementAdditionCut(*hypervectors: np.ndarray, min: ArrayLike = -1, max: ArrayLike = 1) -> np.ndarray:
    shape = len(hypervectors[0].shape)
    if shape == 1:
        sum = sum(hypervectors)
        return np.clip(sum, min, max)
    elif shape == 2:
        hvs = hypervectors[0]
        sum = sum(hvs)
        return np.clip(sum, min, max)      
    else:
        raise TypeError("Only a set of 1D arrays or a single 2D array is supported for bundling")


def ElementAdditionNormalized(*hypervectors: np.ndarray) -> np.ndarray:
    shape = len(hypervectors[0].shape)
    if shape == 1:
        sum = sum(hypervectors)
        norm = np.linalg.norm(sum)
        return np.divide(sum, norm)   
    elif shape == 2:
        hvs = hypervectors[0]
        sum = sum(hvs)
        norm = np.linalg.norm(sum)
        return np.divide(sum, norm)         
    else:
        raise TypeError("Only a set of 1D arrays or a single 2D array is supported for bundling")


def ElementAdditionThreshold(*hypervectors: np.ndarray, min: ArrayLike = 0, max: ArrayLike = 1) -> np.ndarray:
    shape = len(hypervectors[0].shape)
    if shape == 1:
        sum = sum(hypervectors)
        threshold = len(hypervectors) / 2
        return np.where(sum >= threshold, max, min)
    elif shape == 2:
        hvs = hypervectors[0]
        sum = sum(hvs)
        threshold = len(hvs) / 2
        return np.where(sum >= threshold, max, min)     
    else:
        raise TypeError("Only a set of 1D arrays or a single 2D array is supported for bundling")


def Disjunction(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    return np.count_nonzero((a == 1) or (b == 1))


def DisjunctionThinned(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    # TODO: Look up context dependant thinning -- Rachkovskij and Kussul (2001)
    return np.count_nonzero((a == 1) or (b == 1))


def AnglesOfElementAddition(a: np.ndarray, b: np.ndarray)  -> np.ndarray:
    result = np.zeros(a.size)
    for i in range(a.size):
        real = cos(a[i])
        im = sin(a[i])
        ac = complex(real, im)
        real = cos(b[i])
        im = sin(b[i])
        bc = complex(real, im)
        res = ac + bc
        result[i] = cmath.polar(res)[1]
    return result
