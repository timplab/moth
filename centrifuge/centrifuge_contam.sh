#!/bin/bash

for lineage_file in insecta_lineage/*; do

	./centrifuge-1.0.3-beta/centrifuge-download -d invertebrate -o ref_assemblies -t $(cat $lineage_file) -P 3 genbank
done
