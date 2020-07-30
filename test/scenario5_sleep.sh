#!/bin/bash

for i in {1..10}
do
	qsub qsub_short_sleep.sh
done

for i in {1..20}
do
	qsub qsub_middle_sleep.sh
done

for i in {1..10}
do
	qsub qsub_short_sleep.sh
done
