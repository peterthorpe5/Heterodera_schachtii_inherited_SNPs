
cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/

conda activate vcftools



#!/bin/bash
# requires bcftools/bgzip/tabix and vcftools

# set filters
MAF=0.9
MISS=0.9
QUAL=30
MIN_DEPTH=3
MAX_DEPTH=50

# create a filtered VCF containing only invariant sites
vcftools --vcf test.vcf \
--max-maf 0 \
--recode --stdout | bgzip -c > test_invariant.vcf.gz

# create a filtered VCF containing only variant sites
vcftools --vcf test.vcf \
--mac 1  \
--remove-indels  --max-missing $MISS --minQ $QUAL \
--min-meanDP $MIN_DEPTH --max-meanDP $MAX_DEPTH \
--minDP $MIN_DEPTH --maxDP $MAX_DEPTH  \
--recode --stdout | bgzip -c > Hs_variant.vcf.gz

# index both vcfs using tabix
tabix test_invariant.vcf.gz
tabix test_variant.vcf.gz

# combine the two VCFs using bcftools concat
/shelf/apps/pjt6/conda/envs/bcftools/bin/bcftools concat \
--allow-overlaps \
test_variant.vcf.gz test_invariant.vcf.gz \
-O z -o test_filtered.vcf.gz



# http://www.ddocent.com/filtering/
# https://speciationgenomics.github.io/filtering_vcfs/

VCF_IN=Hsch_bcftools.allsites.vcf
VCF_OUT=./full_filtered/Hsch_bcftools.vcftools.full_filtered.vcf

# set filters
MAF=0.7
MISS=0.9
QUAL=30
MIN_DEPTH=3
MAX_DEPTH=500


# perform the filtering with vcftools
vcftools --vcf Hsch_bcftools.allsites.vcf  \
--remove-indels --maf $MAF --max-missing $MISS --minQ $QUAL \
--min-meanDP $MIN_DEPTH --max-meanDP $MAX_DEPTH \
--minDP $MIN_DEPTH --maxDP $MAX_DEPTH --recode --stdout > Hs_variant.vcf

bgzip Hs_variant.vcf
tabix -p vcf Hs_variant.vcf

# NOT FILTERING ON MAF - prject design. expect low MAF
# perform the filtering with vcftools
vcftools --gzvcf $VCF_IN  \
--remove-indels  --max-missing $MISS --minQ $QUAL \
--min-meanDP $MIN_DEPTH --max-meanDP $MAX_DEPTH \
--minDP $MIN_DEPTH --maxDP $MAX_DEPTH --recode --stdout > $VCF_OUT

 bgzip ./full_filtered/Hsch_bcftools.vcftools.full_filtered.vcf
 
  tabix -p vcf ./full_filtered/Hsch_bcftools.vcftools.full_filtered.vcf.gz

cp DROS_kitchen_GATK.g5mac3dp3.recode.vcf  DROS_kitchen_GATK.g5mac3dp3.recode.vcf.bk
# do we want to get rid of missing indv:
vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --missing-indv

cat out.imiss


vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --TsTv-summary --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf  --depth --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --TsTv-by-count --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --weir-fst-pop --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --het --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --TajimaD --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --relatedness --out all_merged

vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --site-quality --out all_merged

#vcftools --vcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --SNPdensity1000 --out all_merged

vcftools --gzvcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --hardy --out s83

#vcftools --gzvcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --site-pi --out s83


#vcftools --gzvcf DROS_kitchen_GATK.g5mac3dp3.recode.vcf --hap-r2 --out s83


cat  DROS_kitchen_GATK.g5mac3dp3.recode.vcf | /storage/home/users/pjt6/shelf_apps/apps/vcftools/src/perl/vcf-stats --prefix aa_stats

