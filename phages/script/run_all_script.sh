#!/bin/bash

#3Di

#Running foldmason to align and extract 3Di sequences - server
#./foldmason_script.sh

#trim the 3Di alignments
#cd /Users/qjs599/Desktop/phylostruct/
#Rscript /Users/qjs599/Desktop/phylostruct/phages/script/clean_3di_seqs.R

#AA

#concatenate AA sequences - server
#./concat_AA_script.sh

#remove duplicate sequences
#./dedup_seq_script.sh

#align the AA sequences - server
#./align_AA_script.sh

#trim the AA alignments
cd /Users/qjs599/Desktop/phylostruct/
Rscript /Users/qjs599/Desktop/phylostruct/phages/script/clean_seqs.R 