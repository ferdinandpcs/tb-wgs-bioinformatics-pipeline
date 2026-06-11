(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~$ cd ~/wgs/mission03
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ cp ../mission02/alignment.sam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ samtools view -Sb alignment.sam > alignment.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ ls -lh alignment.sam alignment.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ samtools sort alignment.bam -o alignment_sorted.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ ls -lh alignment_sorted.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ samtools index alignment_sorted.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ ls -lh alignment_sorted.bam.bai
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ samtools flagstat alignment_sorted.bam
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ samtools depth alignment_sorted.bam | head -n 10
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission03$ samtools coverage alignment_sorted.bam
