import numpy as np

from hdc.components import HypervectorEncoding


class HVEncoder(object):

    def __init__(self, dimension: int, encoding: HypervectorEncoding) -> None:
        """A Hypervector representation in Python

        This is an abstract class to represent a Hypervector
        Encoder and its basic operations.

        Args:
            dimension (int): The number of dimensions in the Hypervector (ex. 1k, 10k)
            encoding (HypervectorEncoding): The encoding to use for this hypervector
        """
        self.dimension = dimension

        self.element_gen =  encoding["elements"]
        self.similarity_op  =  encoding["similarity"]
        self.bundling_op    =  encoding["bundling"]
        self.thinning_op    =  encoding["thinning"]
        self.binding_op     =  encoding["binding"]
        self.unbinding_op   =  encoding["unbinding"]

    
    def GenerateHypervectorArray(self) -> np.ndarray:
        return self.element_gen()
    

    def Similarity(self, hvA: np.ndarray, hvB: np.ndarray) -> float:
        return self.similarity_op(hvA, hvB)
    

    def Bundle(self, *hypervectors: np.ndarray) -> np.ndarray:
        return self.bundling_op(hypervectors)
    

    def Bind(self, *hypervectors: np.ndarray) -> np.ndarray:
        return self.binding_op(hypervectors)
    

    def Unbind(self, *hypervectors: np.ndarray) -> np.ndarray:
        return self.unbinding_op(hypervectors)
