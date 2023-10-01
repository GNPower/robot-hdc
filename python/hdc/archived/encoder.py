from abc import ABC, abstractmethod
from math import ceil
from typing import Literal

import numpy as np

from hdc.exceptions import DimensionsNotMatchingError, DtypesNotMatchingError
from hdc.hypervector import Encoding, HV_Rand, HV_Zero, _VECTOR_TYPES

_ENCODING_TYPES = Literal["key", "range"]

class Encoder(object):

    def __init__(self) -> None:
        self.encodings = {
            "set": {},
            "range": {},
        }

    def create_set_encoding(self, key: str, type: _VECTOR_TYPES, dimensions: int) -> None:
        self.encodings["set"][key] = {
            "type": type,
            "dimensions": dimensions,
            "vector": HV_Rand(dimensions, type)
        }

    def create_range_encoding(self, key: str, type: _VECTOR_TYPES, dimensions: int, min: float, max: float, partitions: int) -> None:
        steps = np.linspace(min, max, partitions+1)
        base_hv = HV_Rand(dimensions, "int")
        put_hv = HV_Rand(dimensions, "int")
        vectors = [HV_Zero(dimensions) for i in range(steps.size-1)]
        for i, vector in enumerate(vectors):
            vector._set(put_hv.hv)
            offset = int(dimensions / partitions) * i
            vector._set(base_hv.hv[offset:], offset=offset)
        self.encodings["range"][key] = {
            "type": type,
            "dimensions": dimensions,
            "min": min,
            "max": max,
            "partitions": partitions,
            "steps": steps,
            "vectors": vectors
        }

    def encode_set(self, key: str) -> Encoding:
        return self.encodings["set"][key]["vector"]

    def encode_range(self, key: str, val: float) -> Encoding:
        steps = self.encodings["range"][key]["steps"]
        for i in range(1,len(steps)):
            if val <= steps[i]:
                return self.encodings["range"][key]["vectors"][i-1]
        return self.encodings["range"][key]["vectors"][-1]