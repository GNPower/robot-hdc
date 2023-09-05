from math import pi, sqrt
import  numpy as np
from typing import Callable, List

from hdc.components import __GetHypervectorAsList


# TODO: Remaining -- 7

def ElementMultiplication(*hypervectors: np.ndarray) -> np.ndarray:
    hvs = __GetHypervectorAsList(*hypervectors)
    return np.multiply.reduce(hvs)


def CircularConvolution(*hypervectors: np.ndarray) -> np.ndarray:
    hvs = __GetHypervectorAsList(*hypervectors)
    res = np.convolve(hvs[0], hvs[1])
    for i in range(2, len(hvs)):
        res = np.convolve(res, hvs[i])
    return res


def CircularCorrelation(*hypervectors: np.ndarray) -> np.ndarray:
    hvs = __GetHypervectorAsList(*hypervectors)
    res = np.correlate(hvs[0], hvs[1])
    for i in range(2, len(hvs)):
        res = np.correlate(res, hvs[i])
    return res


def __VTBGetYPrime(y: np.ndarray) -> np.matrix:
    """__VTBGetYPrime Gets the Vy matrix used for VTB

    Calculates the Vy matrix as follows:

    Vy =  | Vy'  0    0 |
          | 0    Vy'  0 |
          | 0    0    ..|

    Vy' = d^(1/4) * | y_1       y_2       ...  y_d'  |
                    | y_d'+1    y_d'+2    ...  y_2d' |
                    |  :          :       ...   :    |
                    | y_d-d'+1  y_d-d'+2  ...  y_d   |


    :param y: The hypervector for which to calculate Vy from
    :type y: np.ndarray
    :return: Vy matrix for use in VTB
    :rtype: np.matrix
    """
    d_prime = int(sqrt(y.size))
    d_quart = pow(y.size, 0.25)
    Z_prime = np.zeros([d_prime, d_prime])
    V_prime = np.asarray([[y[i*d_prime+j] for j in range(d_prime)] for i in range(d_prime)])
    V_y = d_quart * np.block([[V_prime if i == j else Z_prime for i in range(d_prime)] for j in range(d_prime)])
    return V_y


def VectorDerivedTransformation(*hypervectors: np.ndarray) -> np.ndarray:
    """VectorDerivedTransformation Vector-Derived Transform Binding

    Binds vectors following the equation B_v(y,x) = V_y*x
    V_y is a matrix calculated using the function __VTBGetYPrime(y).
    Binding of multiple vectors [x1, x2, x3, ..., xn] is handled with 
    the following equation: B_v(x1,x2,x3,...,xn) = B_v(B_v(B_v(B_v(x1,x2),x3),...),xn)
    B_v(x1,x2,x3,...,xn) = V_xn * V_xn-1 * ... * V_x3 * V_x2 * x1

    :return: The bound vector using VTB
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    Vy_list = [__VTBGetYPrime(hvs[i]) for i in range(1,len(hvs))][::-1]
    result = Vy_list[0]
    for i in range(1, len(Vy_list)):
        result = np.dot(result, Vy_list[i])
    x_m = np.asmatrix(hvs[0]).T
    result = np.squeeze(np.asarray(result @ x_m))


def TransposeVectorDerivedTransformation(*hypervectors: np.ndarray) -> np.ndarray:
    """TransposeVectorDerivedTransformation Pseudo-Inverse Vector-Derived Transform Binding

    Unbinds vectors following the equation B+_v(y,x) = V_y'*x (where ' is the matrix transpose)
    V_y' is a matrix calculated using the function __VTBGetYPrime(y) and then transposed.
    Unbinding of multiple vectors [x1, x2, x3, ..., xn] is handled with 
    the following equation: B+_v(x1,x2,x3,...,xn) = B+_v(B+_v(B+_v(B+_v(x1,x2),x3),...),xn)
    B_v(x1,x2,x3,...,xn) = V_xn' * V_xn-1' * ... * V_x3' * V_x2' * x1

    :return: The unbound vector using pseudo-inverse VTB
    :rtype: np.ndarray
    """
    hvs = __GetHypervectorAsList(*hypervectors)
    Vy_list = [__VTBGetYPrime(hvs[i]).T for i in range(1,len(hvs))][::-1]
    result = Vy_list[0]
    for i in range(1, len(Vy_list)):
        result = np.dot(result, Vy_list[i])
    x_m = np.asmatrix(hvs[0]).T
    result = np.squeeze(np.asarray(result @ x_m))


def MatrixMultiplication(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO
    pass


def InverseMatrixMultiplication(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO
    pass


def ExclusiveOr(*hypervectors: np.ndarray) -> np.ndarray:
    hvs = __GetHypervectorAsList(*hypervectors)
    return np.bitwise_xor.reduce(hvs)


def Shifting(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO
    pass


def SegmentShifting(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO
    pass


def ContextDependThinning(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO
    pass


def ElementAngleAddition(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO: currently limiting to 0->2pi, should I do -pi->pi instead??
    hvs = __GetHypervectorAsList(*hypervectors)
    sum = np.add.reduce(hvs)
    return np.mod(sum, 2*pi)


def ElementAngleSubtraction(*hypervectors: np.ndarray) -> np.ndarray:
    # TODO: currently limiting to 0->2pi, should I do -pi->pi instead??
    hvs = __GetHypervectorAsList(*hypervectors)
    sum = np.subtract.reduce(hvs)
    return np.mod(sum, 2*pi) 
