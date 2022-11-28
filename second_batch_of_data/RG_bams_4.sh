#!/bin/bash -l
#SBATCH -J map   #jobname
#SBATCH --partition=medium 
#SBATCH --cpus-per-task=20
#SBATCH --mem=45GB

cd /home/pthorpe/scratch/HS_inhertied_snps/trimmed/

conda activate picard
~/apps/bwa-mem2/bwa-mem2 mem -t 16 /home/pthorpe/scratch/HS_inhertied_snps/genome/Cam_Hsc_genome1.2.fa MC_R1_paired.fq.gz MC_R2_paired.fq.gz | samtools view -@ 4 -q 20 -bS | samtools sort - -@ 4 -o ../bams/MC.bam 

java -Xmx45G -jar /mnt/shared/scratch/pthorpe/apps/conda/envs/picard/share/picard-2.27.4-0/picard.jar  SortSam INPUT=../bams/MC.bam OUTPUT=../bams/MC_sorted.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT

java -Xmx45G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  MarkDuplicates  INPUT=../bams/MC_sorted.bam  OUTPUT=../bams/MC_sorted_marked.bam METRICS_FILE=MC_metrics.txt ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT

java -Xmx45G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  AddOrReplaceReadGroups I=../bams/MC_sorted_marked.bam O=../bams/MC_sorted_marked_RG.bam RGLB=lib1 RGPL=Illumina RGPU=flowcell:Sample RGSM=MC SO=coordinate CREATE_INDEX=true  VALIDATION_STRINGENCY=LENIENT
