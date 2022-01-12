import os
handle = open("names_wanted.txt","w")
fastqc_script = open("fastqc_script.sh","w")

fastqc_script.write("fastqc ")


count = 0
for filename in os.listdir(".") :
    if not filename.endswith("1.fq.gz") : continue
    count = count + 1
    out = "trimmo_%d.sh" % count
    trimmo = open(out,"w")
    name = filename
    prefix = filename.split("_1")[0]
    exp = prefix
    
    handle.write("Sample_%s/\n/%s\n" % (prefix, name))
    fastqc_script.write("%s_paired.fq.gz " % (prefix))
    trimmo.write("cd /storage/home/users/pjt6/2022_jan_12_Hschac_DNAseq_inherited_SNPs/raw/\n")
    trimmo.write("java -jar /storage/home/users/pjt6/fly_selective_sweeps/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 8 -phred33 %s_1.fq.gz %s_2.fq.gz ../trimmed/%s_R1_paired.fq.gz ../trimmed/%s_R1_unpaired.fq.gz ../trimmed/%s_R2_paired.fq.gz ../trimmed/%s_R2_unpaired.fq.gz ILLUMINACLIP:/storage/home/users/pjt6/fly_selective_sweeps/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:59\n" \
                 % (prefix, prefix, exp, exp, exp, exp))
    trimmo.close()
    print("qsub -V -pe multi 8 trimmo_%d.sh\n" % count)
fastqc_script.close()
handle.close()

