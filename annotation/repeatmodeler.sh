#!/bin/bash 
ref=moth_canu_nanopolish_racon1.FINAL.fasta
repo=~/repos/RepeatModeler-2.0.1

#${repo}/BuildDatabase -name Msexta $ref
${repo}/RepeatModeler -database Msexta -pa 12 -recoverDir RM_68099.MonMay252328242020 >& Msexta_repeatmod.out 
