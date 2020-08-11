#!/bin/bash 
EVM_HOME=~/repos/EVidenceModeler-1.1.1/ 
genome=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta
stringtie_gff3=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/stringtie2/stringtie2_merge/transcripts.fasta.transdecoder.genome.gff3
bam=/uru/Data/Nanopore/projects/moth/2020_analysis/sra_rna_data/bam
genepred_gff3=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/masked_annotations/braker_masked/augustus.hints.gff3
out=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/masked_annotations/EVM
protein_gff=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/braker/prothint.gff

if [ "$1" == "partition" ]
then	
	$EVM_HOME/EvmUtils/partition_EVM_inputs.pl --genome $genome \
	--gene_predictions $genepred_gff3 \
	--transcript_alignments $stringtie_gff3 \
	--segmentSize 100000 --overlapSize 10000 --partition_listing ${out}/partitions_list.out
fi

if [ "$1" == "run" ]
then	
	$EVM_HOME/EvmUtils/write_EVM_commands.pl --genome $genome --weights `pwd`/weights.txt \
	--gene_predictions $genepred_gff3 \
	--transcript_alignments $stringtie_gff3 \
	--output_file_name evm.out  --partitions ${out}/partitions_list.out >  ${out}/commands.list
fi

if [ "$1" == "execute" ]
then
	$EVM_HOME/EvmUtils/execute_EVM_commands.pl ${out}/commands.list | tee run.log
	$EVM_HOME/EvmUtils/recombine_EVM_partial_outputs.pl --partitions ${out}/partitions_list.out --output_file_name evm.out
	$EVM_HOME/EvmUtils/convert_EVM_outputs_to_GFF3.pl  --partitions ${out}/partitions_list.out --output evm.out  --genome $genome
	find . -regex ".*evm.out.gff3" -exec cat {} \; > EVM.all.gff3
fi
