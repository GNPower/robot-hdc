/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       hypervector.cpp
*   @desc       Hypervector representation
*   @author     Graham N. Power
*   @date      	2023-09-29
*   @version    1.0.0 (Major.Minor.Patch)
*
*	<pre>
*
*	Detailed description of driver goes here.
*
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
*   Includes
*******************************************************************************/
#include "hypervector.h"

#include <vector>

#include "components/elements.h"
#include "components/similarity.h"
#include "components/bundling.h"

using namespace std;


/*******************************************************************************
*   Preprocessor Macros
*******************************************************************************/


/*******************************************************************************
*   Datatype Definitions
*******************************************************************************/
typedef struct {
    void (*element_func)(void * hypervector, unsigned int dimensions);
    void (*similarity_func)(void * a, void * b);
    void (*bundling_func)(void * result, void * hypervectors);
//    void (*thinning_func)(void * result, void * hypervector)
    void (*binding_func)(void * result, void * hypervectors);
    void (*unbinding_func)(void * result, void * hypervectors);
} HypervectorEncoding_t;


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
