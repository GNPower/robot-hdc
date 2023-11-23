import struct
import os
import numpy as np

from Arguments import DATA_PATH, parser, ParseArgs_BindKernel


def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))


def GenerateInputs() -> str:
    inputs = np.random.random(2).astype(np.float32)

    input_prod = np.prod(inputs)

    output = f"{binary(input_prod)}\n"
    for num in inputs:
        output += f"{binary(num)}\n"

    return output.rstrip()


if __name__ == "__main__":
    ParseArgs_BindKernel()
    args = parser.parse_args()
    output = GenerateInputs()
    output_file = os.path.join(DATA_PATH, args.output)

    with open(output_file, "w") as f:
        f.write(output)