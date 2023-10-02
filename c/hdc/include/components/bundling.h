/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       bundling.h
*   @desc       Header file for bundling operations
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
*	1.0.0 	gnp   	2023-09-29 	Initial hypervector bundling operations
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
#ifndef HDC_BUNDLING_H_
#define HDC_BUNDLING_H_


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
void ElementAddition(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief ElementAddition Elementwise addition of Hypervectors
     * 
     * Elementwise addition of any number of hypervectors, passed 
     * in either as independant function parameters or a list of 
     * hypervectors as a single function input.
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<T>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<T>>
     */
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        T sum = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            sum += hypervectors[i][j];
        }
        result[j] = sum;
    }
};


template <typename T>
void ElementAdditionCutBipolar(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief ElementAdditionCut Elementwise addition if Hypervectors with Cutting
     * 
     * Elementwise addition with cutting of any number of hypervectors, 
     * in either as independant function parameters or a list of 
     * hypervectors as a single function input. Cutting limits the 
     * output of the element addition from min and max inputs to the 
     * function. This cutting is done only once after the full sum 
     * is calculated.
     * 
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<T>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<T>>
     */
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        T sum = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            sum += hypervectors[i][j];
        }
        if (sum > 1)
        {
            result[j] = 1;
        }
        else if (sum < -1)
        {
            result[j] = -1;
        }
        else
        {
            result[j] = sum;
        }
    }
};


template <typename T>
void ElementAdditionNormalized(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief ElementAdditionNormalized Elementwise addition normalized to unit length
     * 
     * Elementwise addition with normalization of any number of hypervectors, 
     * in either as independant function parameters or a list of 
     * hypervectors as a single function input. Normalization scales 
     * the output hypervector to unit length (one). This normalization 
     * is done only once after the full sum is calculated.
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<T>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<T>>
     */
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        int sum = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            sum += hypervectors[i][j];
        }
        result[j] = sum;
    }
    // Normalize the summed vector
    double mod = 0;
    for (i = 0; i < result.size(); i++) {
        mod += result[i] * result[i];
    }
    double mag = sqrt(mod);
    for (i = 0; i < result.size(); i++) {
        result[i] = (T)(result[i] / mag);
    }
};


template <typename T>
void ElementAdditionBinaryThreshold(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief ElementAdditionThreshold Elementwise addition with thresholded binary output
     * 
     * Elementwise addition with thresholded binary output of any 
     * number of hypervectors, either as independant function 
     * parameters or a list of hypervectors as a single function 
     * input. Thresholding adds all the input hypervectors 
     * together and for each element, if it is greater than 
     * half the number of hypervectors passed in, sets the 
     * output element to max, otherwise sets the element to
     * min.
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<uint8_t>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<uint8_t>>
     */
    T threshold = hypervectors.size() / 2;
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        T sum = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            sum += hypervectors[i][j];
        }
        result[j] = sum >= threshold ? 1 : 0;
    }
};


template <typename T>
void ElementAdditionBipolarThreshold(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief ElementAdditionThreshold Elementwise addition with thresholded binary output
     * 
     * Elementwise addition with thresholded binary output of any 
     * number of hypervectors, either as independant function 
     * parameters or a list of hypervectors as a single function 
     * input. Thresholding adds all the input hypervectors 
     * together and for each element, if it is greater than 
     * half the number of hypervectors passed in, sets the 
     * output element to max, otherwise sets the element to
     * min.
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<T>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<T>>
     */
    T threshold = hypervectors.size() / 2;
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        T sum = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            sum += hypervectors[i][j];
        }
        result[j] = sum >= threshold ? 1 : -1;
    }
};


template <typename T>
void Disjunction(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief Disjunction Elementwise XOR with binary output
     * 
     * Elementwise XOR with binary output of any number 
     * of hypervectors, either as independant function 
     * parameters or a list of hypervectors as a single 
     * function input. All hypervectors are added together 
     * and for each element, if its value is greater or equal 
     * to one, the output is set to one, otherwise it is set 
     * to zero.
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<uint8_t>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<uint8_t>>
     */
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        T xor_ = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            xor_ ^= hypervectors[i][j];
        }
        result[j] = xor_;
    }
};


template <typename T>
void AnglesOfElementAddition(vector<T> &result, vector<vector<T>> &hypervectors)
{
    /**
     * @brief AnglesOfElementAddition Adds angles of complex hypervectors discarding magnitude
     * 
     * Adds the angles of any number of complex hypervectors, 
     * either as independant function parameters or a list of 
     * hypervectors as a single input. Hypervectors are assumed 
     * to be complex where the angles are stored. Hypervectors 
     * are added and their resulting angles returned. Magnitudes 
     * are discarded as they are assumed fixed to unit length.
     * 
     * @param result pointer to the resulting hypervector array
     * @type result vector<float>
     * @param hypervectors pointer to the array of hypervectors
     * @type hypervector vector<vector<float>>
     */
    // TODO: Do I have to limit vector output to 0->2pi, -pi->pi, or not at all??
    unsigned int i, j;
    for(j = 0; j < hypervectors[0].size(); j++)
    {
        T real = 0;
        T im = 0;
        for(i = 0; i < hypervectors.size(); i++)
        {
            real += cos(hypervectors[i][j]);
            im += sin(hypervectors[i][j]);
        }
        result[j] = (T)atan2(im, real);
    }
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_BUNDLING_H_ */
