#!/bin/bash
ref=/kyber/Data/temp/gmoney/moth/hiC/assemblies
fastq=/kyber/Data/NGS/projects/moth_hiC/grcf/75bp_trimmed

# build index 
#bowtie2-build ${ref}/wt_moth_racon3.fa ${ref}/wt_moth_racon3_index

# align 
bowtie2 -x ${ref}/wt_moth_racon3_index --threads 35 -1 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_1.75bp_5prime.fq -2 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_2.75bp_5prime.fq | samtools view -Sb | samtools sort -o /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/grcf/wt_moth_hiC_100bp.bam
samtools index /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/grcf/wt_moth_hiC_100bp.bam
