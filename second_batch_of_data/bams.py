bam = """A_20K_sorted_marked.bam     FA_sorted_marked.bam     MA_sorted_marked.bam
A_20K_sorted_marked_RG.bam  FA_sorted_marked_RG.bam  MA_sorted_marked_RG.bam
B_20K_sorted_marked.bam     FB_sorted_marked.bam     MB_sorted_marked.bam
B_20K_sorted_marked_RG.bam  FB_sorted_marked_RG.bam  MB_sorted_marked_RG.bam
C_20K_sorted_marked.bam     FC_sorted_marked.bam     MC_sorted_marked.bam
C_20K_sorted_marked_RG.bam  FC_sorted_marked_RG.bam  MC_sorted_marked_RG.bam""".split()


count = 0
f = "filter_bams.sh" #% (count)
f_out = open(f, "w")


for i in bam:
    f = "filter_bams%s.sh" % (count)
    
    count = count+1
    out = "cd /storage/home/users/pjt6/HS_inhertied_snps//\nconda activate bcftools\nsamtools view -@ 24 -Sbh -q 20 -F 0x100 %s | samtools sort - -@ 8 -o ./unique_mapped/%s\n" % (i, i.split(".bam")[0])
    f_out.write(out)
    
    print("qsub -V %s\n" % f)
f_out.close()
    