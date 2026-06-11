(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~$ cd ~/wgs/mission04
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ cp ../mission03/alignment_sorted.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ cp ../mission03/alignment_sorted.bam.bai
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ cp ../mission02/reference.fna
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ freebayes -f reference.fna --min-mapping-quality 20 --min-basequality 20 --min-coverage 10 alignment_sorted.bam > variants_raw.vcf
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ bcftools filter -e 'QUAL < 30 || INFO/DP < 10 || AF < 0.1' variants_raw.vcf -o variants_filtered.vcf
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ bcftools norm -f reference.fna -m- variants_filtered.vcf -o variants_norm.vcf
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ grep "^#CHROM" variants_norm.vcf && grep -v "^#" variants_norm.vcf |
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ grep -v "^#" variants_norm.vcf | cut -f1 | sort -u
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ sed 's/NC_000962.3/Chromosome/g' variants_norm.vcf > variants_norm_renamed.vcf
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission04$ snpEff ann -v -stats snpEff_summary.html Mycobacterium_tuberculosis_h37rv variants_norm_renamed.vcf > variants_annotated.vcf
