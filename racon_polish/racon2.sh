#!/bin/bash
fastq=/uru/Data/NGS/Raw/200304_hbird_moth_gDNA/200225_moth_hbird_nextera/200225_moth_hbird_nextera
out=/uru/Data/Nanopore/projects/moth/2020_analysis/racon
asm=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/canu_moth_polished_genome.fa
raconfq=/uru/Data/Nanopore/projects/moth/2020_analysis/racon/fastq/moth_racon.fastq
repo=~/repos/racon/build/bin

#python ./racon_change_names.py ${fastq}/moth_S2_merge_R1_001.fastq ${fastq}/moth_S2_merge_R2_001.fastq > ${out}/fastq/moth_racon.fastq

#minimap2 -t 60 -ax sr $asm  $raconfq > ${out}/racon_corr_1.sam 
${repo}/racon -t 15 $raconfq  ${out}/racon_corr_1.sam $asm  > ${out}/moth_canu_nanopolish_racon1.fasta
#~/repos/mummer-4.0.0beta2/nucmer -p nucmer1 $raconfq ${out}/moth_canu_nanopolish_racon1.fasta
#~/repos/mummer-4.0.0beta2/show-snps -C -T -r nucmer1.delta > ${out}/racon1_snps


for i in {1..10}; do
	n=$(($i+1))
	echo $i
	echo $n
	echo ${out}/moth_canu_nanopolish_racon${i}.fasta
	echo ${out}/moth_canu_nanopolish_racon${n}.fasta
#	minimap2 -t 60 -ax sr ${out}/moth_canu_nanopolish_racon${i}.fasta  $raconfq > ${out}/racon_corr_${i}.sam
#	${repo}/racon -t 60 $raconfq  ${out}/racon_corr_${i}.sam ${out}/moth_canu_nanopolish_racon${i}.fasta  > ${out}/moth_canu_nanopolish_racon${n}.fasta
#	~/repos/mummer-4.0.0beta2/nucmer -p nucmer1 ${out}/moth_canu_nanopolish_racon${i}.fasta ${out}/moth_canu_nanopolish_racon${n}.fasta
#	~/repos/mummer-4.0.0beta2/show-snps -C -T -r nucmer1.delta > ${out}/racon${n}_snps
done
