#!/bin/bash 
genome=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmasker/metazoa_custom/moth_canu_nanopolish_racon1.FINAL.fasta.masked.masked
gtf=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/stringtie2/stringtie2_merge/stringtie2_merged_nohead.gff
prot=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/transdecoder/moth_stringtie2_transcripts.fa.transdecoder.pep
bam=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/bam/merged_bams

# outside bam dir ls -d $PWD/bam/*.bam | tr '\n' ','
#TransDecoder.LongOrfs -t /uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/stringtie2/stringtie2_merge/moth_stringtie2_transcripts.fa
#TransDecoder.Predict -t /uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/stringtie2/stringtie2_merge/moth_stringtie2_transcripts.fa

braker.pl --species=ManducaSexta_masked --genome=$genome \
	       --bam=${bam}/moth_PE_merged.bam,${bam}/moth_SE_merged.bam \
	       --cores=48 \
	       --prot_seq=$prot \
	       --prg=gth \
	       --gth2traingenes --trainFromGth\
	       --gff3 \
	       --softmasking
