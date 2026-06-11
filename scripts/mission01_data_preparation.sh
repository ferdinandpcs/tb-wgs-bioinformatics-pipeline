(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~$ cd ~/wgs/mission01
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission01$ prefetch SRR37582408
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission01$ fastq-dump --split-files SRR37582408/SRR37582408.sra
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission01$ fastqc SRR37582408_1.fastq -o
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission01$ fastqc SRR37582408_2.fastq -o
(wgs) ferdinandpcs@LAPTOP-OODCP5Q8:~/wgs/mission01$ fastp -i SRR37582408_1.fastq -I SRR37582408_2.fastq -o sample_clean_1.fastq -O sample_clean_2.fastq --detect_adapter_for_pe --html fastp_report.html --json fastp_report.json
