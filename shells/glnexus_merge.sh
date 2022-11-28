
cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/

# manifest is a file, one sample per line
# singularity run "/storage/home/users/pjt6/docker/glnexus_latest.sif"

# remove the databse first, if it exists
rm -rf GLnexus.DB

/storage/home/users/pjt6/docker/glnexus_cli  --mem-gbytes 200 --threads 16 --bed /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.bed  --list manifest > all_samples.bcf
# covert to vcfs/
# bcftools view dv_1000G_ALDH2.bcf | bgzip -@ 4 -c > dv_1000G_ALDH2.vcf.gz

bcftools view all_samples.bcf | bgzip -@ 4 -c > Hsch_glnexus_merges.vcf.gz

# index it
tabix -p  vcf Hsch_glnexus_merges.vcf.gz

# manifest file contains:
#F2014_female_fall_DrosEU_match.g.vcf.gz
#F2015_female_fall_DrosEU_match.g.vcf.gz
#MR19female1.g.vcf.gz
#MR19female2.g.vcf.gz
#MR19male1.g.vcf.gz
#MR19male2.g.vcf.gz
#MR20female1.g.vcf.gz
#MR20female2.g.vcf.gz
#MR20male1.g.vcf.gz
#MR20male2.g.vcf.gz
#MR_female.g.vcf.gz
#MR_male.g.vcf.gz

# to make the invariant sites etc .. 


bcftools mpileup -f /storage/home/users/pjt6/kitchen_flies/genome/dmel-all-chromosome-r6.43.fasta \
-b bams  | bcftools call -m -Oz -f GQ -o ../vcfs/kitchen_fly_bcftools.allsites.vcf



conda activate vcftools



#!/bin/bash
# requires bcftools/bgzip/tabix and vcftools

# set filters
MAF=0.1
MISS=0.9
QUAL=30
MIN_DEPTH=3
MAX_DEPTH=50

# create a filtered VCF containing only invariant sites
vcftools --vcf kitchen_fly_bcftools.allsites.vcf \
--max-maf 0 \
--recode --stdout | bgzip -c > test_invariant.vcf.gz

# create a filtered VCF containing only variant sites -  this was done with glnxus
#vcftools --vcf test.vcf \
#--mac 1  \
#--remove-indels  --max-missing $MISS --minQ $QUAL \
#--min-meanDP $MIN_DEPTH --max-meanDP $MAX_DEPTH \
#--minDP $MIN_DEPTH --maxDP $MAX_DEPTH  \
#--recode --stdout | bgzip -c > test_variant.vcf.gz

# index both vcfs using tabix
tabix /storage/home/users/pjt6/kitchen_flies/vcfs/glnexus_merged_gvcf/dmel_kitcthen_flies.r6.43.vcf.gz
tabix test_invariant.vcf.gz

# combine the two VCFs using bcftools concat
/shelf/apps/pjt6/conda/envs/bcftools/bin/bcftools concat \
--allow-overlaps \
/storage/home/users/pjt6/kitchen_flies/vcfs/glnexus_merged_gvcf/dmel_kitcthen_flies.r6.43.vcf.gz test_invariant.vcf.gz \
-O z -o dmel_kitcthen_flies.r6.43_filtered.with_variant_sites.vcf.gz



