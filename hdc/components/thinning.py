from math import ceil
import cmath
import numpy as np
import scipy
from numpy.typing import ArrayLike
from typing import Callable


def NoThin(hypervector: np.ndarray) -> np.ndarray:
    return hypervector


def Random(hypervector: np.ndarray, density: float = 0.5) -> np.ndarray:
    """Random Keeps randomly selected nonzero elements of hypervector

    Sets randomly selected nonzero elements of a hypervector 
    to 1 subject to a given hypervector density. All other 
    elements are set to zero. If the hypervector already 
    meets the density constraint the identical hypervector 
    is returned.

    :param hypervector: The hypervector to thin
    :type hypervector: np.ndarray
    :param density: Required density of the output hypervector, defaults to 0.5
    :type density: float, optional
    :return: Thinned hypervector
    :rtype: np.ndarray
    """
    num_nonzero = ceil(hypervector.size * density)
    indices = np.nonzero(hypervector)[0]
    if num_nonzero > indices.size:
        return hypervector
    random_indices = [indices[i] for i in np.random.choice(len(indices), size=num_nonzero, replace=False)]
    hypervector.fill(0)
    hypervector[random_indices] = 1
    return hypervector


def Sumset(hypervector: np.ndarray, density: float = 0.5) -> np.ndarray:
    """Sumset Sets largest values of hypervector to 1 subject to density constraints

    Sets the n largest elements in the hypervector to 1, all other elements 
    to 0. n is selected as len(hypervector) * density. If multiple elememts 
    are the same value, the lower indices in the hypervector will be selected 
    first.

    :param hypervector: The hypervector to thin
    :type hypervector: np.ndarray
    :param density: Required density of the output hypervector, defaults to 0.5
    :type density: float, optional
    :return: Thinned hypervector
    :rtype: np.ndarray
    """
    num_nonzero = ceil(hypervector.size * density)
    # Gets the indices of the largest values in the array
    indices = np.argpartition(hypervector, -num_nonzero)[-num_nonzero:]
    hypervector.fill(0)
    # Sets all selected indices of the hypervector to 1
    hypervector[indices] = 1
    return hypervector


def SegmentedSumset(hypervector: np.ndarray, density: float = 0.5) -> np.ndarray:
    # TODO
    pass


def SegmentedRandom(hypervector: np.ndarray, density: float = 0.5) -> np.ndarray:
    # TODO
    pass