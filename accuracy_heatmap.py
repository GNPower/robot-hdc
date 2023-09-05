import random
from typing import List
from time import sleep

import numpy as np
import matplotlib.pyplot as plt
from  matplotlib.colors import LinearSegmentedColormap
from alive_progress import alive_bar

from hdc.hypervector import BSC, BSDC_CDT, BSDC_S, BSDC_SEG, FHRR, HRR, MAP_B, MAP_C, MAP_I, MBAT, VTB, Encoding


MEMORY_SIZE = 1_000
DIMENSIONS = [i**2 for i in range(2,34)]
BUNDLE_NUMBER = [k for k in range(2,50)]


def BuildItemMemory(memory_size: int, hypervector_dimensions: int, encoding: Encoding) -> List[np.ndarray]:
    # Create a database of memory_size random hypervectors
    return [encoding.generate(hypervector_dimensions) for i in range(memory_size)]


def RandomSubset(item_memory: List[np.ndarray], sample_size: int) -> List[np.ndarray]:
    if sample_size > len(item_memory):
        return item_memory
    return random.sample(item_memory, sample_size)


def BundleAccuracy(item_memory: List[np.ndarray], sample_size: int, encoding: Encoding) -> float:
    # Randomly choose (sample_size) hypervectors without replacement from the full item memory
    sample_indices = np.random.choice(len(item_memory), sample_size)
    # sample = np.asarray(RandomSubset(item_memory, sample_size))
    sample = np.asarray(item_memory)[sample_indices]
    # Bundle the sample vectors into a single hypervector
    bunled = encoding.bundle(sample)
    # Get the similarity between every hypervector in the item_memory and the bundled hypervector
    similarities = [encoding.similarity(bunled, vector) for vector in item_memory]
    # Get the indices of the top (sample_size) most similar hypervectors in the item_memory
    indices = np.argsort(similarities)[-sample_size:]
    # Count how many of these top similar vectors appear in the input sample list
    correct_count = 0
    for index in indices:
        if index in sample_indices:
            correct_count += 1
    # Calculate the accuracy as the ratio of (correct_count) / (sample_size)
    return (correct_count / sample_size)


def LoopBundleAccuracy(item_memory: List[np.ndarray], sample_size: int, encoding: Encoding, bar = None) -> float:
    BUNDLE_RUNS = 1_000
    # BUNDLE_RUNS = 1
    total = 0
    for i in range(BUNDLE_RUNS):
        total += BundleAccuracy(item_memory, sample_size, encoding)
    if bar:
        bar()
    return (total / BUNDLE_RUNS)


def AllBundleAccuracyByDimension(memory_size: int, encoding: Encoding, hypervector_dimension: int, bundle_list: List[int], bar = None) -> List[float]:
    item_memory = BuildItemMemory(memory_size, hypervector_dimension, encoding)
    accuracies = [LoopBundleAccuracy(item_memory, sample_size, encoding, bar=bar) for sample_size in bundle_list]
    return accuracies


def AllBundleAccuracy(memory_size: int, encoding: Encoding, hypervector_dimension_list: List[int], bundle_list: List[int]) -> List[List[float]]:
    with alive_bar(len(hypervector_dimension_list)*len(bundle_list), bar = 'filling') as bar:
        accuracies = [AllBundleAccuracyByDimension(memory_size, encoding, dimension, bundle_list, bar=bar) for dimension in hypervector_dimension_list]
    return accuracies


def PlotAccuracyGraph(accuracy_data: List[List[float]], dimension_list: List[int], bundle_list: List[int], encoding_name: str) -> None:
    # Create a colour map for the heatmap
    colours = ['#000089', '#0000E8', '#0050FF', '#00B6FF', '#1AFFE4', '#80FF7F', '#E7FF18', '#FFAF00', '#FF4B00', '#E30000', '#840000']
    cvalues = [0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1.]
    clist = list(zip(cvalues, colours))
    cmap = LinearSegmentedColormap.from_list('hmap', clist, N=256)

    plt.imshow(accuracy_data[::-1], cmap=cmap, interpolation='nearest')
    plt.colorbar()
    plt.xlabel("# bundled vectors")
    plt.xticks(range(len(bundle_list)), bundle_list)
    plt.ylabel("# dimensions")
    plt.yticks(range(len(dimension_list)), dimension_list[::-1])
    plt.title(encoding_name)
    plt.savefig(f"heatmap_output/{encoding_name}.png")
    plt.show()


