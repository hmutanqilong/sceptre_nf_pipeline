#!/bin/bash
#SBATCH -J trans_rpe1
#SBATCH -A pi-xuanyao
#SBATCH -p xuanyao-hm
#SBATCH --qos xuanyao
#SBATCH -n 1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=7-00:00:00
#SBATCH --error=./log_sbatch/trans_nf_dirver_%J.err
#SBATCH --output=./log_sbatch/trans_nf_dirver_%J.out

module load nextflow/24.10.6

# Limit NF driver
export NXF_OPTS="-Xms10G -Xmx20G"

#################
#    Input
#################

main_nf=/project/xuanyao/qilong/Project/Core_Gene_Programs_II/99_scripts/02_sceptre_analysis/run_sceptre/nf_pipeline/main.nf
config_path=/project/xuanyao/qilong/Project/Core_Gene_Programs_II/99_scripts/02_sceptre_analysis/run_sceptre/config

cell_line=RPE1


#################
# Invoke pipeline
#################
nextflow run -resume ${main_nf} \
 -c ${config_path}/nextflow_rcc_trans.config \
 -profile hpc \
 -with-report reports/report_trans_${cell_line}_$(date +%Y%m%d).html \
 -with-trace reports/trace_trans_${cell_line}_$(date +%Y%m%d).txt \
 -with-timeline reports/timeline_trans_${cell_line}_$(date +%Y%m%d).html \
 -params-file ${config_path}/sceptre_params_trans.yml


