from typing import Callable, List, Union

import numpy as np

SimpleElement = Callable[[int], np.ndarray]
ProbabailisticElement = Callable[[int, float], np.ndarray]
HypervectorElement = Union[SimpleElement, ProbabailisticElement]
SimilarityOp = Callable[[np.ndarray, np.ndarray], np.ndarray]
ThinningOp = Callable[[np.ndarray], np.ndarray]
BundliongOp = Callable[[List[np.ndarray]], np.ndarray]
BindingOp = Callable[[List[np.ndarray]], np.ndarray]


HypervectorEncoding = {
    "elements": HypervectorElement,
    "similarity": SimilarityOp,
    "bundling": BundliongOp,
    "thinning": Union[ThinningOp, None],
    "binding": BindingOp,
    "unbinding": BindingOp,
}


def __GetHypervectorAsList(*hypervectors: np.ndarray) -> List[np.ndarray]:
    shape = len(hypervectors[0].shape)
    if shape == 1:
        return hypervectors
    elif shape == 2:
        hvs = hypervectors[0]
        return hvs
    else:
        raise TypeError("Only a set of 1D arrays or a single 2D array is supported for bundling")