#!/bin/bash 
out=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/
asm=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta
ref=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna
python ~/repos/quast-5.0.2/quast.py -o $out -t 65 $asm
