#!/bin/bash

download=$(shuf -i 50-200 -n 1)
for i in $(seq 1 $download)
do
	ID_download=$(qsub -N download_$i test/download.sh)
done


merge=$(shuf -i 1-10 -n 1)
for i in $(seq 1 $merge)
do
	ID_merge=$(qsub -N merge_$i -W depend=afterany:$ID_download test/merge.sh)
done


dump=$(shuf -i 1-10 -n 1)
for i in $(seq 1 $dump)
do
	ID_dump=$(qsub -N dump_$i -W depend=afterany:$ID_merge test/dump.sh)
done


ID_nhr_assemble=$(qsub -N nhr_assemble -W depend=afterany:$ID_dump test/nhr_assemble.sh)


ID_nhr_index=$(qsub -N nhr_index -W depend=afterany:$ID_nhr_assemble test/nhr_index.sh)


sseq_align=$(shuf -i 50-200 -n 1)
for i in (seq 1 $sseq_align)
do
        ID_sseq_align=$(qsub -N sseq_align_$i -W depend=afterany:$ID_nhr_index test/sseq_align.sh)
done


ID_cluster=$(qsub -N cluster -W depend=afterany:$ID_sseq_align test/cluster.sh)


sseq_align2=$(shuf -i 50-200 -n 1)
for i in (seq 1 $sseq_align2)
do
        ID_sseq_align2=$(qsub -N sseq_align2_$i -W depend=afterany:$ID_cluster test/sseq_align2.sh)
done


ID_breakpoints=$(qsub -N breakpoints -W depend=afterany:$ID_sseq_align2  test/breakpoints.sh)


ID_strand_assign=$(qsub -N strand_assign -W depend=afterany:$ID_breakpoints test/strand_assign.sh)


var_calling=$(shuf -i 20-30 -n 1)
for i in (seq 1 $var_calling)
do
        ID_var_calling=$(qsub -N var_calling_$i -W depend=afterany:$ID_strand_assign test/var_calling.sh)
done


wh_phase=$(shuf -i 20-30 -n 1)
for i in (seq 1 $wh_phase)
do
        ID_wh_phase=$(qsub -N wh_phase_$i -W depend=afterany:$ID_var_calling test/wh_phase.sh)
done


wh_tag=$(shuf -i 20-30 -n 1)
for i in (seq 1 $wh_tag)
do
        ID_wh_tag=$(qsub -N wh_tag_$i -W depend=afterany:$ID_wh_phase test/wh_tag.sh)
done


wh_split=$(shuf -i 20-30 -n 1)
for i in (seq 1 wh_split)
do
        ID_wh_split=$(qsub -N wh_split_$i -W depend=afterany:$ID_wh_tag test/wh_split.sh)
done


hap_assemble=$(shuf -i 80-120 -n 1)
for i in (seq 1 $hap_assemble)
do
        ID_hap_assemble=$(qsub -N hap_assemble_$i -W depend=afterany:$ID_wh_split test/hap_assemble.sh)
done


hap_align=$(shuf -i 80-120 -n 1)
for i in (seq 1 $hap_align)
do
        ID_hap_align=$(qsub -N hap_align_$i -W depend=afterany:$ID_hap_assemble test/hap_align.sh)
done


polish=$(shuf -i 80-120 -n 1)
for i in (seq 1 $polish)
do
        ID_polish=$(qsub -N polish_$i -W depend=afterany:$ID_hap_align test/polish.sh)
done


sseq_align3=$(shuf -i 200-800 -n 1)
for i in (seq 1 $sseq_align3)
do
        ID_sseq_align3=$(qsub -N sseq_align3_$i -W depend=afterany:$ID_polish test/sseq_align3.sh
done

for i in (seq 1 4)
do
        qsub -N hap_cluster_$i -W depend=afterany:$ID_sseq_align3 test/hap_cluster.sh
done




















