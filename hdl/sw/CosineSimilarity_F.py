import struct
import os
import numpy as np

from Arguments import DATA_PATH, parser, ParseArgs_SimilarityKernel


def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))


def GenerateInputs(num_inputs: int = 3) -> str:
    inputs_a = np.random.random(num_inputs).astype(np.float32)
    inputs_b = np.random.random(num_inputs).astype(np.float32)

    aa = np.multiply(inputs_a, inputs_a)
    bb = np.multiply(inputs_b, inputs_b)
    ab = np.multiply(inputs_a, inputs_b)

    s_aa = np.sum(aa)
    s_bb = np.sum(bb)
    s_ab = np.sum(ab)

    output = f"{binary(s_aa)}\n{binary(s_bb)}\n{binary(s_ab)}\n"
    for i in range(num_inputs):
        output += f"{binary(inputs_a[i])}\n"
        output += f"{binary(inputs_b[i])}\n"

    return output.rstrip()


if __name__ == "__main__":
    ParseArgs_SimilarityKernel()
    args = parser.parse_args()
    output = GenerateInputs()
    output_file = os.path.join(DATA_PATH, args.output)

    with open(output_file, "w") as f:
        f.write(output)