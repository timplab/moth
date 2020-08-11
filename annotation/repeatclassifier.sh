#!/bin/bash 
cons=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmodeler/RM_68099.MonMay252328242020/consensi.fa
stock=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/repeats/repeatmodeler/RM_68099.MonMay252328242020/families.stk
/home/gmoney/repos/RepeatModeler-2.0.1/RepeatClassifier -trf_prgm ~/repos/trf409.linux64 \
	-ltr_retriever_dir /home/gmoney/miniconda3/bin \
	-recon_dir ~/repos/RECON-1.08/bin \
	-rscout_dir ~/repos/RepeatScout-1.0.6/bin \
	-rmblast_dir ~/repos/rmblast-2.10.0/bin \
	-consensi $cons \
	-stockholm $stock \
        -engine rmblast	
	#-abblast_dir ~/repos/ab-blast-20200317-linux-x64


