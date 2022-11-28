cd /storage/home/users/pjt6/kitchen_flies/trimmed


#conda activate gatk

gatk --java-options '-Xmx80G' HaplotypeCaller -R /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa -I /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/Female_C_sorted_marked_RG.bam -O /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/Female_C.vcf