import time
from typing import List
from tqdm import tqdm
from multiprocessing import Pool, Process, cpu_count, pool

from bundle_accuracies import AllBundleAccuracy, AllBundleAccuracy_Multiprocessed, GenerateDimensionsRequiredFor99PercentAccuracy, MONTECARLO_RUNS, MEMORY_SIZE, BUNDLE_NUMBER, DIMENSIONS
from plot_generation import PlotBundleAccuracyGraph, PlotDimensionsRequiredFor99PercentAccuracy
from load_store import OutputAllData, LoadAllData

from hdc.hypervector import BSC, FHRR, HRR, MAP_B, MAP_C, MAP_I, MBAT, VTB, Encoding


# MEMORY_SIZE = 1_000
# DIMENSIONS = [i**2 for i in range(2,34)]
# BUNDLE_NUMBER = [k for k in range(2,50)]

# MONTECARLO_RUNS = 1


class NoDaemonProcess(Process):
    def _get_daemon(self):
        return False
    def _set_daemon(self, value):
        pass
    daemon = property(_get_daemon, _set_daemon)


class MyPool(pool.Pool):
    Process = NoDaemonProcess


def buildEncodingPool(encodings: List[Encoding]) -> List[any]:
    num_proc = cpu_count()
    if num_proc > len(encodings):
        num_proc = len(encodings)
    p = MyPool(processes=num_proc)
    results = p.starmap(AllBundleAccuracy, [(1_000, enc, DIMENSIONS, BUNDLE_NUMBER,) for enc in encodings])
    p.close()
    p.join()
    return results


if __name__ == '__main__':
    enc = MAP_I(1_000)


    # encodings = [BSC(1_000), FHRR(1_000), HRR(1_000), MAP_B(1_000), MAP_C(1_000), MAP_I(1_000), MBAT(1_000), VTB(1_000)]
    # encoding_names = ["BSC", "FHRR", "HRR", "MAP-B", "MAP-C", "MAP-I", "MBAT", "VTB"]

    # start_time = time.time()
    # p = Pool(processes=len(encodings))
    # results = p.starmap(AllBundleAccuracy, [(1_000, enc, DIMENSIONS, BUNDLE_NUMBER,) for enc in encodings])
    # p.close()
    # results = buildEncodingPool(encodings)

    # results = [AllBundleAccuracy(1_000, enc, DIMENSIONS, BUNDLE_NUMBER,) for enc in encodings]
    # results = [AllBundleAccuracy(1_000, encodings[0], DIMENSIONS, BUNDLE_NUMBER)]
    # print(results)

    # results = AllBundleAccuracy_Multiprocessed(1_000, encodings, DIMENSIONS, BUNDLE_NUMBER)
    # gresults = [GenerateDimensionsRequiredFor99PercentAccuracy(res, DIMENSIONS, BUNDLE_NUMBER) for res in results]
    # results = AllBundleAccuracy(1_000, encodings[0], DIMENSIONS, BUNDLE_NUMBER)

    # 17 Seconds
    # procs = []
    # for enc in encodings:
    #     proc = Process(target=AllBundleAccuracy, args=(1_000, enc, DIMENSIONS, BUNDLE_NUMBER,))
    #     procs.append(proc)
    #     proc.start()
    # for proc in procs:
    #     proc.join()
    # end_time = time.time()

    # print("--- %s seconds ---" % (end_time - start_time))

    # for i in range(len(results)):
    #     OutputAllData(
    #         results[i], 
    #         gresults[i], 
    #         DIMENSIONS, 
    #         BUNDLE_NUMBER, 
    #         encoding_names[i]
    #     )

    # PlotBundleAccuracyGraph(results[0], DIMENSIONS, BUNDLE_NUMBER, encoding_names[0])
    # PlotBundleAccuracyGraph(results, DIMENSIONS, BUNDLE_NUMBER, encoding_names[0])

    # for i in range(len(results)):
        # PlotBundleAccuracyGraph(results[i], DIMENSIONS, BUNDLE_NUMBER, encoding_names[i])

# results_bundle_heatmap = AllBundleAccuracy(1_000, enc, DIMENSIONS, BUNDLE_NUMBER)
# results_reqdims_vs_bundle = GenerateDimensionsRequiredFor99PercentAccuracy(results_bundle_heatmap, DIMENSIONS, BUNDLE_NUMBER)
# OutputAllData(
#     results_bundle_heatmap, 
#     results_reqdims_vs_bundle,
#     DIMENSIONS, 
#     BUNDLE_NUMBER, 
#     "Test"
# )

data = LoadAllData("Test")
dimension_list = data["dimension_list"]
bundle_list = data["bundle_list"]
accuracy_data = data["bundle_heatmap"]
reqdims_vs_bundle_data = data["reqdims_vs_bundle"]
# PlotBundleAccuracyGraph(accuracy_data, dimension_list, bundle_list, "Test")
PlotDimensionsRequiredFor99PercentAccuracy([reqdims_vs_bundle_data], dimension_list, bundle_list, ["Test"])