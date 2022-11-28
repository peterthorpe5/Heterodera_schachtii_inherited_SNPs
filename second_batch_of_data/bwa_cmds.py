from collections import defaultdict
import os

top = """#!/bin/bash -l
#SBATCH -J map   #jobname
#SBATCH --partition=medium 
#SBATCH --cpus-per-task=20
#SBATCH --mem=45GB

cd /home/pthorpe/scratch/HS_inhertied_snps/trimmed/

conda activate picard
"""

count = 0
for filename in os.listdir(".") :
    if not filename.endswith("_R1_paired.fq.gz") : continue
    count = count +1
    f = "RG_bams_%d.sh" % count
    f_out = open(f, "w")

    prefix = filename.split("_R1")[0]
    bwa_cmd = "~/apps/bwa-mem2/bwa-mem2 mem -t 16 /home/pthorpe/scratch/HS_inhertied_snps/genome/Cam_Hsc_genome1.2.fa %s_R1_paired.fq.gz %s_R2_paired.fq.gz | samtools view -@ 4 -q 20 -bS | samtools sort - -@ 4 -o ../bams/%s.bam \n\n" % (prefix, prefix, prefix)
    #print(bwa_cmd)
    f_out.write(top)
    f_out.write(bwa_cmd)
    picard_cmd = "java -Xmx45G -jar /mnt/shared/scratch/pthorpe/apps/conda/envs/picard/share/picard-2.27.4-0/picard.jar  SortSam INPUT=../bams/%s.bam OUTPUT=../bams/%s_sorted.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT\n\n" % (prefix, prefix)
    #print(picard_cmd)
    f_out.write(picard_cmd)
    picard_cmd = "java -Xmx45G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  MarkDuplicates  INPUT=../bams/%s_sorted.bam  OUTPUT=../bams/%s_sorted_marked.bam METRICS_FILE=%s_metrics.txt ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT\n\n" % (prefix, prefix, prefix)
    #print(picard_cmd)
    f_out.write(picard_cmd)
    picard_cmd = "java -Xmx45G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  AddOrReplaceReadGroups I=../bams/%s_sorted_marked.bam O=../bams/%s_sorted_marked_RG.bam RGLB=lib1 RGPL=Illumina RGPU=flowcell:Sample RGSM=%s SO=coordinate CREATE_INDEX=true  VALIDATION_STRINGENCY=LENIENT\n" % (prefix, prefix, prefix.split("_EKDN")[0]) 
    #print(picard_cmd)
    f_out.write(picard_cmd)
    f_out.close()
    print("sbatch %s \n" % f)