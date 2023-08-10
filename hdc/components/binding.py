import  numpy as np
from typing import Callable

BindingOp = Callable[[np.ndarray, np.ndarray], np.ndarray]


def ElementMultiplication(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    return 


def CircularConvolution(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def CircularCorrelation(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def VectorDerivedTransformation(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def TransposeVectorDerivedTransformation(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def MatrixMultiplication(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def InverseMatrixMultiplication(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def ExclusiveOr(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def Shifting(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def SegmentShifting(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def ContextDependThinning(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def ElementAngleAddition(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass


def ElementAngleSubtraction(a: np.ndarray, b: np.ndarray) -> np.ndarray:
    pass
