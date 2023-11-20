import struct
import os
import numpy as np

from Arguments import DATA_PATH, parser, ParseArgs_BundleKernelMapper

def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

def ElementAdditionCutBipolar_F(hv_length: int = 4, hv_max: int = 4, num_inputs: int = 3):
    output = f"{hv_length}\n{hv_max}\n{num_inputs}\n"

    # Stored as [[HVA0, HVB0, ... HVZ0], [HVA1, HVB1, ... HVZ1], ..., [HVAn, HVBn, ... HVZn]]
    input_hvs = [np.random.random(num_inputs).astype(np.float32) for i in range(hv_length)]
    # Normalize so sum is between 0 and 1
    input_hvs = [input_hv / (input_hv.sum() + 0.1) for input_hv in input_hvs]
    sum_hv = [input_hv.sum() for input_hv in input_hvs]

    for i in range(num_inputs):
        for j in range(hv_max):
            if j < hv_length:
                output += f"{binary(input_hvs[j][i])}\n"
            else:
                output += f"{binary(0)}\n"

    for i in range(hv_max):
        if j < hv_length:
            output += f"{binary(sum_hv[i])}\n"
        else:
            output += f"{binary(0)}\n"
    
    return output.rstrip()


implementation_map = {
    1: ElementAdditionCutBipolar_F,
}

def GenerateInputs(hv_length: int = 4, hv_max: int = 4, num_inputs: int = 3, implementation: int = 1):
    return implementation_map[implementation](hv_length, hv_max, num_inputs)

if __name__ == "__main__":
    ParseArgs_BundleKernelMapper()
    args = parser.parse_args()
    output = GenerateInputs(args.hv_length, args.hv_max, args.num_inputs, args.implementation)
    output_file = os.path.join(DATA_PATH, args.output)

    with open(output_file, "w") as f:
        f.write(output)