from typing import Dict, List
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap
from matplotlib._color_data import TABLEAU_COLORS
import numpy as np


def PlotBundleAccuracyGraph(accuracy_data: List[List[float]], dimension_list: List[int], bundle_list: List[int], encoding_name: str) -> None:
    """PlotBundleAccuracyGraph Heatmap of bundling accuracies for various dimensions and number of bundled vectors

    :param accuracy_data: Bundle accuracy data produced by bundle_accuracies.py 
    :type accuracy_data: List[List[float]]
    :param dimension_list: List of dimensions for the heatmap axis
    :type dimension_list: List[int]
    :param bundle_list: List of number of bundled vectors for the heatmap axis
    :type bundle_list: List[int]
    :param encoding_name: Name of the encoding to be used in the heatmap title and file name
    :type encoding_name: str
    """
    # Create a colour map for the heatmap
    colours = ['#000089', '#0000E8', '#0050FF', '#00B6FF', '#1AFFE4', '#80FF7F', '#E7FF18', '#FFAF00', '#FF4B00', '#E30000', '#840000']
    cvalues = [0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1.]
    clist = list(zip(cvalues, colours))
    cmap = LinearSegmentedColormap.from_list('hmap', clist, N=256)

    plt.imshow(accuracy_data[::-1], cmap=cmap, interpolation='nearest')
    plt.colorbar()
    plt.xlabel("# bundled vectors")
    plt.xticks(range(len(bundle_list)), bundle_list)
    plt.ylabel("# dimensions")
    plt.yticks(range(len(dimension_list)), dimension_list[::-1])
    plt.title(encoding_name)
    plt.savefig(f"heatmap_output/{encoding_name}.png")
    plt.show()


def PlotDimensionsRequiredFor99PercentAccuracy(reqdims_data: List[List[int]], dimension_list: List[int], bundle_list: List[int], encoding_names: List[str]) -> None:
    """PlotDimensionsRequiredFor99PercentAccuracy Graph of the number of required dimensions to recover bundled vectors with at least 99% accuracy

    :param reqdims_data: Required dimensions list produced by bundle_accuracies.py
    :type reqdims_data: List[int]
    :param dimension_list: List of dimensions for the graph axis
    :type dimension_list: List[int]
    :param bundle_list: List of the number of bundled vectors for the graph axis
    :type bundle_list: List[int]
    :param encoding_name: Name of the encoding to be used in the graph title and file name
    :type encoding_name: str
    """
    colourlist = list(TABLEAU_COLORS.keys())

    for index in range(len(reqdims_data)):
        data = reqdims_data[index]
        x_list = [bundle_list[i] for i in range(len(bundle_list)) if data[i] > 0]
        y_list = [data[i] for i in range(len(data)) if data[i] > 0]
        plt.plot(x_list, y_list, linestyle = 'dotted', color = colourlist[index])
        
        coef = np.polyfit(x_list, y_list, 1)
        poly1d_fn = np.poly1d(coef)
        plt.plot(x_list, poly1d_fn(x_list), linestyle = 'solid', color = colourlist[0], label = encoding_names[index])
    
    plt.xlabel("# bundled vectors")
    # plt.xticks(range(len(bundle_list)), bundle_list)
    plt.gca().grid(which='major', axis='both', linestyle='--')
    plt.ylabel("# dimensions")
    plt.title(f"Minimum required number of dimensions to reach 99% accuracy")
    plt.legend()
    plt.show()
