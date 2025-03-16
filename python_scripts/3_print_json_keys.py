import json
import os


def add_keys(data, tree):
    if isinstance(data, dict):
        for key, value in data.items():
            if key not in tree:
                # Each key maps to a node with a set for types and a dictionary for children.
                tree[key] = {"types": set(), "children": {}}
            # Record the type of this value
            if isinstance(value, dict):
                tree[key]["types"].add("dict")
            elif isinstance(value, list):
                tree[key]["types"].add("list")
            else:
                tree[key]["types"].add("value")
            # Recurse into the value
            add_keys(value, tree[key]["children"])
    elif isinstance(data, list):
        for item in data:
            add_keys(item, tree)
    # For other types, do nothing


def print_tree(tree, indent=0):
    for key, node in tree.items():
        # Create a comma-separated string of the types
        types_str = ", ".join(sorted(node["types"]))
        print("    " * indent + f"{key} ({types_str})")
        print_tree(node["children"], indent + 1)


# List of formatted files to process
formatted_files = [
    "formatted_data/brands.json",
    "formatted_data/receipts.json",
    "formatted_data/users.json",
]

# Process each file and print its keys tree
for file_path in formatted_files:
    if os.path.exists(file_path):
        print(f"\nProcessing file: {file_path}\n{'=' * 50}")
        with open(file_path, "r", encoding="utf-8") as file:
            data = json.load(file)
        keys_tree = {}
        add_keys(data, keys_tree)
        print("Hierarchical unique keys with types:")
        print_tree(keys_tree)
    else:
        print(f"File not found: {file_path}")
