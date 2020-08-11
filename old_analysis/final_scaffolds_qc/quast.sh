#!/bin/bash 
in=/uru/Data/Nanopore/projects/moth/190906_3d_dna
out=/uru/Data/Nanopore/projects/moth/assembly_qc

python ~/repos/quast-5.0.2/quast.py -o $out -t 65 --eukaryote --large --k-mer-stats ${in}/canu_moth_racon3.FINAL.fasta
