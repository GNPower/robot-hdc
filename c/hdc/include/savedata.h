/*******************************************************************************
*   Hyperdimensional Computing Library
*
*   @file       savedata.h
*   @desc       Header file for saving hypervector encoding data
*   @author     Graham N. Power
*   @date       2023-10-04
*   @version    1.0.0 (Major.Minor.Patch)
*
*	<pre>
*
*   Revision History:
*
*	Ver   	Who    	Date   		Changes
*	----- 	---- 	-------- 	-------------------------------------------------------
*	1.0.0 	gnp   	2023-10-04 	Initial file writing for hypervector encodings
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
#ifndef HDC_SAVEDATA_H_
#define HDC_SAVEDATA_H_


/*******************************************************************************
*   Includes
*******************************************************************************/
#include <vector>
#include <string>
#include <string>
#include <iostream>
#include <sstream>
#include <fstream>

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
string stringVec(vector<T> &vec, unsigned int tab_in, bool tab_start, bool end_comma)
{
    unsigned int i, j;
    ostringstream oss;
    if (tab_start)
    {
        for (j = 0; j < tab_in; j++)
            oss << "\t";
    }
    oss << "[ \n";
    for (i = 0; i < vec.size() - 1; i++)
    {
        for (j = 0; j < tab_in + 1; j++)
            oss << "\t";
        oss << vec[i] << ", \n";
    }
    for (j = 0; j < tab_in + 1; j++)
        oss << "\t";
    oss << vec[i] << " \n";
    for (j = 0; j < tab_in; j++)
        oss << "\t";
    oss << "]";
    if (end_comma)
        oss << ",";
    oss << " \n";
    return oss.str();
};


template <typename T>
string stringVec2d(vector<vector<T>> &vec, unsigned int tab_in, bool tab_start, bool end_comma)
{
    unsigned int i, j;
    ostringstream oss;
    if (tab_start)
    {
        for (j = 0; j < tab_in; j++)
            oss << "\t";
    }
    oss << "[ \n";
    for (i = 0; i < vec.size() - 1; i++)
    {
        oss << stringVec(vec[i], tab_in + 1, true, true);
    }
    oss << stringVec(vec[vec.size()-1], tab_in + 1, true, false);
    for (j = 0; j < tab_in; j++)
        oss << "\t";
    oss << "]";
    if (end_comma)
        oss << ",";
    oss << "\n";
    return oss.str();
};


// TODO: test!
void OutputAllData(
    vector<vector<float>> &bundle_heatmap,
    vector<unsigned int> &reqdims_vs_bundle,
    vector<unsigned int> &dimension_list,
    vector<unsigned int> &bundle_list,
    string encoding_name
)
{
    ostringstream oss;
    // Add file start and name entry
    oss << "{ \n\t\"name\": \"" << encoding_name << "\",\n";
    // Add dimensions list
    oss << "\t\"dimension_list\": " << stringVec(dimension_list, 1, false, true);
    // Add bundle list
    oss << "\t\"bundle_list\": " << stringVec(bundle_list, 1, false, true);
    // Add bundle heatmap
    oss << "\t\"bundle_heatmap\": " << stringVec2d(bundle_heatmap, 1, false, true);
    // Add required dimensions vs. bundle
    oss << "\t\"reqdims_vs_bundle\": " << stringVec(reqdims_vs_bundle, 1, false, true);
    // Add required dimensions vs. memory size
    oss << "\t\"reqdims_vs_memsize\": " << "[],\n";
    // Add similarity vs. bind repetitions
    oss << "\t\"sim_vs_bindreps\": " << "[],\n";
    // Add bundle pair heatmap
    oss << "\t\"bundlepair_heatmap\": " << "[],\n";
    // Add required dimensions vs. bundle pairs
    oss << "\t\"reqdims_vs_bundlepair\": " << "[],\n";
    // Add required dimensions for 15 bundled pairs
    oss << "\t\"reqdims_15bundles\": " << "[]\n";
    // Add required bitwidth vs. bundle
    // oss << "\t\"reqbits_vs_bundle\": " << "[]\n";
    // Close the json dict
    oss << "}";
    // Write to the file and close it off
    string data = oss.str();
    ostringstream fname;
    fname << "json_output/" << encoding_name << ".json";
    string fname_s = fname.str();
    cout << "Filename: " << fname_s << endl;
    ofstream f(fname_s);
    f << data;
    f.close();
};


/*******************************************************************************
*   Prevent circular dependency
*   DO NOT REMOVE
*******************************************************************************/
#endif /* HDC_SAVEDATA_H_ */
