/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       elements.h
*   @desc       Header file for element generation
*   @author     Graham N. Power
*   @date       2023-09-29
*   @version    1.0.0 (Major.Minor.Patch)
*
*	<pre>
*
*   Revision History:
*
*	Ver   	Who    	Date   		Changes
*	----- 	---- 	-------- 	-------------------------------------------------------
*	1.0.0 	gnp   	2023-09-29 	Initial element generation code
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
#ifndef HDC_ELEMENTS_H_
#define HDC_ELEMENTS_H_


/*******************************************************************************
*   Includes
*******************************************************************************/
#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <vector>
#include <random>

using namespace std;

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
double randn(double mu, double sigma)
{
    /**
     * @brief Generate a number from the Normal Distribution
     * 
     * Samples from the normal distribution using the Marsaglia 
     * and Bray method. Source code from Phoxis website.
     * https://phoxis.org/2013/05/04/generating-random-numbers-from-normal-distribution-in-c/
     * 
     * @param mu mean of the normal distribution
     * @type mu double
     * @param sigma standard deviation of the normal distribution
     * @type sigma double
     */
    double U1, U2, W, mult;
    static double X1, X2;
    static int call = 0;

    if (call == 1)
    {
        call = !call;
        return (mu + sigma * (double) X2);
    }

    do
    {
        U1 = -1 + ((double) rand() / RAND_MAX) * 2;
        U2 = -1 + ((double) rand() / RAND_MAX) * 2;
        W = pow(U1, 2) + pow(U2, 2);
    }
    while (W >= 1 || W == 0);

    mult = sqrt( (double)((-2 * log(W)) / W) );
    X1 = U1 * mult;
    X2 = U2 * mult;

    call = !call;

    return (mu + sigma * (double) X1);
};


template <typename T>
void UniformBipolar(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief UniformBipolar X∈R, X_i ~ U(-1,1)
     * 
     * Uniform distribution of real numbers between -1 and 1
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions number of dimensions in the vector
     * @type dimensions unsigned int
     */
    // random_device rd;  // Will be used to obtain a seed for the random number engine
    // mt19937 gen(rd()); // Standard mersenne_twister_engine seeded with rd()
    // uniform_real_distribution<> dis(-1.0, 1.0);
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        // hypervector[i] = dis(gen);
        hypervector[i] = 2*((double) rand() / RAND_MAX) - 1;
        // cout << "i: " << i << " [i]: " << hypervector[i] << endl;
    }
};


template <typename T>
void BernoulliBiploar(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief BernoulliBiploar X∈Z, X_i ~ B(0.5)*2 - 1
     * 
     * Bernoulli distribution of bipolar numbers, either -1 or 1
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions number of dimensions in the vector
     * @type dimensions unsigned int
     */
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = (rand() & 2) - 1;
    }
};


template <typename T>
void BernoulliBinary(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief BernoulliBinary X∈{0,1}, X_i ~ B(0.5)
     * 
     * Bernoulli distribution of binary numbers, either 0 or 1
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     */
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = rand() & 1;
    }
};


template <typename T>
void BernoulliSparseAuto(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief BernoulliSparseAuto X∈{0,1}, X_i ~ B(p << 1)
     * 
     * Bernoulli distribution of binary numbers, either 0 or 1 with variable 
     * probability. If undefined probability is given as p = 1/sqrt(dimensions), 
     * which creates a sparsely populated array
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<uint8_t>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     * @param probability: probability of the Bernoulli distribution, defaults to 1/sqrt(d)
     * @type probability: float, optional
     */
    int upper_limit = RAND_MAX/sqrt((double)dimensions);
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = rand() < upper_limit ? 1 : 0;
    }
};


template <typename T>
void BernoulliSparse(vector<T> &hypervector, unsigned int dimensions, float probability)
{
    /**
     * @brief BernoulliSparse X∈{0,1}, X_i ~ B(p << 1)
     * 
     * Bernoulli distribution of binary numbers, either 0 or 1 with variable 
     * probability. If undefined probability is given as p = 1/sqrt(dimensions), 
     * which creates a sparsely populated array
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     * @param probability: probability of the Bernoulli distribution, defaults to 1/sqrt(d)
     * @type probability: float, optional
     */
    int upper_limit = RAND_MAX*probability;
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = rand() < upper_limit ? 1: 0;
    }
};


