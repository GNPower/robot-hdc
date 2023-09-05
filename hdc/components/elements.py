import numpy as np
from math import sqrt, ceil, pi
import random
from typing import Callable, Union


def UniformBipolar(dimensions: int) -> np.ndarray:
    """UniformBipolar X∈R, X_i ~ U(-1,1)

    Uniform distribution of real numbers between -1 and 1

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :return: hypervector
    :rtype: np.ndarray
    """
    return np.random.uniform(-1,1,dimensions)


def BernoulliBiploar(dimensions: int) -> np.ndarray:
    """BernoulliBiploar X∈Z, X_i ~ B(0.5)*2 - 1

    Bernoulli distribution of bipolar numbers, either -1 or 1

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :return: hypervector
    :rtype: np.ndarray
    """
    # return (np.random.binomial(size=dimensions, n=1, p= 0.5)*2) - 1
    return np.random.choice([-1,1], dimensions, p=[0.5, 0.5])


def BernoulliBinary(dimensions: int) -> np.ndarray:
    """BernoulliBinary X∈{0,1}, X_i ~ B(0.5)

    Bernoulli distribution of binary numbers, either 0 or 1

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :return: hypervector
    :rtype: np.ndarray
    """
    return np.random.binomial(size=dimensions, n=1, p= 0.5)


def BernoulliSparse(dimensions: int, probability: float = None) -> np.ndarray:
    """BernoulliSparse X∈{0,1}, X_i ~ B(p << 1)

    Bernoulli distribution of binary numbers, either 0 or 1 with variable 
    probability. If undefined probability is given as p = 1/sqrt(dimensions), 
    which creates a sparsely populated array

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :param probability: probability of the Bernoulli distribution, defaults to 1/sqrt(d)
    :type probability: float, optional
    :return: hypervector
    :rtype: np.ndarray
    """
    if probability is None:
        probability = 1/sqrt(dimensions)
    return np.random.binomial(size = dimensions, n = 1, p = probability)


def NormalReal(dimensions: int) -> np.ndarray:
    """NormalReal X∈R, X_i ~ N(0, 1/d)

    Normal distribution of real numbers with mean 0 and variance 1/d, 
    where d is the dimension of the hypervector

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :return: hypervector
    :rtype: np.ndarray
    """
    sigma = sqrt(1/dimensions)
    return np.random.normal(0, sigma, dimensions)


def SparseSegmented(dimensions: int, probability: float = None) -> np.ndarray:
    """SparseSegmented X∈{0,1}, X_i ~ B(p << 1)

    Sparsely segmented binary numbers, either 0 or 1 with variable 
    probability. If undefined probability is given as p = 1/sqrt(dimensions). 
    Hypervector is split into s, dimensions * probability, segments. Each segment 
    populated with exactly 1 non-zero element uniformly distributed throughout the 
    segment.

    NOTE: Since s = dimensions * probability is not garunteed to evenly divide into 
    the hypervector dimensions, the segment, s, is rounded up and the final hypervector trimmed. 
    This means the non-zero value in the last segment may be trimmed and not be present in the 
    final hypervector.

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :param probability: probability of the Bernoulli distribution, defaults to 1/sqrt(d)
    :type probability: float, optional
    :return: hypervector
    :rtype: np.ndarray
    """
    if probability is None:
        probability = 1/sqrt(dimensions)
    s = ceil(dimensions * probability)
    seg_d = ceil(dimensions/s)
    hypervector = np.zeros(0, dtype = np.int8)
    for i in range(0,s):
        vector = np.zeros(seg_d, dtype = np.int8)
        index = random.randrange(seg_d)
        vector[index] = 1
        hypervector = np.append(hypervector, vector)
    return hypervector[:dimensions]


def UniformAngles(dimensions: int) -> np.ndarray:
    """UniformAngles θ∈R, θ_i ~ U(-pi, pi)

    Uniformly distributed angles from -pi to pi. Useful for a 
    complex hypervector representation X∈C, X_i = e^(i*θ). In this 
    case, the complex vector is assumed to be on the unit circle 
    (length one) so we only need to store the real angle, θ, and 
    the hypervector X can be computed as needed from the hypervector θ.

    :param dimensions: number of dimensions in the vector
    :type dimensions: int
    :return: hypervector
    :rtype: np.ndarray
    """
    return np.random.uniform(-pi,pi,dimensions)