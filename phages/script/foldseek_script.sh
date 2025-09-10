#!/bin/bash

pdb_files='/Users/qjs599/Desktop/phylostruct/phylostruct/data/raw/rep_pdbs2'

result='/Users/qjs599/Desktop/phylostruct/phylostruct/data/processed/foldmason_align'

tmp_dir='/Users/qjs599/Desktop/phylostruct/phylostruct/data/tmp/foldmason_tmp'

# Loop over each subdirectory
for pdb_dir in "$pdb_files"/*/; do
    pdb_name=$(basename "$pdb_dir")
    out_dir="$result/$pdb_name"
    
    mkdir -p "$out_dir"

    echo "Processing folder: $pdb_name ..."

    # Run FoldMason on the entire subdirectory
    foldmason easy-msa "$pdb_dir" "$out_dir" "$tmp_dir" \
        --report-mode 1 \
        --threads 6 \
        --file-include ".*\.pdb$" \
        --filter-msa 0 -v 0
done

