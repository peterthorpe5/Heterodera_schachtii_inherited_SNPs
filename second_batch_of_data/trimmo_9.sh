#!/bin/bash -l
#SBATCH -J trimmo_9   #jobname
#SBATCH --partition=medium 
#SBATCH --cpus-per-task=4
#SBATCH --mem=10GB

cd /home/pthorpe/scratch/HS_inhertied_snps/raw_data/
conda activate shell_example

trimmomatic PE -threads 4 -phred33 A_20K_EKDN220026404-1A_H33F5DSX5_L3_1.fq.gz A_20K_EKDN220026404-1A_H33F5DSX5_L3_2.fq.gz ../trimmed/A_20K_EKDN220026404-1A_H33F5DSX5_L3_R1_paired.fq.gz ../trimmed/A_20K_EKDN220026404-1A_H33F5DSX5_L3_R1_unpaired.fq.gz ../trimmed/A_20K_EKDN220026404-1A_H33F5DSX5_L3_R2_paired.fq.gz  ../trimmed/A_20K_EKDN220026404-1A_H33F5DSX5_L3_R2_unpaired.fq.gz ILLUMINACLIP:/home/pthorpe/scratch/HS_inhertied_snps/raw_data/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:69
