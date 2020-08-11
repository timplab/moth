#!/bin/bash 
in=~/repos/Trinotate-Trinotate-v3.2.0/admin
transcripts=/dilithium/Data/gmoney/analysis/moth/masked_annotation/stringtie_transcripts/Stringtie_tokeep.fa
prot=/uru/Data/Nanopore/Analysis/gmoney/databases/uniprot/uniprot_sprot.fasta
out=
TransDecoder.LongOrfs -t $transcripts --output_dir $out
# have to add refine starts for predicted transcripts because no 5' UTR
TransDecoder.Predict --no_refine_starts -t $transcripts --output_dir $out

blastx -db $prot -query $transcripts -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 30 > ${out}/swissprot.blastx_t30.outfmt6

blastp -db $protn -query ${out}/*.pep -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 30 > ${out}/swissprot.blastp.outfmt6

#hmmscan --cpu 30 --domtblout TrinotatePFAM.out ${in}/Pfam-A.hmm *.pep > pfam.log

#/home/gmoney/repos/signalp-5.0b/bin/signalp -fasta transcripts.fa.transdecoder.pep -format short -mature signalp.out
#tmhmm --short < *.pep > tmhmm.out

grep ">" $transcripts | awk '{print$2"\t"$1}' | sort | uniq | sed 's/gene=//g' | sed 's/>//g' > gene_trans_map.txt

#/home/gmoney/repos/Trinotate-Trinotate-v3.2.0/util/rnammer_support/RnammerTranscriptome.pl --transcriptome $transcripts --path_to_rnammer /home/gmoney/repos/RNAMMER/rnammer

~/repos/Trinotate-Trinotate-v3.2.0/Trinotate Trinotate.sqlite init \
     --gene_trans_map gene_trans_map.txt \
     --transcript_fasta $transcripts \
     --transdecoder_pep $transcripts.transdecoder.pep

TRINOTATE_HOME=~/repos/Trinotate-Trinotate-v3.2.0

$TRINOTATE_HOME/Trinotate Trinotate.sqlite \
	       LOAD_swissprot_blastx swissprot.blastx_t30.outfmt6
$TRINOTATE_HOME/Trinotate Trinotate.sqlite \
	       LOAD_swissprot_blastp swissprot.blastp.outfmt6

$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM1.out

#$TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_signalp muscle_transcriptome.fasta.transdecoder_summary.signalp5

# $TRINOTATE_HOME/Trinotate Trinotate.sqlite LOAD_tmhmm tmhmm.out
$TRINOTATE_HOME/Trinotate Trinotate.sqlite report > Trinotate.xls

$TRINOTATE_HOME/util/extract_GO_assignments_from_Trinotate_xls.pl  \
	--Trinotate_xls Trinotate.xls \
	-G --include_ancestral_terms \
	> go_annotations.txt
