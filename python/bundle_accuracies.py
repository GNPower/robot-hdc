from itertools import repeat
from multiprocessing.shared_memory import ShareableList
import random
from typing import List, Tuple
import json
from multiprocessing import Pool, Process, Manager, Array, cpu_count

import numpy as np
from alive_progress import alive_bar
from tqdm import tqdm

from hdc.hypervector import BSC, BSDC_CDT, BSDC_S, BSDC_SEG, FHRR, HRR, MAP_B, MAP_C, MAP_I, MBAT, VTB, Encoding


MEMORY_SIZE = 1_000
DIMENSIONS = [i**2 for i in range(2,34)]
BUNDLE_NUMBER = [k for k in range(2,50)]

MONTECARLO_RUNS = 1
# MONTECARLO_RUNS = 1_000

PROCESS_BAR = True


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
    total = 0
    for i in range(MONTECARLO_RUNS):
        total += BundleAccuracy(item_memory, sample_size, encoding)
    if bar:
        bar.update(1)
    return (total / MONTECARLO_RUNS)


def AllBundleAccuracyByDimension(memory_size: int, encoding: Encoding, hypervector_dimension: int, bundle_list: List[int], bar = None) -> List[float]:
    item_memory = BuildItemMemory(memory_size, hypervector_dimension, encoding)
    accuracies = [LoopBundleAccuracy(item_memory, sample_size, encoding, bar=bar) for sample_size in bundle_list]
    return accuracies


def AllBundleAccuracy(memory_size: int, encoding: Encoding, hypervector_dimension_list: List[int], bundle_list: List[int]) -> List[List[float]]:
    if PROCESS_BAR:
        print("######  \/ SURVEY SWEEP PARAMETERS \/  ######")
        print(f"MEMORY_SIZE: {MEMORY_SIZE}")
        print(f"DIMENSIONS: {DIMENSIONS}")
        print(f"BUNDLE_NUMBER: {BUNDLE_NUMBER}")
        print("######  /\ SURVEY SWEEP PARAMETERS /\  ######")
        print("\n")
        with tqdm(total=len(hypervector_dimension_list)*len(bundle_list)) as bar:
            accuracies = [AllBundleAccuracyByDimension(memory_size, encoding, dimension, bundle_list, bar=bar) for dimension in hypervector_dimension_list]
    else:
        accuracies = [AllBundleAccuracyByDimension(memory_size, encoding, dimension, bundle_list, bar=None) for dimension in hypervector_dimension_list]
    # num_proc = 2
    # print(f"Allocating Pool With {num_proc} Processes")
    # p = Pool(processes=num_proc)
    # l2 = hypervector_dimension_list#[:2]
    # accuracies = p.starmap(AllBundleAccuracyByDimension, [(memory_size, encoding, dimension, bundle_list,) for dimension in l2])
    # p.close()
    return accuracies


def LoopBundleAccuracy_Multiprocessed(shared_list: List[any], list_index: int) -> float:
    total = 0
    for i in range(MONTECARLO_RUNS):
        total += BundleAccuracy(shared_list[list_index][0], shared_list[list_index][1], shared_list[list_index][2])
    return (total / MONTECARLO_RUNS)

def __MP_Callback():
    print('called')


def AllBundleAccuracy_Multiprocessed(memory_size: int, encoding_list: List[Encoding], hypervector_dimension_list: List[int], bundle_list: List[int]) -> List[List[float]]:
    mem_manager = Manager()
    shared_memories = []
    results_list = [0 for enc in encoding_list]
    results_list2d = [0 for enc in encoding_list]
    for encoding in encoding_list:
        item_memories = [BuildItemMemory(memory_size, hypervector_dimension, encoding) for hypervector_dimension in hypervector_dimension_list]
        # print(len(item_memories))
        # print(len(item_memories[0]))
        input_data = [ [(item_memories[dim_index], sample_size, encoding,) for sample_size in bundle_list]  for dim_index in range(len(hypervector_dimension_list))  ]
        # print(len(input_data))
        # print(len(input_data[0]))
        # print(len(input_data[0][0]))
        shared_list = mem_manager.list()
        shared_list = [item for sublist in input_data for item in sublist]
        shared_memories.append(shared_list)

    # flat_list = [item for sublist in input_data for item in sublist]
    # print(len(flat_list))
    # print(len(flat_list[0]))
    # print(flat_list[0])
    num_proc = 32#cpu_count()

    # print("Shared List")
    # print(len(sl))
    # print(len(sl[0]))

    print(f"Allocating Pool With {num_proc} Processes")
    p = Pool(processes=num_proc)
    
    for i in range(len(encoding_list)):
        results_list[i] = p.starmap(LoopBundleAccuracy_Multiprocessed, zip(repeat(shared_memories[i]), range(len(shared_memories[i]))))

    # results = p.starmap(LoopBundleAccuracy_Multiprocessed, zip(repeat(sl), range(len(sl))))
    
    p.close()
    p.join()

    print("Multiprocessing Commplete!")
    # print(len(results))
    print(len(shared_memories))
    print(len(shared_memories[0]))

    for i in range(len(encoding_list)):
        results_2d = np.asarray(results_list[i]).reshape(-1, len(bundle_list))
        results_list2d[i] = results_2d
    # print(len(results_2d))
    # print(len(results_2d[0]))
    print(len(results_list2d))
    print(len(results_list2d[0]))
    print(len(results_list2d[0][0]))

    # proc = Process(target=LoopBundleAccuracy_Multiprocessed, args=[sl, 0])
    # proc.start()
    # proc.join()
    return results_list2d


def GenerateDimensionsRequiredFor99PercentAccuracy(accuracy_data: List[List[float]], dimension_list: List[int], bundle_list: List[int]) -> List[int]:
    data = [0 for i in range(len(bundle_list))]
    for j in range(len(bundle_list)):
        for i in range(len(dimension_list)):        
            if accuracy_data[i][j] >= 0.99:
                data[j] = dimension_list[i]
                break
    return data
