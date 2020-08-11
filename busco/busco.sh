#!/bin/bash

# run in conda busco env
if [ "$1" == "old" ]
then
	fasta=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/busco
	~/repos/busco/bin/busco -m genome -i $fasta -o moth_old_assembly_insect -l insecta -f -c 50 --config ~/miniconda3/config/config.ini
			 fi
if [ "$1" == "racon1" ]
then
	fasta=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/canu_moth_polished_genome.fa
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/busco
	 ~/repos/busco/bin/busco -m genome -i $fasta -o moth_nanopolish_insect -l insecta -f -c 24 --config ~/miniconda3/config/config.ini 
fi

if [ "$1" == "racon2" ]
then
	fasta=/uru/Data/Nanopore/projects/moth/2020_analysis/racon
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/busco
	for file in $fasta/*.fasta
	do
		base=$(basename $file ".fasta")	
		~/repos/busco/bin/busco -m genome -i $file -o ${base}_busco_insecta -l insecta -c 24 --out_path $out 
	done
fi

if [ "$1" == "raw" ]
then
	fasta=/kyber/Data/Nanopore/projects/moth/in_progress/moth_assembly/moth.contigs.fasta
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/busco
	~/repos/busco/bin/busco -m genome -i $fasta -o moth_canu_raw_insect -l insecta -f -c 24 --config ~/miniconda3/config/config.ini
fi

if [ "$1" == "final" ]
then
	fasta=/uru/Data/Nanopore/projects/moth/2020_analysis/FINAL/moth_canu_nanopolish_racon1.FINAL.fasta
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/busco
	~/repos/busco/bin/busco -m genome -i $fasta -o moth_FINAL_insect -l insecta -f -c 60 --config ~/miniconda3/config/config.ini
fi
if [ "$1" == "transcript" ]
then
	fasta=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_transcript.fna
	out=/uru/Data/Nanopore/projects/moth/2020_analysis/busco
	~/repos/busco/bin/busco -m transcriptome -i $fasta -o moth_reference_trancsripts -l insecta -f -c 60 --out_path $out
fi
