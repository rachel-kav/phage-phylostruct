#filtering for biochemical diversity
library(Biostrings)

# Function to trim alignment based on amino acid frequency
trimAAdiversity <- function(al_mat, min_prop = 1/3) {
  ntax <- nrow(al_mat)
  
  keep_cols <- apply(al_mat, 2, function(col) {
    freqs <- table(col)
    max_freq <- max(freqs)
    max_freq / ntax >= min_prop
  })
  
  al_mat[, keep_cols, drop = FALSE]
}

# Input/output directories
#3di directories
#input_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/struct_seqs/3di_align_trim_11.9"
#output_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/struct_seqs/filtered_3di_seqs_12.9"

#AA directories
input_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/amino_seqs_trim_12.9"
output_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/filtered_amino_seqs_12.9"
if(!dir.exists(output_folder)) dir.create(output_folder, recursive = TRUE)

# List all FASTA alignment files
fasta_files <- list.files(
  path = input_folder, 
  pattern = "\\.fasta$", #changed to fasta for aa 
  full.names = TRUE
)

# Loop over files
for(fasta_file in fasta_files) {
  cat("Processing:", fasta_file, "\n")
  
  aln <- readAAStringSet(fasta_file)
  aln_mat <- do.call(rbind, strsplit(as.character(aln), split = ""))
  
  # Apply diversity filter
  filtered_mat <- trimAAdiversity(aln_mat, min_prop = 1/3)
  
  if(ncol(filtered_mat) == 0) {
    warning("All columns removed for ", fasta_file)
    next
  }
  
  # Convert back to AAStringSet
  filtered_seqs <- AAStringSet(apply(filtered_mat, 1, paste, collapse = ""))
  names(filtered_seqs) <- names(aln)
  
  # Generate output filename
  out_file <- file.path(output_folder, basename(fasta_file))
  
  writeXStringSet(filtered_seqs, filepath = out_file)
  cat("Saved filtered alignment to:", out_file, "\n\n")
}
