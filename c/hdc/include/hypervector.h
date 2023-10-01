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
        void (*similarity_func)(vector<T> &a, vector<T> &b);
        void (*bundling_func)(vector<T> &result, vector<vector<T>> &hypervectors);
        void (*binding_func)(vector<T> &result, vector<vector<T>> &hypervectors);
        void (*unbinding_func)(vector<T> &result, vector<vector<T>> &hypervectors);        

    public:
        Encoding(
            int dimensions,
            void (*element_func)(vector<T> &hypervector, unsigned int dimensions),
            void (*similarity_func)(vector<T> &a, vector<T> &b),
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

        void generate(vector<T> hypervector)
        {
            this->element_func(hypervector, this->dimensions);
        };

        void generate(vector<T> hypervector, unsigned int dimensions)
        {
            this->element_func(hypervector, dimensions);
        };

        float similarity(vector<T> a, vector<T> b)
        {
            this->similarity_func(a, b);
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


template <typename T> 
class MAP_C : public Encoding {
    public:
        MAP_C(unsigned int dimensions) : Encoding(
            dimensions,
            UniformBipolar<T>,
            CosineSimilarity<T>,
            ElementAdditionCutBipolar<T>,
            ElementMultiplication<T>,
            ElementMultiplication<T>
        ) {};
};


template <typename T> 
class MAP_I : public Encoding {
    public:
        MAP_I(unsigned int dimensions) : Encoding(
            dimensions,
            BernoulliBiploar<T>,
            CosineSimilarity<T>,
            ElementAddition<T>,
            ElementMultiplication<T>,
            ElementMultiplication<T>
        ) {};
};


template <typename T> 
class HRR : public Encoding {
    public:
        HRR(unsigned int dimensions) : Encoding(
            dimensions,
            NormalReal<T>,
            CosineSimilarity<T>,
            ElementAdditionNormalized<T>,
            CircularConvolution<T>,
            CircularCorrelation<T>
        ) {};
};


template <typename T> 
class VTB : public Encoding {
    public:
        VTB(unsigned int dimensions) : Encoding(
            dimensions,
            NormalReal<T>,
            CosineSimilarity<T>,
            ElementAdditionNormalized<T>,
            VectorDerivedTransformation<T>,
            TransposeVectorDerivedTransformation<T>
        ) {};
};


template <typename T> 
class MBAT : public Encoding {
    public:
        MBAT(unsigned int dimensions) : Encoding(
            dimensions,
            NormalReal<T>,
            CosineSimilarity<T>,
            ElementAdditionNormalized<T>,
            MatrixMultiplication<T>,
            InverseMatrixMultiplication<T>
        ) {};
};


template <typename T> 
class MAP_B : public Encoding {
    public:
        MAP_B(unsigned int dimensions) : Encoding(
            dimensions,
            BernoulliBiploar<T>,
            CosineSimilarity<T>,
            ElementAdditionBipolarThreshold<T>,
            ElementMultiplication<T>,
            ElementMultiplication<T>
        ) {};
};


template <typename T> 
class BSC : public Encoding {
    public:
        BSC(unsigned int dimensions) : Encoding(
            dimensions,
            BernoulliBiploar<T>,
            HammingDistance<T>,
            ElementAdditionBinaryThreshold<T>,
            ExclusiveOr<T>,
            ExclusiveOr<T>
        ) {};
};


template <typename T> 
class BSDC_CDT : public Encoding {
    public:
        BSDC_CDT(unsigned int dimensions) : Encoding(
            dimensions,
            BernoulliSparseAuto<T>,
            Overlap<T>,
            Disjunction<T>,
            ContextDependThinning<T>,
            ContextDependThinning<T>
        ) {};
};


template <typename T> 
class BSDC_S : public Encoding {
    public:
        BSDC_S(unsigned int dimensions) : Encoding(
            dimensions,
            BernoulliSparseAuto<T>,
            Overlap<T>,
            Disjunction<T>,
            Shifting<T>,
            Shifting<T>
        ) {};
};


template <typename T> 
class BSDC_SEG : public Encoding {
    public:
        BSDC_SEG(unsigned int dimensions) : Encoding(
            dimensions,
            SparseSegmented<T>,
            Overlap<T>,
            Disjunction<T>,
            SegmentShifting<T>,
            SegmentShifting<T>
        ) {};
};


template <typename T> 
class FHRR : public Encoding {
    public:
        FHRR(unsigned int dimensions) : Encoding(
            dimensions,
            UniformAngles<T>,
            AngleDistance<T>,
            AnglesOfElementAddition<T>,
            ElementAngleAddition<T>,
            ElementAngleSubtraction<T>
        ) {};
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_HYPERVECTOR_H_ */
