#!/bin/bash 
input_fa=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta
out=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmasker/metazoa_custom

old_asm=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna
old_asm_out=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/repeats
old_asm_masked=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/repeats/GCF_000262585.1_Msex_1.0_genomic.fna.masked
masked_fa=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmasker/metazoa/moth_canu_nanopolish_racon1.FINAL.fasta.masked

if [ "$1" == "new" ]; then
/usr/local/RepeatMasker/RepeatMasker -parallel 50 -lib /uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmodeler/RM_68099.MonMay252328242020/consensi.fa.classified -frag 10000 -dir $out -e rmblast $masked_fa
fi

if [ "$1" == "old" ]; then
	/usr/local/RepeatMasker/RepeatMasker -parallel 50 -species metazoa -frag 10000 -dir $old_asm_out -e rmblast $old_asm
	/usr/local/RepeatMasker/RepeatMasker -parallel 50 -lib /uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmodeler/RM_68099.MonMay252328242020/consensi.fa.classified -frag 10000 -dir $old_asm_out -e rmblast $old_asm_masked
fi
	
#out=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmasker/metazoa
#/usr/local/RepeatMasker/RepeatMasker -parallel 50 -species metazoa -frag 10000 -dir $out -e rmblast $input_fa
