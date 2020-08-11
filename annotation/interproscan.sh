#!/bin/bash 

repo=~/repos/my_interproscan/interproscan-5.44-79.0
out=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/interproscan
#prot=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/masked_annotations/transdecoder/augustus_transcripts.fa.transdecoder_clean.pep
prot=/uru/Data/Nanopore/projects/moth/2020_analysis/FINAL/proteins/Stringtie_liftoff_merged_trnascripts.fa.transdecoder.pep

trans=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/braker/BRAKER.fasta
#${repo}/interproscan.sh -cpu 48 -d $out -goterms -iprlookup -pa -i ~/repos/my_interproscan/interproscan-5.44-79.0/test_proteins.fasta -f tsv

sed 's/\*//g' $prot > ${out}/Stringtie_liftoff_merged_trnascripts.fa.transdecoder_clean.pep
${repo}/interproscan.sh -cpu 65 -d $out -goterms -iprlookup -pa -i ${out}/Stringtie_liftoff_merged_trnascripts.fa.transdecoder_clean.pep -f tsv
