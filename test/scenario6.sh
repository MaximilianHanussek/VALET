#!/bin/bash

for i in {1..10}
do
	qsub qsub_short.sh
done

for i in {1..20}
do
	qsub qsub_long.sh
done

for i in {1..10}
do
	qsub qsub_short.sh
done
