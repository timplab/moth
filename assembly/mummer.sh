#!/bin/bash 
asm=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna
ref=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta
path=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/mummer

#~/repos/mummer-4.0.0beta2/nucmer $ref $asm -t 60 --delta=$path/Msex.delta

python DotPrep.py --delta $path/Msex.delta --out $path/Msex.dot 
