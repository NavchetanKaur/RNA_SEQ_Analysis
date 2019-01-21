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