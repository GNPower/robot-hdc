/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       bundle_accuracies.h
*   @desc       Header file for bundle accuracies calculations
*   @author     Graham N. Power
*   @date       2023-10-02
*   @version    1.0.0 (Major.Minor.Patch)
*
*	<pre>
*
*   Revision History:
*
*	Ver   	Who    	Date   		Changes
*	----- 	---- 	-------- 	-------------------------------------------------------
*	1.0.0 	gnp   	2023-10-02 	Initial bundle accuracies calculations
*	
*
*
*   0.0.0   -   Initial release
*   0.0.1   -   Patched some bug
*   0.1.0   -   Incremental change
*   1.0.0   -   First major release
*
*	</pre>
*
*******************************************************************************/


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#ifndef HDC_BUNDLE_ACCURACIES_H_
#define HDC_BUNDLE_ACCURACIES_H_


/*******************************************************************************
*   Includes
*******************************************************************************/
#include "hypervector.h"
// #include "components/elements.h"
// #include "components/bundling.h"
// #include "components/binding.h"
// #include "components/similarity.h"


/*******************************************************************************
*   Preprocessor Macros
*******************************************************************************/


/*******************************************************************************
*   Datatype Definitions
*******************************************************************************/


/*******************************************************************************
*   Constant Definitions
*******************************************************************************/


/*******************************************************************************
*   Function Protoypes
*******************************************************************************/


/*******************************************************************************
*   Global Variables
*******************************************************************************/


/*******************************************************************************
*   Functions
*******************************************************************************/
template <typename T>
void BuildItemMemory(vector<vector<T>> &memory_to_fill, unsigned int memory_size, unsigned int hypervector_dimentions, Encoding<T> &enc)
{
    unsigned int i;
    for (i = 0; i < memory_size; i++)
    {
        vector<T> v(hypervector_dimentions);
        enc.generate(v);
        memory_to_fill.push_back(v);
    }
};


// TODO: should I return a new vector2d as the subset or are indices ok?
template <typename T>
void RandomSubset(vector<vector<T>> &memory, unsigned int sample_size)
{
    vector<unsigned int> indices(memory.size());
    unsigned int i;
    for (i = 0; i < indices.size(); i++)
        indices[i] = i;
    
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_HYPERVECTOR_H_ */
/*
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
*/