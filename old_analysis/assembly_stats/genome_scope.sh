#!/bin/bash 
fastq=/kyber/Data/NGS/projects/moth_hiC/grcf/timp1-mothHiC_redemux/FASTQ
out=/uru/Data/Nanopore/projects/moth/genome_scope

jellyfish count -C -m 21 -s 1000000000 -t 72 ${fastq}/*.fastq -o ${out}/hiC_reads.jf 
jellyfish histo -t 72 ${out}/hiC_reads.jf > ${out}/hiC_reads.histo
