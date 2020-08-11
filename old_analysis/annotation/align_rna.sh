#!/bin/bash 
#hisat2-build /uru/Data/Nanopore/projects/moth/190906_3d_dna/canu_moth_racon3.FINAL.fasta /uru/Data/Nanopore/projects/moth/assembly_index/canu_moth_racon3


if [ "$1" == "paired" ]; then
	in=/uru/Data/Nanopore/projects/moth/sra_rna_data/paired
	out=/uru/Data/Nanopore/projects/moth/sra_rna_data/sam
	fastq=/uru/Data/Nanopore/projects/moth/trim

	paired_files=$(ls $in | grep 1.fastq)

	for i in $paired_files; do
		f=$(basename $i _1.fastq)
		echo $f
		#trimmomatic PE ${in}/${f}_1.fastq ${in}/${f}_2.fastq ${fastq}/paired/${f}_1_out_paired.fq ${fastq}/paired/${f}_1_out_unpaired.fq ${fastq}/paired/${f}_2_out_paired.fq ${fastq}/paired/${f}_2_out_unpaired.fq -threads 50 -trimlog /uru/Data/Nanopore/projects/moth/trim/${f}.log SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:50
#		hisat2-build /uru/Data/Nanopore/projects/moth/190906_3d_dna/canu_moth_racon3.FINAL.fasta /uru/Data/Nanopore/projects/moth/assembly_index/canu_moth_racon3
		hisat2 -x /uru/Data/Nanopore/projects/moth/assembly_index/canu_moth_racon3 -1 ${fastq}/paired/${f}_1_out_paired.fq -2 ${fastq}/paired/${f}_2_out_paired.fq --dta-cufflinks -p 30 -S /uru/Data/Nanopore/projects/moth/190906_3d_dna_rna_alignment/${f}.sam &> /uru/Data/Nanopore/projects/moth/190906_3d_dna_rna_alignment/${f}_alignment.log
	done
fi


if [ "$1" == "single" ]; then
	in=/uru/Data/Nanopore/projects/moth/sra_rna_data/unpaired
	fastq=/uru/Data/Nanopore/projects/moth/trim/unpaired
	single=$(ls $in)
	for i in $single; do
		f=$(basename $i _1.fastq)
		echo $f
#	trimmomatic SE ${in}/${f}_1.fastq ${fastq}/${f}_out_unpaired.fq  -threads 50 -trimlog /uru/Data/Nanopore/projects/moth/trim/${f}.log SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:50
		hisat2 -x /uru/Data/Nanopore/projects/moth/assembly_index/canu_moth_racon3 -U ${fastq}/${f}_out_unpaired.fq --dta-cufflinks -p 30 -S /uru/Data/Nanopore/projects/moth/190906_3d_dna_rna_alignment/${f}.sam &> /uru/Data/Nanopore/projects/moth/190906_3d_dna_rna_alignment/${f}_alignment.log
	done
fi

