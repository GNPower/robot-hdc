/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       similarity.h
*   @desc       Header file for similarity comparison
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
*	1.0.0 	gnp   	2023-09-29 	Initial similarity comparison code
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
#ifndef HDC_SIMILARITY_H_
#define HDC_SIMILARITY_H_


/*******************************************************************************
*   Includes
*******************************************************************************/
#include <stdlib.h>
#include <math.h>
#include <cmath>
#include <vector>

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
template <typename T>
float CosineSimilarity(vector<T> a, vector<T> b)
{
    /**
     * @brief CosineSimilarity Cosine Similarity of two vectors
     * 
     * cos(θ) = ( A dot B ) / ( norm(A) * norm(B) )
     * 
     * @param a pointer to the hypervector a
     * @type a vector<T>
     * @param b pointer to the hypervector b
     * @type b vector<T>
     * @return cosine similarity metric
     * @rtpye float
     */
    double moda = 0;
    double modb = 0;
    double dot = 0;
    unsigned int i;
    for (i = 0; i < a.size(); i++) {
        moda += a[i] * a[i];
        modb += b[i] * b[i];
        dot += a[i] * b[i];
    }
    double maga = sqrt(moda);
    double magb = sqrt(modb);
    return dot / (maga * magb);
};


template <typename T>
float HammingDistance(vector<T> a, vector<T> b)
{
    /**
     * @brief HammingDistance Hamming Distance of two vectors
     * 
     * Counts the number of elements in the hypervectors where A[i] != B[i]. 
     * Result is normalized to the size of the hypervector so it is always in 
     * the range [0,1].
     * 
     * @param a pointer to the hypervector a
     * @type a vector<T>
     * @param b pointer to the hypervector b
     * @type b vector<T>
     * @return cosine similarity metric
     * @rtpye float
     */
    unsigned int i;
    float hamming = 0;
    for (i = 0; i < a.size(); i++) {
        if (a[i] || b[i])
        {
            hamming++;
        }
    }
    return hamming / a.size();
};


template <typename T>
float Overlap(vector<T> a, vector<T> b)
{
    /**
     * @brief Overlap Overlap of two vectors
     * 
     * Counts the number of elements in the hyypervectors where both A[i] and 
     * B[i] are 1. Useful for sparce hypervectors. Result is normalized to the 
     * max number of nonzero elements in the hypervectors so it is always in the 
     * range [0,1].
     * 
     * @param a pointer to the hypervector a
     * @type a vector<T>
     * @param b pointer to the hypervector b
     * @type b vector<T>
     * @return cosine similarity metric
     * @rtpye float
     */
    unsigned int i;
    float overlap = 0;
    for (i = 0; i < a.size(); i++) {
        if (a[i] && b[i])
        {
            overlap++;
        }
    }
    return overlap / a.size();
};


template <typename T>
float AngleDistance(vector<T> a, vector<T> b)
{
    /**
     * @brief AngleDistance Angle Distance of two hypervectors
     * 
     * Calculates the average angular distance of two complex hypervectors 
     * of unit length. Results are normalized to the size of the hypervectors 
     * so it is always in the range [0,1].
     * 
     * @param a pointer to the hypervector a
     * @type a vector<T>
     * @param b pointer to the hypervector b
     * @type b vector<T>
     * @return cosine similarity metric
     * @rtpye float
     */
    unsigned int i;
    float distance = 0;
    for (i = 0; i < a.size(); i++) {
        distance += cos(a[i]) - cos(b[i]);
    }
    return distance / a.size();
};

/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_SIMILARITY_H_ */
