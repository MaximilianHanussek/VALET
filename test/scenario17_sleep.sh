#!/bin/bash

for i in {1..13}
do
	qsub qsub_long_sleep.sh
done

for i in {1..19}
do
	qsub qsub_middle_sleep.sh
done

for i in {1..15}
do
	qsub qsub_short_sleep.sh
done