def AllEncodingAccuracies(memory_size: int, encoding_list: List[Encoding], hypervector_dimension_list: List[int], bundle_list: List[int]) -> None:
    pass


# Display sweep parameters
print("######  \/ SURVEY SWEEP PARAMETERS \/  ######")
print(f"MEMORY_SIZE: {MEMORY_SIZE}")
print(f"DIMENSIONS: {DIMENSIONS}")
print(f"BUNDLE_NUMBER: {BUNDLE_NUMBER}")
print("######  /\ SURVEY SWEEP PARAMETERS /\  ######")
print("\n")

# Create the tested encodings
fhrr = FHRR(1_000)

results = AllBundleAccuracy(1_000, fhrr, DIMENSIONS, BUNDLE_NUMBER)
PlotAccuracyGraph(results, DIMENSIONS, BUNDLE_NUMBER, "FHRR")

# AllBundleAccuracy(10, map_c, DIMENSIONS, BUNDLE_NUMBER)
# results = AllBundleAccuracy(1_0, map_c, [2, 4, 6, 8, 10], [2, 3, 4, 5, 6])
# print(results)

# Test building an item memory
# test_mem = BuildItemMemory(10, 10, map_c)
# print("######  \/ TEST ITEM MEMORY N = 10 \/  ######")
# print(test_mem)
# print("######  /\ TEST ITEM MEMORY N = 10 /\  ######")
# print("\n")

# Test calculating bundle accuracy
# test_accuracy1 = LoopBundleAccuracy(test_mem, 5, map_c)
# print("######  \/ TEST ACCURACY 5 SAMPLES \/  ######")
# print(test_accuracy1)
# print("######  /\ TEST ACCURACY 5 SAMPLES /\  ######")
# print("\n")

# Test calculating all bundle accuracies for a single dimension
# test_accuracy2 = AllBundleAccuracyByDimension(10, map_c, 10, BUNDLE_NUMBER)
# print("######  \/ TEST ACCURACY All DIMENSIONS \/  ######")
# print(test_accuracy2)
# print("######  /\ TEST ACCURACY All DIMENSIONS /\  ######")
# print("\n")

# dim_list = [2, 4, 6, 8, 10]
# bundle_list = [2, 3, 4, 5, 6]
# data = [
#     [0.3795, 0.49466666666666587, 0.53675, 0.5904000000000035, 0.6626666666666656], # dim = 2,  bundles 2-6
#     [0.536, 0.5196666666666675, 0.5205, 0.5832000000000023, 0.6354999999999992],    # dim = 4,  bundles 2-6
#     [0.722, 0.6916666666666641, 0.7255, 0.7511999999999985, 0.7810000000000012],    # dim = 6,  bundles 2-6
#     [0.796, 0.7273333333333304, 0.71875, 0.730000000000001, 0.7621666666666679],    # dim = 8,  bundles 2-6
#     [0.872, 0.7406666666666638, 0.72775, 0.7453999999999992, 0.7865000000000013]    # dim = 10, bundles 2-6
# ]

# PlotAccuracyGraph(data, dim_list, bundle_list, "MAP-C")

# print(data)
# print(data[::-1])

# colours = ['#000089', '#0000E8', '#0050FF', '#00B6FF', '#1AFFE4', '#80FF7F', '#E7FF18', '#FFAF00', '#FF4B00', '#E30000', '#840000']
# cvalues = [0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1.]
# clist = list(zip(cvalues, colours))
# cmap = LinearSegmentedColormap.from_list('hmap', clist, N=256)

# plt.imshow(data[::-1], cmap=cmap, interpolation='nearest')
# plt.colorbar()
# plt.xlabel("# bundled vectors")
# plt.xticks(range(len(bundle_list)), bundle_list)
# plt.ylabel("# dimensions")
# plt.yticks(range(len(dim_list)), dim_list[::-1])
# plt.title("MAP-C")
# plt.show()