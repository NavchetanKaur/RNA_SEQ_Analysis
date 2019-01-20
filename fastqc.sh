#!/bin/bash
#SBATCH --qos=normal
#SBATCH --job-name=fastqc
#SBATCH -o fastqc_output_log.txt
#SBATCH -e fastqc_error_log.txt
#SBATCH --mail-user=mbaddoo@tulane.edu
#SBATCH --mail-type=ALL
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=28000

#######ABOUT THE JOB#######
# This script uses fastqc to assess the quality of fastq files.  

prefix=${1%.gz}

module load fastqc

echo ">>> make directory for temporary files"
mkdir fastqc_tmp

echo ">>> make directory for fastqc reports"
mkdir fastqc_reports

echo ">>> run fastqc"
fastqc -o fastqc_reports/ -d fastqc_tmp/ ${prefix}.gz

echo ">>> done"


