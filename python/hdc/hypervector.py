#!/bin/env python

from __future__ import annotations
from abc import ABC, abstractmethod
from functools import partial
from math import ceil
from typing import Callable, Union, Literal, get_args

import numpy as np
import scipy.stats
from hdc.components.binding import CircularConvolution, CircularCorrelation, ContextDependThinning, ElementAngleAddition, ElementAngleSubtraction, ElementMultiplication, ExclusiveOr, InverseMatrixMultiplication, MatrixMultiplication, SegmentShifting, Shifting, TransposeVectorDerivedTransformation, VectorDerivedTransformation
from hdc.components.bundling import AnglesOfElementAddition, Disjunction, ElementAddition, ElementAdditionBipolarThreshold, ElementAdditionCut, ElementAdditionNormalized, ElementAdditionBinaryThreshold
from hdc.components.elements import BernoulliBinary, BernoulliBiploar, BernoulliSparse, NormalReal, SparseSegmented, UniformAngles, UniformBipolar
from hdc.components.similarity import AngleDistance, CosineSimilarity, HammingDistance, Overlap
from hdc.components.thinning import NoThin

from hdc.exceptions import DimensionsNotMatchingError, DtypesNotMatchingError, RaiseNotImplementedError
from hdc.components import HypervectorEncoding


class Encoding(object):
    """A Hypervector representation in Python

    The Hypervector class is an abstract class implementing
    all the basic functionality of a Hypervector. It is left 
    up to specific implementarions of the Hypervector to 
    provide functionalities like setting a non-zero initial value.

    Args:
        ABC (metaclass): Abstract Base Class from Python's abc library
    """    
    
    def __init__(self, encoding: HypervectorEncoding, dimension: int = 10_000) -> None:
        """A Hypervector representation in Python

        This is an abstract class to represent a Hypervector
        and its basic operations, it is left to the child class
        to implement or override this base implementation 

        Args:
            dimension (int): The number of dimensions in the Hypervector (ex. 1k, 10k)
            encoding (HypervectorEncoding): The encoding to use for this hypervector
        """
        self.dimension = dimension

        if "dtype" in encoding:            
            self.__dtype          =  encoding["dtype"]
        else:
            self.__dtype = None
        self.__element_gen    =  encoding["elements"]
        self.__similarity_op  =  encoding["similarity"]
        self.__bundling_op    =  encoding["bundling"]
        self.__thinning_op    =  encoding["thinning"]
        self.__binding_op     =  encoding["binding"]
        self.__unbinding_op   =  encoding["unbinding"]

    def generate(self, dimensions: int = None):
        if dimensions == None:
            dimensions = self.dimension
        return self.__element_gen(dimensions, self.__dtype)

    def similarity(self, hvA: np.ndarray, hvB: np.ndarray) -> float:
        return self.__similarity_op(hvA, hvB)

    def bundle(self, *hypervectors: np.ndarray) -> np.ndarray:
        return self.__bundling_op(*hypervectors)

    def thin(self, hypervector: np.ndarray) -> np.ndarray:
        return self.__thinning_op(hypervector)

    def bind(self, *hypervectors: np.ndarray) -> np.ndarray:
        return self.__binding_op(hypervectors)

    def unbind(self, *hypervectors: np.ndarray) -> np.ndarray:
        return self.__unbinding_op(hypervectors)


class MAP_C(Encoding):
    encoding = {
        "dtype": np.float64,
        "elements": UniformBipolar,
        "similarity": CosineSimilarity,
        "bundling": ElementAdditionCut,
        "thinning": NoThin,
        "binding": ElementMultiplication,
        "unbinding": ElementMultiplication,
        "preformat": None,
        "postformat": None,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class MAP_I(Encoding):
    encoding = {
        "dtype": np.int8,
        "elements": BernoulliBiploar,
        "similarity": CosineSimilarity,
        "bundling": ElementAddition,
        "thinning": NoThin,
        "binding": ElementMultiplication,
        "unbinding": ElementMultiplication,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class HRR(Encoding):
    encoding = {
        "dtype": np.float16,
        "elements": NormalReal,
        "similarity": CosineSimilarity,
        "bundling": ElementAdditionNormalized,
        "thinning": NoThin,
        "binding": CircularConvolution,
        "unbinding": CircularCorrelation,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class VTB(Encoding):
    encoding = {
        "elements": NormalReal,
        "similarity": CosineSimilarity,
        "bundling": ElementAdditionNormalized,
        "thinning": NoThin,
        "binding": VectorDerivedTransformation,
        "unbinding": TransposeVectorDerivedTransformation,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class MBAT(Encoding):
    encoding = {
        "elements": NormalReal,
        "similarity": CosineSimilarity,
        "bundling": ElementAdditionNormalized,
        "thinning": NoThin,
        "binding": MatrixMultiplication,
        "unbinding": InverseMatrixMultiplication,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class MAP_B(Encoding):
    encoding = {
        "elements": BernoulliBiploar,
        "similarity": CosineSimilarity,
        "bundling": ElementAdditionBipolarThreshold,
        "thinning": NoThin,
        "binding": ElementMultiplication,
        "unbinding": ElementMultiplication,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class BSC(Encoding):
    encoding = {
        "elements": BernoulliBinary,
        "similarity": HammingDistance,
        "bundling": ElementAdditionBinaryThreshold,
        "thinning": NoThin,
        "binding": ExclusiveOr,
        "unbinding": ExclusiveOr,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class BSDC_CDT(Encoding):
    encoding = {
        "elements": BernoulliSparse,
        "similarity": Overlap,
        "bundling": Disjunction,
        "thinning": NoThin,
        "binding": ContextDependThinning,
        "unbinding": RaiseNotImplementedError,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class BSDC_S(Encoding):
    encoding = {
        "elements": BernoulliSparse,
        "similarity": Overlap,
        "bundling": Disjunction,
        "thinning": NoThin, # NOTE: Optional thinning
        "binding": Shifting,
        "unbinding": Shifting,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class BSDC_SEG(Encoding):
    encoding = {
        "elements": SparseSegmented,
        "similarity": Overlap,
        "bundling": Disjunction,
        "thinning": NoThin, # NOTE: Optional thinning
        "binding": SegmentShifting,
        "unbinding": SegmentShifting,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)


class FHRR(Encoding):
    encoding = {
        "elements": UniformAngles,
        "similarity": AngleDistance,
        "bundling": AnglesOfElementAddition,
        "thinning": NoThin,
        "binding": ElementAngleAddition,
        "unbinding": ElementAngleSubtraction,
    }

    def __init__(self, dimension: int = 10_000) -> None:
        super().__init__(self.encoding, dimension)
