#!/bin/bash 

if [ $1 == cutsite ] ; then
	cd /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/restriction_sites
#	module load python/2.7.15-ief5zp
	python /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/misc/generate_site_positions.py Sau3AI Masked_moth_Genome.fasta /uru/Data/Nanopore/projects/moth/2020_analysis/racon/moth_canu_nanopolish_racon1.fasta
	cd ..

	mkdir /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/fastq
	cd /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/fastq
	for f in /kyber/Data/NGS/projects/moth_hiC/grcf/75bp_trimmed/fastq/*.fastq ; do ln -s $f;done
	cd ..

	bioawk -c fastx '{print $name"\t"length($seq)}' /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/references/moth_canu_nanopolish_racon1.fasta > chrom.sizes

	bwa index /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/references/moth_canu_nanopolish_racon1.fasta
fi

if [ $1 == juicer ] ; then
	/uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/scripts/juicer.sh -y /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/restriction_sites/Masked_moth_Genome.fasta_Sau3AI.txt -d /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer -z /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/references/moth_canu_nanopolish_racon1.fasta -p /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/chrom.sizes -s Sau3AI -t 48 -D /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer
fi

if [ $1 == 3d ] ; then
	/uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/3d-dna/run-asm-pipeline.sh --editor-repeat-coverage 3 /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/references/moth_canu_nanopolish_racon1.fasta  /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/aligned_1/merged_nodups.txt
fi 

if [ $1 == final ] ; then
        bwa index *.FINAL.fasta
	bioawk -c fastx '{print $name"\t"length($seq)}' *.FINAL.fasta > scaffold.sizes
#	python /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/misc/generate_site_positions.py Sau3AI Masked_moth_Scaffolds.fasta *.FINAL.fasta 
#	/uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/scripts/juicer.sh -y Masked_moth_Scaffolds.fasta_Sau3AI.txt -d /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer -z *.FINAL.fasta -p scaffold.sizes -s Sau3AI -t 60 -D /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer

fi

if [ $1 == hic ] ; then
        java -Xmx2g -jar /home/gmoney/repos/Juicebox_1.11.08.jar pre /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/references/moth_canu_nanopolish_racon1.fasta /uru/Data/Nanopore/projects/moth/juicer/aligned/merged_nodups.txt
fi

if [ $1 == review ] ; then
	/uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/3d-dna/run-asm-pipeline-post-review.sh -r moth_canu_nanopolish_racon1.FINAL.assembly moth_canu_nanopolish_racon1.FINAL.fasta /uru/Data/Nanopore/projects/moth/2020_analysis/scaffold/juicer/aligned/merged_nodups.txt
fi

