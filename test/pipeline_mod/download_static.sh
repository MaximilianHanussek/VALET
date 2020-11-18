#!/bin/bash

#PBS -l nodes=1:ppn=1,walltime=01:02:00

walltime=$(shuf -i 30-360 -n 1)

sleep  $walltime

