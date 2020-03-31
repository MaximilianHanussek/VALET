#!/bin/bash

#PBS -l nodes=1:ppn=2,walltime=55:00

/beeond/IDBA/idba_ud-1.0.9/bin/idba_ud -r /beeond/datasets/SRR741411.filt.fa --num_threads 2 -o output/
