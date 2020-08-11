#!/bin/bash 
out=/uru/Data/Nanopore/projects/moth/sra_rna_data

file="$(cat /kyber/Data/Nanopore/Analysis/gmoney/moth/annotation/sra_accession_numbers.txt)"

for line in $file; do
	echo $line
	prefetch -v $line
	fastq-dump --outdir $out --split-files /home/gmoney/ncbi/public/sra/${line}.sra
done

