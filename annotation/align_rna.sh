#!/bin/bash 
#~/miniconda3/bin/hisat2-build /uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmasker/metazoa_custom/moth_canu_nanopolish_racon1.FINAL.fasta.masked.masked /uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1_masked.FINAL 


#~/miniconda3/bin/hisat2-build /uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna /uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/hisat_index/GCF_000262585.1_Msex_1.0_genomic.fna

asm=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1_masked.FINAL 
#old_asm=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/hisat_index/GCF_000262585.1_Msex_1.0_genomic.fna
if [ "$1" == "paired" ]; then
	in=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/paired
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/bams/masked
	fastq=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/trim

	paired_files=$(ls $in | grep 1.fastq)

	for i in $paired_files; do
		f=$(basename $i _1.fastq)
		echo $f
#		trimmomatic PE ${in}/${f}_1.fastq ${in}/${f}_2.fastq ${fastq}/paired/${f}_1_out_paired.fq ${fastq}/paired/${f}_1_out_unpaired.fq ${fastq}/paired/${f}_2_out_paired.fq ${fastq}/paired/${f}_2_out_unpaired.fq -threads 30 -trimlog ${fastq}/${f}.log SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:50
		
		hisat2 -x $asm -1 ${fastq}/paired/${f}_1_out_paired.fq -2 ${fastq}/paired/${f}_2_out_paired.fq -p 30 | samtools view -Sb | samtools sort -o ${out}/${f}_masked.bam &> ${out}/${f}_alignment.log
	done
fi


if [ "$1" == "single" ]; then
	in=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/unpaired
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/bams/masked
	fastq=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/trim
	single=$(ls $in)
	for i in $single; do
		f=$(basename $i _1.fastq)
		echo $f
#	trimmomatic SE ${in}/${f}_1.fastq ${fastq}/${f}_out_unpaired.fq  -threads 50 -trimlog /uru/Data/Nanopore/projects/moth/trim/${f}.log SLIDINGWINDOW:4:20 LEADING:10 TRAILING:10 MINLEN:50
		hisat2 -x $asm  -U ${fastq}/unpaired/${f}_out_unpaired.fq -p 30 | samtools view -Sb | samtools sort -o ${out}/${f}_masked.bam &> ${out}/${f}_alignment.log
	done
fi

