/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       binding.h
*   @desc       Header file for binding operations
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
*	1.0.0 	gnp   	2023-09-29 	Initial hypervector binding operations
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
#ifndef HDC_BINDING_H_
#define HDC_BINDING_H_


/*******************************************************************************
*   Includes
*******************************************************************************/


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
void ElementMultiplication(vector<T> &result, vector<vector<T>> &hypervectors)
{
    
};


template <typename T>
void CircularConvolution(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void CircularCorrelation(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void VectorDerivedTransformation(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void TransposeVectorDerivedTransformation(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void MatrixMultiplication(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void InverseMatrixMultiplication(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void ExclusiveOr(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void Shifting(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void SegmentShifting(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void ContextDependThinning(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void ElementAngleAddition(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


template <typename T>
void ElementAngleSubtraction(vector<T> &result, vector<vector<T>> &hypervectors)
{

};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_BINDING_H_ */
