#!/bin/bash 
datadir=/kyber/Data/Nanopore/Analysis/gmoney/moth/annotation

if [ $1 == repeats ] ; then
	mkdir -p $datadir/repeats
	cd $datadir/repeats
	~/repos/RepeatModeler-open-1.0.11/BuildDatabase -name moth -engine ncbi $datadir/wt_moth_corrected_scaffolds.fasta
	~/repos/RepeatModeler-open-1.0.11/RepeatModeler -pa 36 -engine ncbi -database moth 2>&1 | tee repeatmodeler.log
fi 

if [ $1 == busco ] ; then
	#mkdir -p $datadir/busco
	cd $datadir/busco
	/home/yfan/software/busco/scripts/run_BUSCO.py -c 12 -f -i $datadir/wt_moth_corrected_scaffolds.fasta -o scaffold_insecta -l /home/gmoney/Code/moth/moth/annotation/insecta_odb9 -m geno
fi

if [ $1 == maker_prep ] ; then
	mkdir -p $datadir/maker
	cd $datadir/maker
	##make control files for maker
	maker -CTL
fi

if [ $1 == maker_contigs ] ; then
	cd $datadir/maker
	maker -c 36 -f -g $datadir/canu_pilon/candida_nivariensis_canu.pilon.6.fasta \
	-base contigs \
	$datadir/maker/maker_opts.ctl $datadir/maker/maker_bopts.ctl $datadir/maker/maker_exe.ctl
fi

if [ $1 == augustus ] ; then
	mkdir -p $datadir/augustus
	augustus --species=heliconius_melpomene1 $datadir/wt_moth_corrected_scaffolds.fasta > $datadir/augustus/moth.gff
fi
