#!/bin/bash
ref=/kyber/Data/temp/gmoney/moth/hiC/assemblies
fastq=/kyber/Data/NGS/projects/moth_hiC/grcf/75bp_trimmed

# build index 
#bowtie2-build ${ref}/wt_moth_racon3.fa ${ref}/wt_moth_racon3_index

# align hiC

if [ $1 == hiC ] ; then
bowtie2 -x ${ref}/wt_moth_racon3_index --threads 35 -1 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_1.75bp_5prime.fq -2 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_2.75bp_5prime.fq | samtools view -Sb | samtools sort -o /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/grcf/wt_moth_hiC_100bp.bam
samtools index /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/grcf/wt_moth_hiC_100bp.bam
fi

if [ $1 == illumina ] ; then
	bowtie2 -x ${ref}/wt_moth_racon3_index --threads 25 -1 /kyber/Data/Nanopore/projects/moth/raw_data/illumina/181012-mothleg_S1_L001_R1_001.fastq -2 /kyber/Data/Nanopore/projects/moth/raw_data/illumina/181012-mothleg_S1_L001_R2_001.fastq | samtools view -Sb | samtools sort -o /kyber/Data/Nanopore/Analysis/gmoney/moth/alignments/racon_wt_illumina_align.bam
	samtools index /kyber/Data/Nanopore/Analysis/gmoney/moth/alignments/racon_wt_illumina_align.bam

fi

if [ $1 == final ] ; then
	bowtie2-build /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/correction2_moth_scaffolds.fasta /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/correction2_moth_scaffolds.index        
	bowtie2 -x /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/phase_scaffolds/correction2_moth_scaffolds.index --threads 25 -1 /kyber/Data/Nanopore/projects/moth/raw_data/illumina/181012-mothleg_S1_L001_R1_001.fastq -2 /kyber/Data/Nanopore/projects/moth/raw_data/illumina/181012-mothleg_S1_L001_R2_001.fastq | samtools view -Sb | samtools sort -o /kyber/Data/Nanopore/Analysis/gmoney/moth/alignments/ill_final_assembly.bam
	samtools index /kyber/Data/Nanopore/Analysis/gmoney/moth/alignments/ill_final_assembly.bam
fi

if [ $1 == flye ] ; then
	bowtie2-build ${ref}/wt_moth_racon3.fa ${ref}/wt_moth_racon3_index
	bowtie2 -x ${ref}/wt_moth_racon3_index --threads 35 -1 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_1.75bp_5prime.fq -2 ${fastq}/H2F7FBCX3_1_TGTCGTTT~TCCTAGCA_2.75bp_5prime.fq | samtools view -Sb | samtools sort -o /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/grcf/flye_moth_hiC.bam
	samtools index /kyber/Data/Nanopore/Analysis/gmoney/moth/hiC/grcf/flye_moth_hiC.bam
fi
