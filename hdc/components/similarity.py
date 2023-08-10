import cmath
from math import cos, sin
import numpy as np
from typing import Callable

# SimilarityOp = Callable[[np.ndarray, np.ndarray], np.ndarray]


def CosineSimilarity(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """CosineSimilarity Cosine Similarity of two vectors

    cos(θ) = ( A dot B ) / ( norm(A) * norm(B) )


    :param a: hypervector A
    :type a: np.ndarray
    :param b: hypervector B
    :type b: np.ndarray
    :return: similarity hypervector
    :rtype: np.ndarray
    """
    return np.dot(a, b)/(np.linalg.norm(a)*np.linalg.norm(b)) 


def HammingDistance(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """HammingDistance Hamming Distance of two vectors

    Counts the number of elements in the hypervectors where A[i] != B[i]. 
    Result is normalized to the size of the hypervector so it is always in 
    the range [0,1].

    :param a: hypervector A
    :type a: np.ndarray
    :param b: hypervector B
    :type b: np.ndarray
    :return: similarity hypervector
    :rtype: np.ndarray
    """
    return 1 - (np.count_nonzero(a != b) / a.size)


def Overlap(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """Overlap Overlap of two vectors

    Counts the number of elements in the hyypervectors where both A[i] and 
    B[i] are 1. Useful for sparce hypervectors. Result is normalized to the 
    max number of nonzero elements in the hypervectors so it is always in the 
    range [0,1].

    :param a: hypervector A
    :type a: np.ndarray
    :param b: hypervector B
    :type b: np.ndarray
    :return: similarity hypervector
    :rtype: np.ndarray
    """
    return np.count_nonzero((a == 1) and (b == 1)) / max(np.sum(a), np.sum(b))


def AngleDistance(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    """AngleDistance Angle Distance of two hypervectors

    Calculates the average angular distance of two complex hypervectors 
    of unit length. Results are normalized to the size of the hypervectors 
    so it is always in the range [0,1].

    :param a: hypervector A
    :type a: np.ndarray
    :param b: hypervector B
    :type b: np.ndarray
    :return: similarity hypervector
    :rtype: np.ndarray
    """
    sum = 0
    for i in range(a.size):
        real = cos(a[i])
        im = sin(a[i])
        ac = complex(real, im)
        real = cos(b[i])
        im = sin(b[i])
        bc = complex(real, im)
        sum += cmath.cos(ac, bc)
    return real(sum / a.size)
