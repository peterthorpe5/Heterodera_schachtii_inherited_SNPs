cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/unique_mapped/
module load samtools

pigz -d *
. /shelf/apps/pjt6/conda/etc/profile.d/conda.sh 

samtools mpileup -B *.bam > all.mpileup
conda activate gnu


sh /storage/home/users/pjt6/PoolSNP/PoolSNP.sh   \
mpileup=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/unique_mapped/all.mpileup \
reference=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa \
names=Female_A,J2_A,Male_A,Female_B,J2_B,Male_B,Female_C,J2_C,Male_C \
max-cov=0.98 \
min-cov=6 \
min-count=8 \
min-freq=0.00 \
miss-frac=0.1 \
jobs=22 \
badsites=1 \
allsites=0 \
base-quality 30 \
jobs=10 \
output=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/unique_mapped/HSpoolsnp_out_min_freq0.0


sh /storage/home/users/pjt6/PoolSNP/PoolSNP.sh   \
mpileup=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/unique_mapped/all.mpileup \
reference=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa \
names=Female_A,J2_A,Male_A,Female_B,J2_B,Male_B,Female_C,J2_C,Male_C \
max-cov=0.98 \
min-cov=6 \
min-count=8 \
min-freq=0.00 \
miss-frac=0.1 \
jobs=22 \
badsites=0 \
allsites=1 \
base-quality 30 \
jobs=10 \
output=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/unique_mapped/Hspoolsnp_out_all_sitesmin_freq0.0
# allsites=1 for all sites
