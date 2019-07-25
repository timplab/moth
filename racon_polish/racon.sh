#!/bin/bash 
# Building a large index
if [ "$1" == "index" ]; then
bowtie2-build --large-index canu_moth_polished_genome.fa /home/ubuntu/illumina/alignment/moth_canu
bowtie2-build --large-index wt_moth_polished_genome.fa /home/ubuntu/illumina/alignment/moth_wt
bowtie2-build --large-index flye_moth_polished_genome.fa /home/ubuntu/illumina/alignment/moth_flye
fi

# Inspecting the entire lambda virus index (large index)
if [ "$1" == "inspect" ]; then
  bowtie2-inspect --large-index /home/ubuntu/illumina/alignment/moth_canu
  bowtie2-inspect --large-index /home/ubuntu/illumina/alignment/moth_wt
  bowtie2-inspect --large-index /home/ubuntu/illumina/alignment/moth_flye
fi
# Aligning paired reads #181012-mothleg_S1_L001_R1_001.fastq  181012-mothleg_S1_L001_R2_001.fastq
if [ "$1" == "align" ]; then
	bowtie2 -x /home/ubuntu/illumina/alignment/moth_canu -1 /home/ubuntu/illumina/181012-mothleg_S1_L001_R1_001.fastq -2 /home/ubuntu/illumina/181012-mothleg_S1_L001_R2_001.fastq
	bowtie2 -x /home/ubuntu/illumina/alignment/wt_canu -1 /home/ubuntu/illumina/181012-mothleg_S1_L001_R1_001.fastq -2 /home/ubuntu/
illumina/181012-mothleg_S1_L001_R2_001.fastq
	bowtie2 -x /home/ubuntu/illumina/alignment/flye_canu -1 /home/ubuntu/illumina/181012-mothleg_S1_L001_R1_001.fastq -2 /home/ubuntu/
illumina/181012-mothleg_S1_L001_R2_001.fastq
fi

if [ "$1" == "sam" ]; then
	minimap2 -t 70 -ax map-ont canu_moth_polished_genome.fa /home/ubuntu/fastq/181005_moth_decontam.fastq > alignment_canu.paf
	minimap2 -t 70 -ax map-ont wt_moth_polished_genome.fa /home/ubuntu/fastq/181005_moth_decontam.fastq > alignment_wt.paf
	minimap2 -t 70 -ax map-ont flye_moth_polished_genome.fa /home/ubuntu/fastq/181005_moth_decontam.fastq > alignment_flye.paf
fi
## racon cannot take paired end input -- need to run py script to change read names to be different then align with minimap/bowtie2 assuming no paired ends, wants paf input so going to align with minimap even though bowtie2 may be better for short reads

if [ "$1" == "paf" ]; then
        minimap2 -t 70 canu_moth_polished_genome.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_canu.paf
        minimap2 -t 70 wt_moth_polished_genome.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_wt.paf
        minimap2 -t 70 fly_moth_polished_genome.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_flye.paf
fi

if [ "$1" == "racon" ]; then
#	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_canu.paf canu_moth_polished_genome.fa > canu_moth_racon1.fa
#	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_wt.paf wt_moth_polished_genome.fa > wt_moth_racon1.fa
#	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_flye.paf fly_moth_polished_genome.fa > flye_moth_racon1.fa
	
	minimap2 -t 70 canu_moth_racon1.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_canu2.paf
	minimap2 -t 70 wt_moth_racon1.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_wt2.paf
	minimap2 -t 70 flye_moth_racon1.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_flye2.paf

	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_canu2.paf canu_moth_racon1.fa > canu_moth_racon2.fa
	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_wt2.paf wt_moth_racon1.fa > wt_moth_racon2.fa
	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_flye2.paf flye_moth_racon1.fa > flye_moth_racon2.fa
	
	minimap2 -t 70 canu_moth_racon2.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_canu3.paf
	minimap2 -t 70 wt_moth_racon2.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_wt3.paf
	minimap2 -t 70 flye_moth_racon2.fa /home/ubuntu/illumina/racon_moth.fastq > illumina_flye3.paf
	
	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_canu3.paf canu_moth_racon2.fa > canu_moth_racon3.fa
	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_wt3.paf wt_moth_racon2.fa > wt_moth_racon3.fa
	racon -t 72 /home/ubuntu/illumina/racon_moth.fastq illumina_flye3.paf flye_moth_racon2.fa > flye_moth_racon3.fa
	#    <sequences>
	#        input file in FASTA/FASTQ format (can be compressed with gzip)
	#        containing sequences used for correction
	#    <overlaps>
	#        input file in MHAP/PAF/SAM format (can be compressed with gzip)
	#        containing overlaps between sequences and target sequences
	#    <target sequences>
	#        input file in FASTA/FASTQ format (can be compressed with gzip)
	#        containing sequences which will be corrected
fi
