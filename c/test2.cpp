
#include <iostream>

#include "percision/floatx.hpp"
#include "percision./custom_int.h"

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
    cout << "Floats: " << endl << endl;
    typedef flx::floatx<7, 12> Float_7_12;
    Float_7_12 a1 = 1.2;
    Float_7_12 b1 = 2;
    cout << "a: " << a1<< endl;
    cout << "b: " << b1 << endl;

    int c1 = a1 + b1;
    cout << "c: " << c1 << endl;

    cout << endl << endl << endl;
    cout << "Ints: " << endl << endl;

    typedef Int<5> Int5;
    Int5 a2 = -3;
    Int5 b2 = 2;
    cout << "a: " << a2<< endl;
    cout << "b: " << b2 << endl;

    int c2 = a2;
    c2 += 2 + b2;
    cout << "c: " << c2 << endl;

    cout << endl << endl << endl;
    cout << "Generation: " << endl << endl;

    cout << "MaxVal: " << a2.max() << endl << endl;

    vector<Float_7_12> vec1(10);
    UniformBipolar(vec1, 10);
    printVec(vec1);

    cout << endl << endl << endl;
    cout << "Comparison: " << endl << endl;
    vMAP_C<7, 12> enc(10);

    

    return 0;
}