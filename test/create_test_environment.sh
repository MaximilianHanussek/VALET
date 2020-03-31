#!/bin/bash

#Create test environment for VALET

cd /beeond/
mkdir SPAdes
mkdir IDBA
mkdir datasets
mkdir output

cd datasets/
wget https://s3.denbi.uni-tuebingen.de/max/SRR741411.filt.fastq.gz
gunzip SRR741411.filt.fastq.gz

wget https://s3.denbi.uni-tuebingen.de/max/ERR016155.filt.fastq.gz
gunzip ERR016155.filt.fastq.gz

cd ..
wget https://s3.denbi.uni-tuebingen.de/max/idba_ud-1.0.9.tar.gz -P IDBA
tar -xf IDBA/idba_ud-1.0.9.tar.gz -C IDBA/

wget https://s3.denbi.uni-tuebingen.de/max/SPAdes-3.12.0-Linux.tar.gz -P SPAdes
tar -xf SPAdes/SPAdes-3.12.0-Linux.tar.gz -C SPAdes

cd IDBA/idba_ud-1.0.9/
./configure
make clean
make
cd ../../

IDBA/idba_ud-1.0.9/bin/fq2fa datasets/SRR741411.filt.fastq datasets/SRR741411.filt.fa
IDBA/idba_ud-1.0.9/bin/fq2fa datasets/ERR016155.filt.fastq datasets/ERR016155.filt.fa


