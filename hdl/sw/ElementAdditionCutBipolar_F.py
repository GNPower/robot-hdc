import struct
import os
import numpy as np

from Arguments import DATA_PATH, parser, ParseArgs_BundleKernel


def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))


def GenerateInputs(num_inputs: int = 3, allow_cap_exceed: bool = False) -> str:
    inputs = np.random.random(num_inputs).astype(np.float32)
    if(not allow_cap_exceed):
        sum = inputs.sum() + 0.1
        inputs = inputs / sum

    input_sum = inputs.sum()

    output = f"{binary(input_sum)}\n"
    for num in inputs:
        output += f"{binary(num)}\n"

    return output.rstrip()


if __name__ == "__main__":
    ParseArgs_BundleKernel()
    args = parser.parse_args()
    output = GenerateInputs(args.num_inputs)
    output_file = os.path.join(DATA_PATH, args.output)

    with open(output_file, "w") as f:
        f.write(output)