template <typename T>
void NormalReal(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief NormalReal X∈R, X_i ~ N(0, 1/d)
     * 
     * Normal distribution of real numbers with mean 0 and variance 1/d, 
     * where d is the dimension of the hypervector
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     */
    double p = 1/dimensions;
    double sigma = sqrt(p);
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = randn(0, sigma);
    }
};


template <typename T>
void SparseSegmented(vector<T> &hypervector, unsigned int dimensions, float probability)
{
    /**
     * @brief SparseSegmented X∈{0,1}, X_i ~ B(p << 1)
     * 
     * Sparsely segmented binary numbers, either 0 or 1 with variable 
     * probability. If undefined probability is given as p = 1/sqrt(dimensions). 
     * Hypervector is split into s, dimensions * probability, segments. Each segment 
     * populated with exactly 1 non-zero element uniformly distributed throughout the 
     * segment.
     * 
     * NOTE: Since s = dimensions * probability is not garunteed to evenly divide into 
     * the hypervector dimensions, the segment, s, is rounded up and the final hypervector trimmed. 
     * This means the non-zero value in the last segment may be trimmed and not be present in the 
     * final hypervector.
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     * @param probability: probability of the Bernoulli distribution, defaults to 1/sqrt(d)
     * @type probability: float, optional
     */
    unsigned int s = ceil((double)(dimensions * probability));
    unsigned int seg_d = ceil((double)(dimensions/s));
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = 0;
    }
    for (i = 0; i < s; i++)
    {
        unsigned int index = (rand() % (seg_d + 1));
        hypervector[(i*seg_d)+index] = 1;
    }
};


template <typename T>
void SparseSegmentedAuto(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief SparseSegmented X∈{0,1}, X_i ~ B(p << 1)
     * 
     * Sparsely segmented binary numbers, either 0 or 1 with variable 
     * probability. If undefined probability is given as p = 1/sqrt(dimensions). 
     * Hypervector is split into s, dimensions * probability, segments. Each segment 
     * populated with exactly 1 non-zero element uniformly distributed throughout the 
     * segment.
     * 
     * NOTE: Since s = dimensions * probability is not garunteed to evenly divide into 
     * the hypervector dimensions, the segment, s, is rounded up and the final hypervector trimmed. 
     * This means the non-zero value in the last segment may be trimmed and not be present in the 
     * final hypervector.
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<T>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     * @param probability: probability of the Bernoulli distribution, defaults to 1/sqrt(d)
     * @type probability: float, optional
     */
    double probability = 1/sqrt((double)dimensions);
    unsigned int s = ceil((double)(dimensions * probability));
    unsigned int seg_d = ceil((double)(dimensions/s));
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = 0;
    }
    for (i = 0; i < s; i++)
    {
        unsigned int index = (rand() % (seg_d + 1));
        hypervector[(i*seg_d)+index] = 1;
    }
};


template <typename T>
void UniformAngles(vector<T> &hypervector, unsigned int dimensions)
{
    /**
     * @brief UniformAngles θ∈R, θ_i ~ U(-pi, pi)
     * 
     * Uniformly distributed angles from -pi to pi. Useful for a 
     * complex hypervector representation X∈C, X_i = e^(i*θ). In this 
     * case, the complex vector is assumed to be on the unit circle 
     * (length one) so we only need to store the real angle, θ, and 
     * the hypervector X can be computed as needed from the hypervector θ.
     * 
     * @param hypervector pointer to the hypervector array
     * @type hypervector vector<float>
     * @param dimensions: number of dimensions in the vector
     * @type dimensions: unsigned int
     */
    unsigned int i;
    for (i = 0; i < dimensions; i++)
    {
        hypervector[i] = -3.14159265358979323846 + (((double) rand() / RAND_MAX) * (2*3.14159265358979323846));
    }
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_ELEMENTS_H_ */
