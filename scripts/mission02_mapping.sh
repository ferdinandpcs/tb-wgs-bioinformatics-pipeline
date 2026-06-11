(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~$ cd ~/wgs/mission02
## Manual download reference genome from Genbank (.fna): NC_000962.3 Mycobacterium tuberculosis H37Rv
## Placing the downloaded reference to ~/wgs/mission02
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission02$ ls reference.fna.*
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission02$ cp ../mission01/sample_clean_1.fastq 
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission02$ cp ../mission01/sample_clean_2.fastq
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission02$ bwa mem reference.fna sample_clean_1.fastq sample_clean_2.fastq > alignment.sam
