import json
import re
import os

# Define input and output file lists
input_files = [
    "raw_data/brands_raw.json",
    "raw_data/receipts_raw.json",
    "raw_data/users_raw.json",
]

output_files = [
    "formatted_data/brands.json",
    "formatted_data/receipts.json",
    "formatted_data/users.json",
]

# Create the output folder if it doesn't exist
os.makedirs("formatted_data", exist_ok=True)

# Process each file in a for loop
for in_file, out_file in zip(input_files, output_files):
    print(f"Processing: {in_file}")
    with open(in_file, "r") as f:
        content = f.read()

    # Insert commas between adjacent JSON objects and wrap in square brackets
    fixed_content = "[" + re.sub(r"}\s*{", "},{", content) + "]"

    # Load the fixed JSON content
    data = json.loads(fixed_content)

    # Write the formatted JSON to the output file
    with open(out_file, "w") as f:
        json.dump(data, f, indent=4)

    print(f"Written to: {out_file}")
