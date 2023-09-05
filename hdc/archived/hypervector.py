#!/bin/env python

from __future__ import annotations
from abc import ABC, abstractmethod
from math import ceil
from typing import Union, Literal, get_args

import numpy as np
import scipy.stats

from hdc.exceptions import DimensionsNotMatchingError, DtypesNotMatchingError


_VECTOR_TYPES = Literal["bipolar", "binary", "int"]

class Hypervector(ABC):
    """A Hypervector representation in Python

    The Hypervector class is an abstract class implementing
    all the basic functionality of a Hypervector. It is left 
    up to specific implementarions of the Hypervector to 
    provide functionalities like setting a non-zero initial value.

    Args:
        ABC (metaclass): Abstract Base Class from Python's abc library
    """    
    
    def __init__(self, dimension: int, type: _VECTOR_TYPES) -> None:
        """A Hypervector representation in Python

        This is an abstract class to represent a Hypervector
        and its basic operations, it is left to the child class
        to implement or override this base implementation 

        Args:
            dimension (int): The number of dimensions in the Hypervector (ex. 1k, 10k)
            depth (int): The depth of each dimension of the Hypervector in bits (ex. 1, 32)
        """
        options = get_args(_VECTOR_TYPES)
        if type not in options:
            raise ValueError("Invalid bundle_mode. Expected one of %s" % options)        
        self.dimension = dimension
        self.type = type
        self.dt = np.int32
        self.hv = np.zeros(self.dimension, dtype=self.dt)
        self._generate()


    @classmethod
    @abstractmethod
    def _generate(self) -> None:
        """Generate the initial contents of the Hypervector

        The Hypervector is available in self.hv and is set to all zeros.

        The numpy datatype for the Hypervector is available in self.dt,
        this is the smallest number of bytes needed to represent the 
        numbner of bits given in self.depth.

        Default funtionality is to set all dimensions to zero.
        """
        pass

    def _set(self, vector: np.ndarray, offset: int = 0) -> None:
        """Sets the contents of the Hypervector directly.

        WARNING: Do not use this method direcly unless
        you know what you are doing. This is meant to be 
        used internally by the dunder methods of this function

        Args:
            vector (np.array): _description_
        """
        self_end = vector.shape[0] + offset
        vec_end = vector.shape[0]
        if self_end > self.hv.shape[0]:
            self_end = self.hv.shape[0]
            vec_end = self.hv.shape[0] - offset
        self.hv[offset:self_end] = vector[0:vec_end]

    def __str__(self) -> str:
        """Implementation of __str__

        Returns the internal array's __str__
        method directly.

        Returns:
            str: String representation of the Hypervector
        """
        return self.hv.__str__()
    
    def __getitem__(self, index: Union(int, slice)) -> Hypervector:
        """Implementation of __getitem__

        Supports indexing and slicing of Hypervectors using
        standard Python notation (e.x. a[0], a[1:10], a[:10], etc.)

        Args:
            index (Union(int, slice)): Either the index or slice to return

        Returns:
            Hypervector: The resultant Hypervector
        """
        if type(index) == int:
            res = HV_Zero(1)
            res_hv = self.hv[index]
            res._set(res_hv)
            return res
        if type(index) == slice:
            res_hv = self.hv[index.start:index.stop]
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res

    def __mul__(self, value: Hypervector) -> Hypervector:
        """Hypervector multiplication

        Allows the use of  a * b where a,b are Hypervectors.

        WARNING: Hypervectors must have the same np.dtype and dimension
        for this function to be defined.

        Args:
            value (Hypervector): Second Hypervector to multiply

        Returns:
            Hypervector: The resultant Hypervector
        """
        if self.dt != value.dt:
            raise DtypesNotMatchingError(value.dt)
        if self.dimension != value.dimension:
            raise DimensionsNotMatchingError(value.dimension)
        res = HV_Zero(self.dimension)
        res_hv = np.multiply(self.hv, value.hv)
        res._set(res_hv)
        return res
    
    def __add__(self, value: Hypervector) -> Hypervector:
        """Hypervector addition

        Allows the use of  a + b where a,b are Hypervectors.

        WARNING: Hypervectors must have the same np.dtype and dimension
        for this function to be defined.

        Args:
            value (Hypervector): Second Hypervector to add

        Returns:
            Hypervector: The resultant Hypervector
        """
        if self.dt != value.dt:
            raise DtypesNotMatchingError(value.dt)
        if self.dimension != value.dimension:
            raise DimensionsNotMatchingError(value.dimension)
        res = HV_Zero(self.dimension)
        res_hv = np.add(self.hv, value.hv)
        res._set(res_hv)
        return res
    
    def __lshift__(self, value: int) -> Hypervector:
        """Hypervector left shift

        Allows the use of  a << b where a is a Hypervector, b is an integer.
        Shifts are circular, so any dimension shifted out will appear at the 
        beginning of the Hypervector

        Args:
            value (int): The amount to shift by

        Returns:
            Hypervector: The resultant Hypervector
        """
        res = HV_Zero(self.dimension)
        res_hv = np.roll(self.hv, -value)
        res._set(res_hv)
        return res
    
    def __ilshift__(self, value: int) -> Hypervector:
        """Hypervector left shift

        Allows the use of  a =<< b where a is a Hypervector, b is an integer.
        Shifts are circular, so any dimension shifted out will appear at the 
        beginning of the Hypervector

        Args:
            value (int): The amount to shift by

        Returns:
            Hypervector: The resultant Hypervector
        """
        res = HV_Zero(self.dimension)
        res_hv = np.roll(self.hv, -value)
        res._set(res_hv)
        return res
    
    def __rshift__(self, value: int) -> Hypervector:
        """Hypervector right shift

        Allows the use of  a >> b where a is a Hypervector, b is an integer.
        Shifts are circular, so any dimension shifted out will appear at the 
        end of the Hypervector

        Args:
            value (int): The amount to shift by

        Returns:
            Hypervector: The resultant Hypervector
        """
        res = HV_Zero(self.dimension)
        res_hv = np.roll(self.hv, value)
        res._set(res_hv)
        return res
    
    def __irshift__(self, value: int) -> Hypervector:
        """Hypervector right shift

        Allows the use of  a =>> b where a is a Hypervector, b is an integer.
        Shifts are circular, so any dimension shifted out will appear at the 
        end of the Hypervector

        Args:
            value (int): The amount to shift by

        Returns:
            Hypervector: The resultant Hypervector
        """
        res = HV_Zero(self.dimension)
        res_hv = np.roll(self.hv, value)
        res._set(res_hv)
        return res
    
    def cosine_similarity(self, value: Hypervector) -> float:
        """Calculates cosine similarity

        The cosine similarity is a measure of how similar two 
        Hypervectors are. This is the same as the hamming distance 
        in binary.

        Args:
            value (Hypervector): The second hypervector to use in the calculation

        Returns:
            float: Resulting cosine similarity
        """
        return np.dot(self.hv, value.hv)/(np.linalg.norm(self.hv)*np.linalg.norm(value.hv))        


class HV_Zero(Hypervector):
    """A Hypervector whos initial contents are
    all zero.

    Args:
        Hypervector (object): Base Hypervector implementation
    """

    def __init__(self, dimension: int) -> None:
        super().__init__(dimension, type="int")

    def _generate(self) -> None:
        """Does nothing, so the Hypervector
        values stay as all zeros
        """
        pass

class HV_Rand(Hypervector):
    """A Hypervector whos initial contents are random.

    Args:
        Hypervector (object): Base Hypervector implementation
    """

    def __init__(self, dimension: int, type: _VECTOR_TYPES, loc:int = 0, scale:int = 10) -> None:
        self.loc = loc
        self.scale = scale
        super().__init__(dimension, type=type)        

    def _generate(self) -> None:
        """Sets the Hypervector initial values to the
        standard normal distribution using numpy
        """
        if self.type == "int":
            self.hv = scipy.stats.norm.ppf(np.random.random(self.dimension), loc=self.loc, scale=self.scale).astype(int)
        elif self.type == "bipolar":
            self.hv = np.random.choice([-1,1],self.dimension)
        elif self.type == "binary":
            self.hv = np.random.choice([0,1],self.dimension)