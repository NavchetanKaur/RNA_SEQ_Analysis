#!usr/bin/bash


module load rsem

rsem-generate-data-matrix Can_5_hg38.genes.results Can_6_hg38.genes.results CTR_1_hg38.genes.results CTR_2_hg38.genes.results > canvsctrl.genes.matrix.txt


software/RSEM-1.2.25/
./rsem-run-ebseq canvsctrl.genes.matrix.txt 2,2 canvsctrl.genes.results.txt