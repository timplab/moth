#!/bin/bash 

nucmer --maxmatch -l 100 -c 500 --prefix= $ref $qry
show-coords -rcl canna_ruby.delta > canna_ruby.coords
