#!/bin/bash 

ref=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.fna
asm=/uru/Data/Nanopore/projects/moth/2020_analysis/assemblies/racon_3d_dna/moth_canu_nanopolish_racon1.FINAL.fasta
gtf=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/GCF_000262585.1_Msex_1.0_genomic.gff
out=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie_liftoff
liftoff=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/liftoff/Msexta_liftoff.gtf
stringtie=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie2/stringtie2_merge/stringtie2_merged.gtf
augustus=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/masked_annotations/braker_masked/augustus.hints.gtf
OGS2=/uru/Data/Nanopore/projects/moth/2020_analysis/ncbi_reference/OGS2_gene_set/ms_ogs.gff
if [ "$1" == "liftoff" ]; then
	liftoff -t $asm -r $ref -g $gtf -o ${out}/Msexta_liftoff.gtf -p 48 -m ~/repos/minimap2/minimap2
fi

if [ "$1" == "gffcompare" ]; then
	gffcompare -r ${augustus} $stringtie -o ${out}/Msexta_augustus_stringtie
	gffcompare -r $liftoff  $stringtie -o ${out}/Msexta_liftoff_stringtie
	gffcompare -r  $liftoff $augustus -o ${out}/Msexta_augustus_liftoff
	gffcompare -r $gtf ${out}/Msexta_liftoff.gtf -o ${out}/Msexta_liftoff_oldref
fi

if [ "$1" == "unmapped" ]; then
	cat /uru/Data/Nanopore/projects/moth/2020_analysis/annotation/liftoff/unmapped_features.txt | cut -d '-' -f2 > unmapped_IDs
	# first pull out unmapped transcripts from the reference and align them to the stringtie assembled transripts
	fgrep -w -f unmapped_IDs $gtf | gffread -w ${out}/ref_MSexta_transcripts_unmapped.fa -g $ref 
	rm unmapped_IDs
	gffread -w ${out}/stringtie_transcripts.fa -g $asm $stringtie
fi

if [ "$1" == "minimap" ]; then
	minimap2 -cx asm5 -t 20 ${out}/ref_MSexta_transcripts_unmapped.fa ${out}/stringtie_transcripts.fa > ${out}/unmapped_stringtie_aln.paf
fi
if ["$1" == "count" ]; then
	grep -o 'Parent=.*' Msexta_liftoff.gtf | cut -f2- -d= | cut -f1 -d ';' | sort | uniq | wc -l
fi

# run compare liftoff_augustus.rmd to make the the intermed files 

intermed=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie_liftoff/intermed_files
if [ "$1" == "function" ]; then
	in=~/repos/Trinotate-Trinotate-v3.2.0/admin
	prot=/uru/Data/Nanopore/Analysis/gmoney/databases/ncbi_nr/nr
	out=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie_transcripts
	# first pull out unmapped transcripts from the reference and align them to the stringtie assembled transripts
#	fgrep -w -f ${intermed}/Stringtie_tokeep.tsv  $stringtie | gffread -w ${out}/Stringtie_tokeep.fa -g $asm
	transcripts=${out}/Stringtie_tokeep.fa
	 
	TransDecoder.LongOrfs -t $transcripts --output_dir $out
	# have to add refine starts for predicted transcripts because no 5' UTR
	TransDecoder.Predict --no_refine_starts -t $transcripts --output_dir $out
	~/repos/TransDecoder-TransDecoder-v5.5.0/util/gtf_to_alignment_gff3.pl ${out}/stringtie_tokeep.gtf > ${out}/stringtie_tokeep.gff3
	~/repos/TransDecoder-TransDecoder-v5.5.0/util/cdna_alignment_orf_to_genome_orf.pl \
		     ${out}/longest_orfs.gff3 \
		     ${out}/stringtie_tokeep.gff3 \
		     ${out}/Stringtie_tokeep.fa > ${out}/transcripts.fasta.transdecoder.genome.gff3
#	blastx -db $prot -query $transcripts -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 60 > ${out}/ncbi.blastx_t30.outfmt6

#	blastp -db $prot -query ${out}/longest_orfs.pep -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 30 > ${out}/ncbi.blastp.outfmt6
fi

if [ "$1" == "merge" ]; then
	out=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie_transcripts
	liftoff=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie_liftoff/Msexta_liftoff.gtf
	gffread --merge ${out}/transcripts.fasta.transdecoder.genome.gff3 $liftoff -o ${out}/Stringtie_liftoff_merged.gff
fi
