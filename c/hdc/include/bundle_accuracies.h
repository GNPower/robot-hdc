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
#include <vector>
#include <algorithm>

#include "hypervector.h"
// #include "components/elements.h"
// #include "components/bundling.h"
// #include "components/binding.h"
// #include "components/similarity.h"

using namespace std;


/*******************************************************************************
*   Preprocessor Macros
*******************************************************************************/
#define MONTECARLO_RUNS     1
#define PROGRESS_BAR_WIDTH  70


/*******************************************************************************
*   Datatype Definitions
*******************************************************************************/


/*******************************************************************************
*   Constant Definitions
*******************************************************************************/
unsigned int DefaultMemorySize = 1000;
vector<unsigned int> DefaultDimensions{ 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225, 256, 289, 324, 361, 400, 441, 484, 529, 576, 625, 676, 729, 784, 841, 900, 961, 1024, 1089 };
vector<unsigned int> DefaultBundleNumbers{ 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49 };


/*******************************************************************************
*   Function Protoypes
*******************************************************************************/


/*******************************************************************************
*   Global Variables
*******************************************************************************/
unsigned int BundleAccuracyProgress;
unsigned int LengthOfLoop;


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
        enc.generate(v, hypervector_dimentions);
        memory_to_fill.push_back(v);
    }
};


// TODO: should I return a new vector2d as the subset or are indices ok?
template <typename T>
vector<int> RandomSubset(vector<vector<T>> &memory, unsigned int sample_size)
{
    vector<int> indices(sample_size, -1);
    unsigned int i = 0;
    while(i < sample_size)
    {
        int val = rand() % memory.size();
        if(!count(indices.begin(), indices.end(), val))
        {
            indices[i] = val;
            i++;
        }
    }
    
    return indices;
};


template <typename T>
float BundleAccuracy(vector<vector<T>> &memory, unsigned int sample_size, Encoding<T> &enc)
{
    // Randomly choose (sample_size) hypervectors without replacement from the full item memory
    vector<int> sample_indices = RandomSubset(memory, sample_size);
    // Build the sample memory
    vector<vector<double>> sample(sample_size);
    unsigned int i;
    for (i = 0; i < sample_size; i++)
    {
        sample[i] = memory[sample_indices[i]];
    }
    // Bundle the sample vectors into a single hypervector
    vector<double> bundled(memory[0].size());
    enc.bundle(bundled, sample);
    // Get the similarity between every hypervector in the item_memory and the bundled hypervector
    vector<float> similarities(memory.size());
    for (i = 0; i < memory.size(); i++)
    {
        similarities[i] = enc.similarity(bundled, memory[i]);
    }
    // Get the indices of the top (sample_size) most similar hypervectors in the item_memory
    vector<int> most_similar(sample_size);
    for (i = 0; i < sample_size; i++)
    {
        auto it = max_element(similarities.begin(), similarities.end());
        int index = distance(similarities.begin(), it);
        most_similar[i] = index;
        similarities[index] = -100; // This works since similarity functions are normalized to [-1,1]
    }
    // Count how many of these top similar vectors appear in the input sample list
    unsigned int correct_count = 0;
    for (i = 0; i < sample_size; i++)
    {
        if(count(sample_indices.begin(), sample_indices.end(), most_similar[i]))
        {
            correct_count++;
        }
    }
    // Calculate the accuracy as the ratio of (correct_count) / (sample_size)
    return (double)correct_count / (double)sample_size;
};


template <typename T>
float LoopBundleAccuracy(vector<vector<T>> &memory, unsigned int sample_size, Encoding<T> &enc)
{
    float total = 0;
    unsigned int i;
    for (i = 0; i < MONTECARLO_RUNS; i++)
    {
        total += BundleAccuracy(memory, sample_size, enc);
    }
    // Print the progress bar
    BundleAccuracyProgress++;
    cout << "[";
    double progress = ((double)BundleAccuracyProgress / (double)LengthOfLoop);
    unsigned int pos = (unsigned int) ( (double)PROGRESS_BAR_WIDTH * progress );
    for (i = 0; i < PROGRESS_BAR_WIDTH; i++)
    {
        if (i < pos) cout << "=";
        else if (i == pos) cout << ">";
        else cout << " ";
    }
    cout << "] " << int(progress * 100.0) << "%\r";
    cout.flush();
    // Return the accuracy
    return total / (double)MONTECARLO_RUNS;
};


template <typename T>
vector<float> AllBundleAccuracyByDimension(unsigned int memory_size, Encoding<T> &enc, unsigned int hypervector_dimension, vector<unsigned int> &bundle_list)
{
    // Build the item memory to use in the test
    vector<vector<T>> memory;
    BuildItemMemory(memory, memory_size, hypervector_dimension, enc);
    // Build the accuracies list
    vector<float> accuracies(bundle_list.size());
    unsigned int i;
    for (i = 0; i < bundle_list.size(); i++)
    {
        accuracies[i] = LoopBundleAccuracy(memory, bundle_list[i], enc);
    }
    return accuracies;
};


template <typename T>
vector<vector<float>> AllBundleAccuracies(unsigned int memory_size, Encoding<T> &enc, vector<unsigned int> &hypervector_dimension_list, vector<unsigned int> &bundle_list)
{
    BundleAccuracyProgress = 0;
    LengthOfLoop = bundle_list.size() * hypervector_dimension_list.size();
    cout.flush();
    vector<vector<float>> all_accuracies;
    unsigned int i;
    for (i = 0; i < hypervector_dimension_list.size(); i++)
    {
        all_accuracies.push_back(AllBundleAccuracyByDimension(memory_size, enc, hypervector_dimension_list[i], bundle_list));
    }
    return all_accuracies;
};


// TODO: test!
vector<unsigned int> GenerateDimensionsRequiredFor99PercentAccuracy(vector<vector<float>> &accuracy_data, vector<unsigned int> &hypervector_dimension_list, vector<unsigned int> &bundle_list)
{
    vector<unsigned int> req_dims(bundle_list.size(), 0);
    unsigned int i, j;
    for (j = 0; j < bundle_list.size(); j++)
    {
        for (i = 0; i < hypervector_dimension_list.size(); i++)
        {
            if (accuracy_data[i][j] >= 0.99)
            {
                req_dims[j] = hypervector_dimension_list[i];
                break;
            }
        }
    }
    return req_dims;
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_HYPERVECTOR_H_ */
