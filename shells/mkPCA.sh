
#VCF=../Goodeids.GATKHardFilt.NoMissingGenotypes.BiAllelicOnly.PrunedEvery100bp.vcf.gz
VCF=/storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/full_filtered/Hsch_glnexus_merged.vcf.gz

conda activate plink

### The #double-id #extra-chr #set-missing-id allows plink to run on non-model systems since plink initially designed for humans.
#plink2 --vcf $VCF --threads 16 --double-id --allow-extra-chr --set-missing-var-ids @:# --vcf-half-call m --freq --out Goodeids


### This script actually does the PCA and takes a chr file with each line specifying chr name
while read line;do
plink --vcf $VCF --chr $line --threads 16 --double-id --allow-extra-chr --set-missing-var-ids @:# --vcf-half-call m --pca --out glnexus.$line.PCA
done < ../chromosome_list
