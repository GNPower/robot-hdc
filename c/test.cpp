
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <vector>
#include <iostream>
#include <random>
#include <time.h>
#include <algorithm>

#include "components/elements.h"
#include "components/bundling.h"
#include "components/similarity.h"
#include "hypervector.h"
#include "bundle_accuracies.h"

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
    cout << "dim: " << dim << endl;

    MAP_C enc(dim);

    // vector<double> veca(dim);
    // vector<double> vecb(dim);
    // enc.generate(veca);
    // enc.generate(vecb);
    // cout << "veca[0]: " << veca[0] << endl;

    // vector<double> vecc(dim);
    // vector<vector<double>> bundler{veca, vecb};
    // enc.bundle(vecc, bundler);

    // float sim = enc.similarity(veca, vecb);
    // cout << "Sim: " << sim << endl;
    // float sim2 = enc.similarity(veca, vecc);
    // cout << "Sim2: " << sim2 << endl;

    vector<vector<double>> memory;
    unsigned int sample_size = 5;
    BuildItemMemory(memory, 10, dim, enc);

    printVec2d(memory);
    cout << endl << endl << endl;

    vector<int> indices = RandomSubset(memory, 5);
    printVec(indices);
    cout << endl << endl << endl;

    


};
