


cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/


bcftools mpileup -f /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa \
-b /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/bams  | bcftools call -m -Oz -f GQ -o ../vcfs/Hsch_bcftools.allsites.vcf

