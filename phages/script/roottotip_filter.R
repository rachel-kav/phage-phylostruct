#remove 'trees' or alignments with the 99th quantile roottotip distance

library(Biostrings)
library(ape)
library(bio3d)

# Function to compute maximum tip-to-root distance for one alignment
max_tip_distance <- function(fasta_file) {
  aln <- read.fasta(fasta_file)

  # Compute distance matrix (1 - identity)
  dist_mat <- 1 - seqidentity(aln)
  dist_obj <- as.dist(dist_mat)

  # Build NJ tree
  nj_tree <- nj(dist_obj)

  tip_distances <- node.depth.edgelength(nj_tree)[1:length(nj_tree$tip.label)]
  max(tip_distances)
}

# Input/output directories
#3di
#input_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/struct_seqs/filtered_3di_seqs_12.9"
#output_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/struct_seqs/clean_3di_seqs_12.9"

#AA
input_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/filtered_amino_seqs_12.9"
output_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/clean_amino_seqs_12.9"

if(!dir.exists(output_folder)) dir.create(output_folder, recursive = TRUE)

# List all FASTA alignment files
fasta_files <- list.files(input_folder, pattern="\\.fasta$", full.names = TRUE)
#fasta for AA

# Compute max tip-to-root distances for each alignment
max_dists <- sapply(fasta_files, max_tip_distance)

# Determine 99th percentile cutoff
cutoff <- quantile(max_dists, 0.99)
cat("Max tip-to-root distance cutoff (top 1%):", cutoff, "\n")

# Keep only alignments below cutoff
keep_files <- fasta_files[max_dists <= cutoff]

# Copy or save filtered alignments
for(f in keep_files) {
  out_file <- file.path(output_folder, basename(f))
  file.copy(f, out_file)
}

cat("Kept", length(keep_files), "alignments out of", length(fasta_files), "\n")

