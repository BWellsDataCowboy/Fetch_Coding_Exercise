import json
import os

# List of raw data files
files = [
    "raw_data/brands_raw.json",
    "raw_data/receipts_raw.json",
    "raw_data/users_raw.json",
]

for file_path in files:
    print(f"Processing file: {file_path}")
    try:
        with open(file_path, "r") as file:
            data = json.load(file)
        print(
            f"Successfully loaded {file_path} (records: {len(data) if isinstance(data, list) else '1 object'})"
        )
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
