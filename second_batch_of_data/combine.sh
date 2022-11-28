#!/bin/bash -l
#SBATCH -J map   #jobname
#SBATCH --partition=medium 
#SBATCH --cpus-per-task=2
#SBATCH --mem=8GB

cd /home/pthorpe/scratch/HS_inhertied_snps/trimmed/

cat A_20K_EKDN220026404-1A_H33F5DSX5_L*_R2_paired.fq.gz >  A_20K_R2_paired.fq.gz
cat B_20K_EKDN220026405-1A_H33F5DSX5_L*_R2_paired.fq.gz >  B_20K_R2_paired.fq.gz
cat C_20K_EKDN220026406-1A_H33F5DSX5_L*_R2_paired.fq.gz >  C_20K_R2_paired.fq.gz
cat FA_EKDN220026398-1A_H33F5DSX5_L*_R2_paired.fq.gz    >  FA_R2_paired.fq.gz
cat FB_EKDN220026399-1A_H33F5DSX5_L*_R2_paired.fq.gz    >  FB_R2_paired.fq.gz
cat FC_EKDN220026400-1A_H33F5DSX5_L*_R2_paired.fq.gz    >  FC_R2_paired.fq.gz
cat MA_EKDN220026401-1A_H33F5DSX5_L*_R2_paired.fq.gz    >  MA_R2_paired.fq.gz
cat MB_EKDN220026402-1A_H33F5DSX5_L*_R2_paired.fq.gz    >  MB_R2_paired.fq.gz
cat MC_EKDN220026403-1A_H33F5DSX5_L*_R2_paired.fq.gz    >  MC_R2_paired.fq.gz


cat A_20K_EKDN220026404-1A_H33F5DSX5_L*_R1_paired.fq.gz >  A_20K_R1_paired.fq.gz
cat B_20K_EKDN220026405-1A_H33F5DSX5_L*_R1_paired.fq.gz >  B_20K_R1_paired.fq.gz
cat C_20K_EKDN220026406-1A_H33F5DSX5_L*_R1_paired.fq.gz >  C_20K_R1_paired.fq.gz
cat FA_EKDN220026398-1A_H33F5DSX5_L*_R1_paired.fq.gz    >  FA_R1_paired.fq.gz
cat FB_EKDN220026399-1A_H33F5DSX5_L*_R1_paired.fq.gz    >  FB_R1_paired.fq.gz
cat FC_EKDN220026400-1A_H33F5DSX5_L*_R1_paired.fq.gz    >  FC_R1_paired.fq.gz
cat MA_EKDN220026401-1A_H33F5DSX5_L*_R1_paired.fq.gz    >  MA_R1_paired.fq.gz
cat MB_EKDN220026402-1A_H33F5DSX5_L*_R1_paired.fq.gz    >  MB_R1_paired.fq.gz
cat MC_EKDN220026403-1A_H33F5DSX5_L*_R1_paired.fq.gz    >  MC_R1_paired.fq.gz


mv A_20K_EKDN220026404-1A_H33F5DSX5_L*_R*_paired.fq.gz  ./lanes/
mv B_20K_EKDN220026405-1A_H33F5DSX5_L*_R*_paired.fq.gz  ./lanes/
mv C_20K_EKDN220026406-1A_H33F5DSX5_L*_R*_paired.fq.gz  ./lanes/
mv FA_EKDN220026398-1A_H33F5DSX5_L*_R*_paired.fq.gz     ./lanes/
mv FB_EKDN220026399-1A_H33F5DSX5_L*_R*_paired.fq.gz     ./lanes/
mv FC_EKDN220026400-1A_H33F5DSX5_L*_R*_paired.fq.gz     ./lanes/
mv MA_EKDN220026401-1A_H33F5DSX5_L*_R*_paired.fq.gz     ./lanes/
mv MB_EKDN220026402-1A_H33F5DSX5_L*_R*_paired.fq.gz     ./lanes/
mv MC_EKDN220026403-1A_H33F5DSX5_L*_R*_paired.fq.gz     ./lanes/