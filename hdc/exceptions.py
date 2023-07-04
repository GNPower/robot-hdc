import numpy as np

class DtypesNotMatchingError(Exception):
    """Exception raised when two Hypervectors don't have matching dtypes

    Attributes:
        dtype -- the offending dtype, which does not match
        message -- explanation of the error
    """
    def __init__(self, dtype: np.dtype, message: str = None) -> None:
        self.dtype = dtype
        if message:
            self.message = message
        else:
            self.message = f"dtype {np.dtype} does not match the dtype of first Hypervector"
        super().__init__(self.message)


class DimensionsNotMatchingError(Exception):
    """Exception rainsed when two Hypervectors don't have matching dimensions

    Attributes:
        dimension -- the offending dimension, which does not match
        message -- explaination of the error
    """

    def __init__(self, dimension: int, message: str = None) -> None:
        self.dimension = dimension
        if message:
            self.message = message
        else:
            self._message = f"dimension {dimension} does not match the dimension of first Hypervector"
        super().__init__(self.message)