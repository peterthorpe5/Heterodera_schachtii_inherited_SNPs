

cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome


# bwa mem2 index for mapping
/storage/home/users/pjt6/shelf_apps/apps/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 index Cam_Hsc_genome1.2.fa

# samtools index for other stuff later
conda activate trinity 

samtools faidx Cam_Hsc_genome1.2.fa

# picard tools index for gatk variant calling later
conda activate picard

picard CreateSequenceDictionary  R=Cam_Hsc_genome1.2.fa o=Cam_Hsc_genome1.2.dict

