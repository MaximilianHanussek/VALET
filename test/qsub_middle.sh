#!/bin/bash

#PBS -l nodes=1:ppn=1,walltime=00:55:00

/beeond/IDBA/idba_ud-1.0.9/bin/idba_ud -r /beeond/datasets/SRR741411.filt.fa --num_threads 1 -o output/
sleep 720
