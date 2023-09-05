from math import cos, sin
import cmath
import numpy as np
import scipy
from numpy.typing import ArrayLike
from typing import Callable, List

from hdc.components import __GetHypervectorAsList


def ElementAddition(*hypervectors: np.ndarray) -> np.ndarray:
    """ElementAddition Elementwise addition of Hypervectors

    Elementwise addition of any number of hypervectors, passed 
    in either as independant function parameters or a list of 
    hypervectors as a single function input.

    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    return np.add.reduce(hvs)


def ElementAdditionCut(*hypervectors: np.ndarray, min: ArrayLike = -1, max: ArrayLike = 1) -> np.ndarray:
    """ElementAdditionCut Elementwise addition if Hypervectors with Cutting

    Elementwise addition with cutting of any number of hypervectors, 
    in either as independant function parameters or a list of 
    hypervectors as a single function input. Cutting limits the 
    output of the element addition from min and max inputs to the 
    function. This cutting is done only once after the full sum 
    is calculated.

    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :param min: Minimum element value of the output hypervector, defaults to -1
    :type min: ArrayLike, optional
    :param max: Maximum element value of the output hypervector, defaults to 1
    :type max: ArrayLike, optional
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    sum = np.add.reduce(hvs)
    return np.clip(sum, min, max)      


def ElementAdditionNormalized(*hypervectors: np.ndarray) -> np.ndarray:
    """ElementAdditionNormalized Elementwise addition normalized to unit length

    Elementwise addition with normalization of any number of hypervectors, 
    in either as independant function parameters or a list of 
    hypervectors as a single function input. Normalization scales 
    the output hypervector to unit length (one). This normalization 
    is done only once after the full sum is calculated.

    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    sum = np.add.reduce(hvs)
    norm = np.linalg.norm(sum)
    return np.divide(sum, norm)         


def ElementAdditionBinaryThreshold(*hypervectors: np.ndarray, min: ArrayLike = 0, max: ArrayLike = 1) -> np.ndarray:
    """ElementAdditionThreshold Elementwise addition with thresholded binary output

    Elementwise addition with thresholded binary output of any 
    number of hypervectors, either as independant function 
    parameters or a list of hypervectors as a single function 
    input. Thresholding adds all the input hypervectors 
    together and for each element, if it is greater than 
    half the number of hypervectors passed in, sets the 
    output element to max, otherwise sets the element to
    min.

    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :param min: Value of the output hypervector element if it fails the threshold, defaults to 0
    :type min: ArrayLike, optional
    :param max: Value of the output hypervector element if it passes the threshold, defaults to 1
    :type max: ArrayLike, optional
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    sum = np.add.reduce(hvs)
    threshold = len(hvs) / 2
    return np.where(sum >= threshold, max, min)


def ElementAdditionBipolarThreshold(*hypervectors: np.ndarray, min: ArrayLike = -1, max: ArrayLike = 1) -> np.ndarray:
    """ElementAdditionThreshold Elementwise addition with thresholded binary output

    Elementwise addition with thresholded binary output of any 
    number of hypervectors, either as independant function 
    parameters or a list of hypervectors as a single function 
    input. Thresholding adds all the input hypervectors 
    together and for each element, if it is greater than 
    half the number of hypervectors passed in, sets the 
    output element to max, otherwise sets the element to
    min.

    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :param min: Value of the output hypervector element if it fails the threshold, defaults to 0
    :type min: ArrayLike, optional
    :param max: Value of the output hypervector element if it passes the threshold, defaults to 1
    :type max: ArrayLike, optional
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    sum = np.add.reduce(hvs)
    return np.where(sum >= 0, max, min)


def Disjunction(*hypervectors: np.ndarray) -> np.ndarray:
    """Disjunction Elementwise XOR with binary output

    Elementwise XOR with binary output of any number 
    of hypervectors, either as independant function 
    parameters or a list of hypervectors as a single 
    function input. All hypervectors are added together 
    and for each element, if its value is greater or equal 
    to one, the output is set to one, otherwise it is set 
    to zero.


    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    return np.bitwise_xor.reduce(hvs)   


def AnglesOfElementAddition(*hypervectors: np.ndarray)  -> np.ndarray:
    """AnglesOfElementAddition Adds angles of complex hypervectors discarding magnitude

    Adds the angles of any number of complex hypervectors, 
    either as independant function parameters or a list of 
    hypervectors as a single input. Hypervectors are assumed 
    to be complex where the angles are stored. Hypervectors 
    are added and their resulting angles returned. Magnitudes 
    are discarded as they are assumed fixed to unit length.

    :param *hypervectors: Input hypervectors either as a list or independant inputs
    :type *hypervectors: np.ndarray
    :raises TypeError: Only a set of 1D arrays or a single 2D array is supported for bundling
    :return: bundled hypervector
    :rtype: np.ndarray
    """
    # TODO: Do I have to limit vector output to 0->2pi, -pi->pi, or not at all??
    hvs = __GetHypervectorAsList(*hypervectors)
    real = np.cos(hvs).sum(axis = 0)
    im = np.sin(hvs).sum(axis = 0)
    theta = np.arctan2(im, real)
    return theta
