#!/bin/bash 

BRAKER_OLD=./braker_restart
BRAKER_NEW=./braker_restart2 

SPECIES=$(cat ${BRAKER_OLD}/braker.log | perl -ne \
	'if(m/AUGUSTUS parameter set with name ([^.]+)\./){print $1;}')

braker.pl --genome=${BRAKER_OLD}/genome.fa --hints=${BRAKER_OLD}/hintsfile.gff \
	--skipAllTraining --species=ManducaSexta_masked --prg=gth --cores=48 \
	--softmasking --workingdir=${BRAKER_NEW}
