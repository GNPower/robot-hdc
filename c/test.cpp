
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <vector>
#include <iostream>
#include <random>
#include <time.h>
#include <string>
#include <algorithm>

#include "components/elements.h"
#include "components/bundling.h"
#include "components/similarity.h"
#include "hypervector.h"
#include "bundle_accuracies.h"
#include "savedata.h"

using namespace std;

template <typename T>
void printVec(vector<T> &vec)
{
    unsigned int i;
    cout << "[ ";
    for (i = 0; i < vec.size(); i++)
    {
        cout << vec[i] << ", ";
    }
    cout << "]" << endl;
};

template <typename T>
void printVec2d(vector<vector<T>> &vec)
{
    unsigned int i;
    for (i = 0; i < vec.size(); i++)
    {
        printVec<T>(vec[i]);
    }
}


int main()
{
    srand(time(0));

    unsigned int dim = 10;
    unsigned int memsize = 10;
    cout << "dim: " << dim << endl;

    vector<unsigned int> bundlist{ 2, 3, 4, 5 };
    vector<unsigned int> dimlist{ 4, 9, 16, 25 };

    MAP_C enc(dim);

    // Test building Item Memory
    vector<vector<double>> memory;
    unsigned int sample_size = 5;
    BuildItemMemory(memory, memsize, dim, enc);

    cout << "Memory:" << endl;
    printVec2d(memory);
    cout << endl << endl << endl;

    float bundle_accuracy = BundleAccuracy(memory, sample_size, enc);
    cout << "Bundle Accuracy: " << bundle_accuracy << endl;

    float loop_bundle_accuracy = LoopBundleAccuracy(memory, sample_size, enc);
    cout << "Looped Bundle Accuracy: " << loop_bundle_accuracy << endl;
    cout << endl << endl << endl;

    vector<float> acc_by_dim = AllBundleAccuracyByDimension(memsize, enc, dim, bundlist);
    cout << "Accuracy By Dimension: " << endl;
    printVec(bundlist);
    printVec(acc_by_dim);
    cout << endl << endl << endl;

    vector<vector<float>> all_acc = AllBundleAccuracies(memsize, enc, dimlist, bundlist);
    cout << "All Accuracies: " << endl;
    printVec2d(all_acc);
    cout << endl << endl << endl;

    // vector<vector<float>> all_acc2 = AllBundleAccuracies(DefaultMemorySize, enc, DefaultDimensions, DefaultBundleNumbers);
    // cout << "All Accuracies: " << endl;
    // printVec2d(all_acc2);
    // cout << endl << endl << endl;

    vector<unsigned int> reqdims = GenerateDimensionsRequiredFor99PercentAccuracy(all_acc, dimlist, bundlist);
    cout << "Required Dimensions for 99%" << endl;
    printVec(reqdims);
    cout << endl << endl << endl;

    // vector<unsigned int> reqdims = GenerateDimensionsRequiredFor99PercentAccuracy(all_acc2, DefaultDimensions, DefaultBundleNumbers);
    // cout << "Required Dimensions for 99%" << endl;
    // printVec(reqdims);
    // cout << endl << endl << endl;

    OutputAllData(
    all_acc,
    reqdims,
    dimlist,
    bundlist,
    "Test"
    );
};
