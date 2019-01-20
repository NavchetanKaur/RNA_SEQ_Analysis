#! usr/bin/bash




for i in *1.fastq; 
	do 
		sbatch rsem_star_pe.sh $i; 
done