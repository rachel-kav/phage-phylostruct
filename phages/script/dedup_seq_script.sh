#!/bin/bash

INPUT_DIR="/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/concat_amino"
OUTPUT_DIR="/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/fasta_amino_dedup"

mkdir -p "$OUTPUT_DIR"

for file in "$INPUT_DIR"/*.fasta; do
    filename=$(basename "$file")

    echo "Deduplicating $filename..."
    seqkit rmdup -s "$file" -o "$OUTPUT_DIR/$filename"
    echo "$filename done!"
done

echo "All files deduplicated!"

