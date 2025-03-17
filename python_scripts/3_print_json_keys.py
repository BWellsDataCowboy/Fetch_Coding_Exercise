import json
import os

def traverse_json(data, node):
    if isinstance(data, dict):
        for k, v in data.items():
            # Get or create a structure for this key
            # node.setdefault(...) ensures a default if k is not present.
            child = node.setdefault(k, {"types": set(), "children": {}})
            
            # Deduce and record the type
            child["types"].add(
                "dict" if isinstance(v, dict)
                else "list" if isinstance(v, list)
                else "value"
            )
            # Recurse down one level
            traverse_json(v, child["children"])
    elif isinstance(data, list):
        for item in data:
            traverse_json(item, node)

def print_tree(tree, indent=0):
    for key, info in tree.items():
        # Sort the types for consistent output, then join with commas
        types_str = ", ".join(sorted(info["types"]))
        print("    " * indent + f"{key} ({types_str})")
        # Recurse into child nodes
        print_tree(info["children"], indent + 1)

# Files to process
files_to_process = [
    "formatted_data/brands.json",
    "formatted_data/receipts.json",
    "formatted_data/users.json",
]

for path in files_to_process:
    if os.path.exists(path):
        print(f"\nProcessing file: {path}\n{'=' * 50}")
        with open(path, "r", encoding="utf-8") as file:
            data = json.load(file)
        
        tree = {}
        traverse_json(data, tree)
        
        print("Hierarchical unique keys with types:")
        print_tree(tree)
    else:
        print(f"File not found: {path}")
