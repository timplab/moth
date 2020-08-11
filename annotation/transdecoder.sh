#!/bin/bash 
transcripts=/uru/Data/Nanopore/projects/moth/2020_analysis/annotation/masked_annotations/braker_masked/augustus_transcripts.fa
TransDecoder.LongOrfs -t $transcripts
# have to add refine starts for predicted transcripts because no 5' UTR
TransDecoder.Predict --no_refine_starts -t $transcripts
