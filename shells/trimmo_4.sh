cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/raw/
java -jar /storage/home/users/pjt6/fly_selective_sweeps/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 -phred33 Female_C_1.fq.gz Female_C_2.fq.gz ../trimmed/Female_C_R1_paired.fq.gz ../trimmed/Female_C_R1_unpaired.fq.gz ../trimmed/Female_C_R2_paired.fq.gz ../trimmed/Female_C_R2_unpaired.fq.gz ILLUMINACLIP:/storage/home/users/pjt6/fly_selective_sweeps/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:59
