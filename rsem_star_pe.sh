#!/bin/bash
#SBATCH --qos=normal
#SBATCH --job-name=rsem_star_pe
#SBATCH -o rsem_star_pe_Output_log.txt
#SBATCH -e rsem_star_pe_Error_log.txt
#SBATCH --mail-user=nkaur@tulane.edu
#SBATCH --mail-type=ALL
#SBATCH --time=12:00:00
#SBATCH --nodes=1 #nodes
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=128000



module load rsem/1.2.31
module load star
module load samtools
module load bzip2

prefix=${1%_[1-2].fastq}

rsem-calculate-expression --star -p 20 --paired-end --output-genome-bam --sort-bam-by-coordinate --append-names --forward-prob=0 $prefix"_1.fastq" $prefix"_2.fastq" /lustre/project/lgragert/peptide-binding/rna_seq/1_hg38/hg38_chr_labels $prefix"_hg38"
