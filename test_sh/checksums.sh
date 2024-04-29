#!/bin/bash

# Specify the folder containing the FASTA files
fasta_folder="/path/to/folder"

# Specify the output file for computed checksums
computed_checksums_file="computed_checksums.txt"

# Create the output file for computed checksums if it doesn't exist
touch "${computed_checksums_file}"

# Compute MD5 checksums for FASTA files
for file in "${fasta_folder}"/*.{fasta,fasta.gz,fa}; do
    # Check if the file is gzipped
    if [[ "$file" == *.gz ]]; then
        md5sum <(gunzip -c "$file") >> "${computed_checksums_file}"
    else
        md5sum "$file" >> "${computed_checksums_file}"
    fi
done

echo "MD5 checksums have been computed and saved to ${computed_checksums_file}"

# Prompt to enter the provided checksums file
read -p "Enter the path to the provided checksums file (leave empty if none): " provided_checksums_path

# Check if the provided checksums file exists
if [[ -f "${provided_checksums_path}" ]]; then
    differences=$(diff "${computed_checksums_file}" "${provided_checksums_path}")

    if [ $? -eq 0 ]; then
        echo "Successful transfer: All files are complete."
    else
        echo "Files with differences:"
        
        # Echo the list of files with differences
        echo "${differences}"
        
        # Extract file names with differences
        echo "${differences}" | grep -oE '/.*:' | sed 's/://g' > different_files.txt
        echo "List of files with differences saved to different_files.txt"
    fi
else
    echo "No provided checksums file. Cannot compare."
fi
