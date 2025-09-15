#!/bin/bash

#3Di

#Running foldmason to align and extract 3Di sequences - server
#./foldmason_script.sh

#trim the 3Di alignments
#cd /Users/qjs599/Desktop/phylostruct/
#Rscript /Users/qjs599/Desktop/phylostruct/phages/script/clean_3di_seqs.R

#filter for biochemical diversity
#cd /Users/qjs599/Desktop/phylostruct/
#Rscript /Users/qjs599/Desktop/phylostruct/phages/script/biochem_div_filter.R

#remove seqs with extreme roottotip dist 0.01
#cd /Users/qjs599/Desktop/phylostruct/
#Rscript /Users/qjs599/Desktop/phylostruct/phages/script/roottotip_filter.R

#iqtree for structural alignments - server
#./struct_iqtree_fast_script.sh

#-----------------------------

#AA

#concatenate AA sequences - server
#./concat_AA_script.sh

#remove duplicate sequences
#./dedup_seq_script.sh

#align the AA sequences - server
#./align_AA_script.sh

#trim the AA alignments
#cd /Users/qjs599/Desktop/phylostruct/
#Rscript /Users/qjs599/Desktop/phylostruct/phages/script/clean_seqs.R 

#-----------------------------

#filter for biochemical diversity
#-------in script change the input and output folder paths
#cd /Users/qjs599/Desktop/phylostruct/
#Rscript /Users/qjs599/Desktop/phylostruct/phages/script/biochem_div_filter.R

#remove seqs with extreme roottotip dist 0.01
#------in script change the input and output folder paths
cd /Users/qjs599/Desktop/phylostruct/
Rscript /Users/qjs599/Desktop/phylostruct/phages/script/roottotip_filter.R

#iqtree for AA alignments - server
#./amino_iqtree_fast_script.sh
