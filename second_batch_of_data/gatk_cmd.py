from collections import defaultdict
import os

headers = ("""cd /storage/home/users/pjt6/kitchen_flies/trimmed


#conda activate gatk\n\n""")
count = 0
for filename in os.listdir(".") :
    if not filename.endswith("_R1_paired.fq.gz") : continue
    count = count + 1
    prefix = filename.split("_R1")[0]
    f = "%s_gatk.sh" % prefix
    f_out = open(f, "w")
    #gatk_cmd = "gatk --java-options '-Xmx80G' HaplotypeCaller  --max-num-haplotypes-in-population 1000 -R /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa -I /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/%s_sorted_marked_RG.bam -O /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/%s.vcf" % (prefix, prefix)
    # make gvcfs
    gatk_cmd = "gatk --java-options '-Xmx15G' HaplotypeCaller  -ERC GVCF --max-num-haplotypes-in-population 1000 -R /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa -I /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/%s_sorted_marked_RG.bam -O /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/%s.g.vcf.gz" % (prefix, prefix)

    f_out.write(headers)
    f_out.write(gatk_cmd)
    f_out.close()
    print("qsub -l singularity -b y singularity  run /storage/home/users/pjt6/fly_selective_sweeps/gatk-nightly_latest.sif  /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/trimmed/%s_gatk.sh\n" % prefix)
    #print(gatk_cmd)
    
    # next one
    
    count = count + 1
    f = "%s_gatk_relaxed.sh" % prefix
    f_out = open(f, "w")
    #     gatk_cmd = "gatk --java-options '-Xmx20G' HaplotypeCaller  --max-num-haplotypes-in-population 1000 --max-reads-per-alignment-start 0 -R /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa -I /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/%s_sorted_marked_RG.bam -O /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/%s_relaxed.vcf" % (prefix, prefix)

    gatk_cmd = "gatk --java-options '-Xmx15G' HaplotypeCaller -ERC GVCF  --max-num-haplotypes-in-population 1000 --max-reads-per-alignment-start 0 -R /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/genome/Cam_Hsc_genome1.2.fa -I /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/bams/%s_sorted_marked_RG.bam -O /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/vcfs/%s_relaxed.g.vcf.gz" % (prefix, prefix)
    f_out.write(headers)
    f_out.write(gatk_cmd)
    f_out.close()
    print("qsub -l singularity -b y singularity  run /storage/home/users/pjt6/fly_selective_sweeps/gatk-nightly_latest.sif  /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/trimmed/%s_gatk_relaxed.sh\n" % prefix)
    #print(gatk_cmd)
    
