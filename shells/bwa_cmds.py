from collections import defaultdict
import os

top = """#!/bin/bash
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
"""

count = 0
for filename in os.listdir(".") :
    if not filename.endswith("_R1_paired.fq.gz") : continue
    count = count +1
    f = "RG_bams_%d.sh" % count
    f_out = open(f, "w")

    prefix = filename.split("_R1")[0]
    bwa_cmd = "/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 mem -t 12 /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/trimmed//genome/Cam_Hsc_genome1.2.fa %s_R1_paired.fq.gz %s_R2_paired.fq.gz | /shelf/apps/pjt6/conda/envs/trinity/bin/samtools view -b -o ../bams/%s.bam - \n\n" % (prefix, prefix, prefix)
    #print(bwa_cmd)
    f_out.write(top)
    f_out.write(bwa_cmd)
    picard_cmd = "java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  SortSam INPUT=../bams/%s.bam OUTPUT=../bams/%s_sorted.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT\n\n" % (prefix, prefix)
    #print(picard_cmd)
    f_out.write(picard_cmd)
    picard_cmd = "java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  MarkDuplicates  INPUT=../bams/%s_sorted.bam  OUTPUT=../bams/%s_sorted_marked.bam METRICS_FILE=%s_metrics.txt ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT\n\n" % (prefix, prefix, prefix)
    #print(picard_cmd)
    f_out.write(picard_cmd)
    picard_cmd = "java -Xmx119G -jar /shelf/apps/pjt6/conda/envs/picard/share/picard-2.18.29-0/picard.jar  AddOrReplaceReadGroups I=../bams/%s_sorted_marked.bam O=../bams/%s_sorted_marked_RG.bam RGLB=lib1 RGPL=Illumina RGPU=flowcell:Sample RGSM=%s SO=coordinate CREATE_INDEX=true  VALIDATION_STRINGENCY=LENIENT\n" % (prefix, prefix, prefix) 
    #print(picard_cmd)
    f_out.write(picard_cmd)
    f_out.close()
    print("qsub -V -pe multi 9 %s \n" % f)