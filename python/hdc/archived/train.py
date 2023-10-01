from typing import Union, Literal, get_args

import numpy as np
import scipy.stats

from hdc.hypervector import Encoding, HV_Zero

_BUNDLE_MODES = Literal["majority"]
_BIND_MODES = Literal["multiply", "xor"]

class Bundler():    

    def __init__(self, bundle_mode: _BUNDLE_MODES = "majority") -> None:
        options = get_args(_BUNDLE_MODES)
        if bundle_mode not in options:
            raise ValueError("Invalid bundle_mode. Expected one of %s" % options)
        self.bundle_mode = bundle_mode

    def _bundle_majority(self, *hypervectors: Encoding) -> Encoding:
        shape = len(hypervectors[0].hv.shape)
        if shape == 1:
            arrays = [arr.hv for arr in hypervectors]
            res_hv = scipy.stats.mode(arrays, keepdims=True, axis=0).mode[0]
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res
        elif shape == 2:
            res_hv = scipy.stats.mode(hypervectors[0].hv, keepdims=True, axis=0).mode[0]
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res
        else:
            raise TypeError("Only a set of 1D arrays or a single 2D array is supported for bundling")
        
    def bundle(self, *hypervectors: Encoding):
        if self.bundle_mode == "majority":
            return self._bundle_majority(*hypervectors)
        
class Binder():

    def __init__(self, bind_mode: _BIND_MODES = "multiply") -> None:
        options = get_args(_BIND_MODES)
        if bind_mode not in options:
            raise ValueError("Invalid bundle_mode. Expected one of %s" % options)
        self.bind_mode = bind_mode

    def _bind_multiply(self, *hypervectors: Encoding) -> Encoding:
        shape = len(hypervectors[0].hv.shape)
        if shape == 1:
            arrays = [arr.hv for arr in hypervectors]
            res_hv = arrays[0]
            for i in range(1, len(arrays)):
                res_hv = np.multiply(res_hv, arrays[i])
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res
        elif shape == 2:
            size = hypervectors[0].hv.shape[1]
            mat = hypervectors[0].hv
            res_hv = mat[0, :]
            for i in range(1, size):
                res_hv = np.multiply(res_hv, mat[i, :])
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res
        else:
            raise TypeError("Only a set of 1D arrays or a single 2D array is supported for binding")

    def _bind_xor(self, *hypervectors: Encoding) -> Encoding:
        shape = len(hypervectors[0].hv.shape)
        if shape == 1:
            arrays = [arr.hv for arr in hypervectors]
            res_hv = arrays[0]
            for i in range(1, len(arrays)):
                res_hv = np.logical_xor(res_hv, arrays[i])
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res
        elif shape == 2:
            size = hypervectors[0].hv.shape[1]
            mat = hypervectors[0].hv
            res_hv = mat[0, :]
            for i in range(1, size):
                res_hv = np.logical_xor(res_hv, mat[i, :])
            res = HV_Zero(res_hv.shape[0])
            res._set(res_hv)
            return res
        else:
            raise TypeError("Only a set of 1D arrays or a single 2D array is supported for binding")

    def bind(self, *hypervectors: Encoding) -> Encoding:
        if self.bind_mode == "multiply":
            return self._bind_multiply(*hypervectors)
        elif self.bind_mode == "xor":
            return self._bind_xor(*hypervectors)