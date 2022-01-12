#!/bin/bash
#$ -V ## pass all environment variables to the job, VERY IMPORTANT
#$ -N addRG ## job name
#$ -S /bin/bash ## shell where it will run this job
#$ -cwd ## Execute the job from the current working directory
#$ -pe multi 9
#$ -m e
cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/trimmed/
#export PATH=/shelf/apps/pjt6/conda/envs/trinity/bin/$PATH

export PATH=/shelf/apps/pjt6/conda/envs/picard/bin/$PATH

conda activate picard
/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 12 /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/trimmed//genome/Cam_Hsc_genome1.2.fa Female_B_R1_paired.fq.gz Female_B_R2_paired.fq.gz | /shelf/apps/pjt6/conda/envs/trinity/bin/samtools view -b -o ../bams/Female_B.bam - 

java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  SortSam INPUT=../bams/Female_B.bam OUTPUT=../bams/Female_B_sorted.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT

java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  MarkDuplicates  INPUT=../bams/Female_B_sorted.bam  OUTPUT=../bams/Female_B_sorted_marked.bam METRICS_FILE=Female_B_metrics.txt ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT

java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  AddOrReplaceReadGroups I=../bams/Female_B_sorted_marked.bam O=../bams/Female_B_sorted_marked_RG.bam RGLB=lib1 RGPL=Illumina RGPU=flowcell:Sample RGSM=Female_B SO=coordinate CREATE_INDEX=true  VALIDATION_STRINGENCY=LENIENT
