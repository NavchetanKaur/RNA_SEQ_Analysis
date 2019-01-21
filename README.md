# RNA_SEQ_Analysis Pipeline


1 Quality Control Check on raw sequencing data

1.1 [Install the Java Development Kit](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) followed by  [FASTQC](https://raw.githubusercontent.com/s-andrews/FastQC/master/INSTALL.txt)

1.2 Run FASTQC for all fastq files

```
for i in *.fastq
	do 
		echo $i
		./fastqc $i -o fastqc_results/
	done
```	


1.3 Check for quality plots in fastqc_results

2 Alignment and Read Counts

2.1 Download the [reference genome](ftp://ftp.ensembl.org/pub/release-95/fasta/homo_sapiens/dna/) and [Gene Transfer File](ftp://ftp.ensembl.org/pub/release-95/gtf/homo_sapiens/)

2.2. Install [RSEM](https://deweylab.github.io/RSEM/)

		```
		git clone git@github.com:bli25ucb/RSEM_tutorial.git
		cd software
		unzip bowtie2-2.2.6-source.zip
		cd bowtie2-2.2.6
		make -j 8
		cd ..
		tar -xzf RSEM-1.2.25.tar.gz
		cd RSEM-1.2.25
		make -j 8
		make ebseq
		cd ..
		cd ..
		gunzip ref/Homo_sapiens.GRCh38.dna_sm.toplevel.fa.gz
		gunzip ref/Homo_sapiens.GRCh38.95.chr.gtf.gz
		software/RSEM-1.2.25/rsem-prepare-reference --gtf ref/Homo_sapiens.GRCh38.95.chr.gtf --bowtie2 --bowtie2-path software/bowtie2-2.2.6 ref/Homo_sapiens.GRCh38.dna_sm.toplevel.fa ref/1_hg38
		```



2.3 Submit the jobs to Cypress (Tulane HPC) for alignment and counts 

	```
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
```
	```

	for i in *1.fastq; 
		do 
			sbatch rsem_star_pe.sh $i; 
	done ```


module load rsem

rsem-generate-data-matrix Can_5_hg38.genes.results Can_6_hg38.genes.results CTR_1_hg38.genes.results CTR_2_hg38.genes.results > canvsctrl.genes.matrix.txt


rsem-run-ebseq canvsctrl.genes.matrix.txt 2,2 canvsctrl.genes.results.txt