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
/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 12 /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/trimmed//genome/Cam_Hsc_genome1.2.fa J2_A_R1_paired.fq.gz J2_A_R2_paired.fq.gz | /shelf/apps/pjt6/conda/envs/trinity/bin/samtools view -b -o ../bams/J2_A.bam - 

java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  SortSam INPUT=../bams/J2_A.bam OUTPUT=../bams/J2_A_sorted.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT

java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  MarkDuplicates  INPUT=../bams/J2_A_sorted.bam  OUTPUT=../bams/J2_A_sorted_marked.bam METRICS_FILE=J2_A_metrics.txt ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT

java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  AddOrReplaceReadGroups I=../bams/J2_A_sorted_marked.bam O=../bams/J2_A_sorted_marked_RG.bam RGLB=lib1 RGPL=Illumina RGPU=flowcell:Sample RGSM=J2_A SO=coordinate CREATE_INDEX=true  VALIDATION_STRINGENCY=LENIENT
