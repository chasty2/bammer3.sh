#!/bin/bash

# bammer3.sh:
# Aligns fastq files to their respective genome
# using bwa (fastq->sam), then converts those SAM files
# to BAM files using SAMtools.
# upgraded to work recursively while renaming each file 
# based on its parent directory
# Cody Hasty 09-08-2017 
# written in gedit on Ubuntu 16.04 

# Command line arguments: d1 *.fa
# d1 = parent directory
# *.fa =  reference genome

# recursive call if i is a directory
# base case: align fastq & convert to bam
# rename based on parent directory

# NOTE: reference genome must be indexed (I use bwa)
#   bwa index -a bwtsw  ~/genomes/genome.fa

for i in $1/*
do
    if [ -d "$i" ]
    then
        bammer3.sh "$i" $2
    elif [[ $i == *.fastq.gz ]]
    then
        bwa mem $2 $i | samtools view -b > $1/$( basename -s .fastq.gz $i).bam
    fi
done
