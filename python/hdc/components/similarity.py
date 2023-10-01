import cmath
from math import cos, sin
import numpy as np
from typing import Callable


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
    # try:
    #     sim = np.dot(a, b)/(np.linalg.norm(a)*np.linalg.norm(b))
    #     return sim
    # except:
    #     print("@@@@@@ ERROR ERROR ERROR @@@@@@")
    #     print(f"sim: {sim}")
    #     print(f"a: {a}")
    #     print(f"b: {b}")
    #     return -100


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
    return np.count_nonzero(np.logical_and(a == b, a == 1)) / max(np.sum(a), np.sum(b))


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
    return np.sum(np.cos(a - b)) / a.size
    # cmp = (np.cos(a) - np.cos(b)) + ((np.sin(a) - np.sin(b)) * 1j)
    # sum = np.sum(np.cos(cmp))
    # return (sum / a.size).real
