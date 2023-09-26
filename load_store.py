import json
from typing import List, Tuple


def OutputAllData(
    bundle_heatmap: List[List[float]], 
    reqdims_vs_bundle: List[int], 
    dimension_list: List[int], 
    bundle_list: List[int], 
    encoding_name: str
) -> None:
    output_data = {
        "name": encoding_name,
        "dimension_list": dimension_list,
        "bundle_list": bundle_list,
        "bundle_heatmap": bundle_heatmap,
        "reqdims_vs_bundle": reqdims_vs_bundle,
        "reqdims_vs_memsize": [],
        "sim_vs_bindreps": [],
        "bundlepair_heatmap": [],
        "reqdims_vs_bundlepair": [],
        "reqdims_15bundles": [],
    }
    output_json = json.dumps(output_data, indent=4)
    with open(f"json_output/{encoding_name}.json", "w") as file:
        file.write(output_json)


def LoadAllData(encoding_name: str) -> Tuple[List[int], List[int], List[List[float]]]:
    with open(f"heatmap_output/{encoding_name}.json", "r") as file:
        json_object = json.load(file)
    return json_object
