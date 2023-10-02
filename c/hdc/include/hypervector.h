/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       hypervector.h
*   @desc       Header file for hypervector representation
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
*	1.0.0 	gnp   	2023-09-29 	Initial hypervector representation
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
#ifndef HDC_HYPERVECTOR_H_
#define HDC_HYPERVECTOR_H_


/*******************************************************************************
*   Includes
*******************************************************************************/
#include "components/elements.h"
#include "components/bundling.h"
#include "components/binding.h"
#include "components/similarity.h"


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
class Encoding {
    private:
        int dimensions;
        void (*element_func)(vector<T> &hypervector, unsigned int dimensions);
        float (*similarity_func)(vector<T> a, vector<T> b);
        void (*bundling_func)(vector<T> &result, vector<vector<T>> &hypervectors);
        void (*binding_func)(vector<T> &result, vector<vector<T>> &hypervectors);
        void (*unbinding_func)(vector<T> &result, vector<vector<T>> &hypervectors);

    public:
        Encoding(
            int dimensions,
            void (*element_func)(vector<T> &hypervector, unsigned int dimensions),
            float (*similarity_func)(vector<T> a, vector<T> b),
            void (*bundling_func)(vector<T> &result, vector<vector<T>> &hypervectors),
            void (*binding_func)(vector<T> &result, vector<vector<T>> &hypervectors),
            void (*unbinding_func)(vector<T> &result, vector<vector<T>> &hypervectors)
        ) 
        {
            this->dimensions = dimensions;
            this->element_func = element_func;
            this->similarity_func = similarity_func;
            this->bundling_func = bundling_func;
            this->binding_func = binding_func;
            this->unbinding_func = unbinding_func;
        };

        unsigned int getDimensions() 
        {
            return this->dimensions;
        };

        void generate(vector<T> &hypervector)
        {
            this->element_func(hypervector, this->dimensions);
        };

        void generate(vector<T> &hypervector, unsigned int dimensions)
        {
            this->element_func(hypervector, dimensions);
        };

        float similarity(vector<T> a, vector<T> b)
        {
            return this->similarity_func(a, b);
        };

        void bundle(vector<T> &result, vector<vector<T>> &hypervectors)
        {
            this->bundling_func(result, hypervectors);
        };

        void bind(vector<T> &result, vector<vector<T>> &hypervectors)
        {
            this->binding_func(result, hypervectors);
        };

        void unbind(vector<T> &result, vector<vector<T>> &hypervectors)
        {
            this->unbinding_func(result, hypervectors);
        };
};


class MAP_C : public Encoding<double> {
    public:
        MAP_C(unsigned int dimensions) : Encoding<double>(
            dimensions,
            UniformBipolar<double>,
            CosineSimilarity<double>,
            ElementAdditionCutBipolar<double>,
            ElementMultiplication<double>,
            ElementMultiplication<double>
        ) {};
};


class MAP_I : public Encoding<int> {
    public:
        MAP_I(unsigned int dimensions) : Encoding<int>(
            dimensions,
            BernoulliBiploar<int>,
            CosineSimilarity<int>,
            ElementAddition<int>,
            ElementMultiplication<int>,
            ElementMultiplication<int>
        ) {};
};


class HRR : public Encoding<double> {
    public:
        HRR(unsigned int dimensions) : Encoding<double>(
            dimensions,
            NormalReal<double>,
            CosineSimilarity<double>,
            ElementAdditionNormalized<double>,
            CircularConvolution<double>,
            CircularCorrelation<double>
        ) {};
};


class VTB : public Encoding<double> {
    public:
        VTB(unsigned int dimensions) : Encoding<double>(
            dimensions,
            NormalReal<double>,
            CosineSimilarity<double>,
            ElementAdditionNormalized<double>,
            VectorDerivedTransformation<double>,
            TransposeVectorDerivedTransformation<double>
        ) {};
};


class MBAT : public Encoding<double> {
    public:
        MBAT(unsigned int dimensions) : Encoding<double>(
            dimensions,
            NormalReal<double>,
            CosineSimilarity<double>,
            ElementAdditionNormalized<double>,
            MatrixMultiplication<double>,
            InverseMatrixMultiplication<double>
        ) {};
};


class MAP_B : public Encoding<int> {
    public:
        MAP_B(unsigned int dimensions) : Encoding<int>(
            dimensions,
            BernoulliBiploar<int>,
            CosineSimilarity<int>,
            ElementAdditionBipolarThreshold<int>,
            ElementMultiplication<int>,
            ElementMultiplication<int>
        ) {};
};


class BSC : public Encoding<unsigned int> {
    public:
        BSC(unsigned int dimensions) : Encoding<unsigned int>(
            dimensions,
            BernoulliBiploar<unsigned int>,
            HammingDistance<unsigned int>,
            ElementAdditionBinaryThreshold<unsigned int>,
            ExclusiveOr<unsigned int>,
            ExclusiveOr<unsigned int>
        ) {};
};


class BSDC_CDT : public Encoding<unsigned int> {
    public:
        BSDC_CDT(unsigned int dimensions) : Encoding<unsigned int>(
            dimensions,
            BernoulliSparseAuto<unsigned int>,
            Overlap<unsigned int>,
            Disjunction<unsigned int>,
            ContextDependThinning<unsigned int>,
            ContextDependThinning<unsigned int>
        ) {};
};


class BSDC_S : public Encoding<unsigned int> {
    public:
        BSDC_S(unsigned int dimensions) : Encoding<unsigned int>(
            dimensions,
            BernoulliSparseAuto<unsigned int>,
            Overlap<unsigned int>,
            Disjunction<unsigned int>,
            Shifting<unsigned int>,
            Shifting<unsigned int>
        ) {};
};


class BSDC_SEG : public Encoding<unsigned int> {
    public:
        BSDC_SEG(unsigned int dimensions) : Encoding<unsigned int>(
            dimensions,
            SparseSegmentedAuto<unsigned int>,
            Overlap<unsigned int>,
            Disjunction<unsigned int>,
            SegmentShifting<unsigned int>,
            SegmentShifting<unsigned int>
        ) {};
};


class FHRR : public Encoding<double> {
    public:
        FHRR(unsigned int dimensions) : Encoding<double>(
            dimensions,
            UniformAngles<double>,
            AngleDistance<double>,
            AnglesOfElementAddition<double>,
            ElementAngleAddition<double>,
            ElementAngleSubtraction<double>
        ) {};
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_HYPERVECTOR_H_ */
