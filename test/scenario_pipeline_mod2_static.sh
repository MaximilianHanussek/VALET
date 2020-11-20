#!/bin/bash

download=200
for i in $(seq 1 $download)
do
	ID_download=$(qsub -N download_$i pipeline_mod2/download_static.sh)
done


merge=10
for i in $(seq 1 $merge)
do
	ID_merge=$(qsub -N merge_$i -W depend=afterany:$ID_download pipeline_mod2/merge.sh)
done


dump=10
for i in $(seq 1 $dump)
do
	ID_dump=$(qsub -N dump_$i -W depend=afterany:$ID_merge pipeline_mod2/dump.sh)
done


ID_nhr_assemble=$(qsub -N nhr_assemble -W depend=afterany:$ID_dump pipeline_mod2/nhr_assemble.sh)


ID_nhr_index=$(qsub -N nhr_index -W depend=afterany:$ID_nhr_assemble pipeline_mod2/nhr_index.sh)


sseq_align=200
for i in $(seq 1 $sseq_align)
do
        ID_sseq_align=$(qsub -N sseq_align_$i -W depend=afterany:$ID_nhr_index pipeline_mod2/sseq_align.sh)
done


ID_cluster=$(qsub -N cluster -W depend=afterany:$ID_sseq_align pipeline_mod2/cluster.sh)


sseq_align2=200
for i in $(seq 1 $sseq_align2)
do
        ID_sseq_align2=$(qsub -N sseq_align2_$i -W depend=afterany:$ID_cluster pipeline_mod2/sseq_align2.sh)
done


ID_breakpoints=$(qsub -N breakpoints -W depend=afterany:$ID_sseq_align2  pipeline_mod2/breakpoints.sh)


ID_strand_assign=$(qsub -N strand_assign -W depend=afterany:$ID_breakpoints pipeline_mod2/strand_assign.sh)


var_calling=30
for i in $(seq 1 $var_calling)
do
        ID_var_calling=$(qsub -N var_calling_$i -W depend=afterany:$ID_strand_assign pipeline_mod2/var_calling.sh)
done


wh_phase=30
for i in $(seq 1 $wh_phase)
do
        ID_wh_phase=$(qsub -N wh_phase_$i -W depend=afterany:$ID_var_calling pipeline_mod2/wh_phase.sh)
done


wh_tag=30
for i in $(seq 1 $wh_tag)
do
        ID_wh_tag=$(qsub -N wh_tag_$i -W depend=afterany:$ID_wh_phase pipeline_mod2/wh_tag.sh)
done


wh_split=30
for i in $(seq 1 $wh_split)
do
        ID_wh_split=$(qsub -N wh_split_$i -W depend=afterany:$ID_wh_tag pipeline_mod2/wh_split.sh)
done


hap_assemble=120
for i in $(seq 1 $hap_assemble)
do
        ID_hap_assemble=$(qsub -N hap_assemble_$i -W depend=afterany:$ID_wh_split pipeline_mod2/hap_assemble.sh)
done


hap_align=120
for i in $(seq 1 $hap_align)
do
        ID_hap_align=$(qsub -N hap_align_$i -W depend=afterany:$ID_hap_assemble pipeline_mod2/hap_align.sh)
done


polish=120
for i in $(seq 1 $polish)
do
        ID_polish=$(qsub -N polish_$i -W depend=afterany:$ID_hap_align pipeline_mod2/polish.sh)
done


sseq_align3=800
for i in $(seq 1 $sseq_align3)
do
        ID_sseq_align3=$(qsub -N sseq_align3_$i -W depend=afterany:$ID_polish pipeline_mod2/sseq_align3.sh)
done

for i in $(seq 1 4)
do
        qsub -N hap_cluster_$i -W depend=afterany:$ID_sseq_align3 pipeline_mod2/hap_cluster.sh
done
