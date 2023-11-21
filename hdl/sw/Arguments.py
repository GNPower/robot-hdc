import argparse
import os
import pathlib

parser = argparse.ArgumentParser()
DATA_PATH = os.path.abspath(os.path.join(pathlib.Path(__file__).parent.resolve(), "..", "data"))

def ParseArgs_BundleKernel():
    parser.add_argument("output", type=str, help="Name of the output file")
    parser.add_argument("-n", "--num-inputs", type=int, default=3, help="Number of kernel inputs to generate")

def ParseArgs_BundleKernelMapper():
    parser.add_argument("output", type=str, help="Name of the output file")
    parser.add_argument("-l", "--hv-length", type=int, default=4, help="Length of the hypervectors to generate")
    parser.add_argument("-m", "--hv-max", type=int,  default=4, help="The maximum size of hypervectors which can be stored in memory. Must be >= --hv-length")
    parser.add_argument("-n", "--num-inputs", type=int, default=3, help="Number of hypervectors to bundle")
    parser.add_argument("-i", "--implementation", type=int, default=1, help="Bundler implementation to use (1 = ElementAdditionCutBipolar_F)")