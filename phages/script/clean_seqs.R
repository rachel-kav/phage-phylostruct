library(Biostrings)

trimAAalignment <- function(al_mat, prop = 0.5) {
  ntax <- nrow(al_mat)
  bad_chars <- c("-", "X", "x", "?", "O", "o")
  keep_cols <- apply(al_mat, 2, function(col) {
    sum(col %in% bad_chars) / ntax <= (1 - prop)
  })
  al_mat[, keep_cols, drop = FALSE]
}

input_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/fasta_amino_dedup"
output_folder <- "/Users/qjs599/Desktop/phylostruct/phages/data/amino_seqs/fasta_amino_align"
if (!dir.exists(output_folder)) dir.create(output_folder)

fasta_files <- list.files(input_folder, pattern = "\\.fasta$", full.names = TRUE)

for (fasta_file in fasta_files) {
  cat("Processing:", fasta_file, "\n")
  aln <- readAAStringSet(fasta_file)
  aln_mat <- do.call(rbind, strsplit(as.character(aln), split = ""))
  trimmed_mat <- trimAAalignment(aln_mat, prop = 0.5)
  trimmed_seqs <- AAStringSet(apply(trimmed_mat, 1, paste, collapse = ""))
  names(trimmed_seqs) <- names(aln)
  output_file <- file.path(output_folder, basename(fasta_file))
  writeXStringSet(trimmed_seqs, filepath = output_file)
  cat("Saved trimmed alignment to:", output_file, "\n\n")
}

