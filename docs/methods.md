# Methods

## Computing Environment

All analyses were performed on Linux (WSL2 Ubuntu) using Conda-managed bioinformatics environments.

### Software Versions

| Software       | Version |
| -------------- | ------- |
| Conda          | 26.3.2  |
| SRA Toolkit    | 3.4.1   |
| FastQC         | 0.12.1  |
| fastp          | 1.3.3   |
| BWA            | 0.7.19  |
| SAMtools       | 1.23.1  |
| FreeBayes      | 1.3.8   |
| SnpEff         | 5.4c    |
| TBProfiler Web | 6.7.0   |

---

# Mission 01 – Data Preparation and Quality Control

## Data Retrieval

Public sequencing data were downloaded from the NCBI Sequence Read Archive (SRA).

### Dataset

| Item                | Description                   |
| ------------------- | ----------------------------- |
| Organism            | Mycobacterium tuberculosis    |
| Accession Number    | SRR37582408                   |
| Sequencing Platform | Illumina                      |
| Analysis Type       | Whole Genome Sequencing (WGS) |

### Commands

```bash
prefetch SRR37582408

fastq-dump --split-files SRR37582408/SRR37582408.sra
```

Output:

* SRR37582408_1.fastq
* SRR37582408_2.fastq

---

## Quality Assessment

Raw sequencing reads were evaluated using FastQC.

### Commands

```bash
fastqc SRR37582408_1.fastq

fastqc SRR37582408_2.fastq
```

### Quality Summary Before Trimming

#### Read 1

| Metric                       | Result    |
| ---------------------------- | --------- |
| Total Sequences              | 1,050,097 |
| Sequence Length              | 31–151 bp |
| GC Content                   | 65%       |
| Per Base Quality             | PASS      |
| Per Sequence GC Content      | PASS      |
| Adapter Content              | PASS      |
| Sequence Length Distribution | WARNING   |

#### Read 2

| Metric                       | Result    |
| ---------------------------- | --------- |
| Total Sequences              | 1,050,097 |
| Sequence Length              | 35–151 bp |
| GC Content                   | 65%       |
| Per Base Quality             | PASS      |
| Per Sequence GC Content      | WARNING   |
| Adapter Content              | PASS      |
| Sequence Length Distribution | WARNING   |

---

## Read Trimming and Filtering

Sequencing reads were cleaned using fastp.

### Commands

```bash
fastp -i SRR37582408_1.fastq -I SRR37582408_2.fastq -o sample_clean_1.fastq -O sample_clean_2.fastq --detect_adapter_for_pe --html fastp_report.html --json fastp_report.json

```

### Quality Metrics

| Metric               | Before    | After     |
| -------------------- | --------- | --------- |
| Reads                | 2,100,194 | 2,022,114 |
| Reads Passed Filters | -         | 96.28%    |
| GC Content           | 65.18%    | 65.17%    |
| Q20                  | 95.54%    | 96.65%    |
| Q30                  | 88.84%    | 90.83%    |
| Adapter Content      | Present   | ~0%       |

### Post-Trimming Verification

FastQC was repeated on cleaned reads.

#### Clean Read 1

| Metric                       | Result    |
| ---------------------------- | --------- |
| Total Sequences              | 1,011,057 |
| Sequence Length              | 31–151 bp |
| GC Content                   | 65%       |
| Per Base Quality             | PASS      |
| Per Sequence GC Content      | PASS      |
| Adapter Content              | PASS      |
| Sequence Length Distribution | WARNING   |

#### Clean Read 2

| Metric                       | Result    |
| ---------------------------- | --------- |
| Total Sequences              | 1,011,057 |
| Sequence Length              | 31–151 bp |
| GC Content                   | 65%       |
| Per Base Quality             | PASS      |
| Per Sequence GC Content      | WARNING   |
| Adapter Content              | PASS      |
| Sequence Length Distribution | WARNING   |

---

# Mission 02 – Reference Genome Mapping

## Reference Genome

Reference genome used:

Mycobacterium tuberculosis H37Rv

Accession:

NC_000962.3

Reference sequence was downloaded manually from GenBank in FASTA format.

---

## Read Alignment

Cleaned paired-end reads were aligned against the H37Rv reference genome using BWA-MEM.

### Command

```bash
bwa mem reference.fna \
sample_clean_1.fastq \
sample_clean_2.fastq \
> alignment.sam
```

Output:

```text
alignment.sam
```

---

# Mission 03 – BAM Processing and Coverage Analysis

## SAM to BAM Conversion

```bash
samtools view -Sb alignment.sam > alignment.bam
```

---

## BAM Sorting

```bash
samtools sort alignment.bam -o alignment_sorted.bam
```

---

## BAM Indexing

```bash
samtools index alignment_sorted.bam
```

---

## Alignment Statistics

### Command

```bash
samtools flagstat alignment_sorted.bam
```

### Results

| Metric                | Value     |
| --------------------- | --------- |
| Total Reads           | 2,025,128 |
| Mapped Reads          | 2,004,332 |
| Mapping Rate          | 98.97%    |
| Properly Paired Reads | 1,983,768 |
| Properly Paired (%)   | 98.10%    |
| Singletons            | 13,176    |

These metrics indicate excellent alignment performance against the reference genome.

---

## Coverage Analysis

### Command

```bash
samtools coverage alignment_sorted.bam
```

### Results

| Metric               | Value        |
| -------------------- | ------------ |
| Reference Length     | 4,411,532 bp |
| Genome Coverage      | 99.44%       |
| Mean Depth           | 66.86X       |
| Mean Base Quality    | 38.2         |
| Mean Mapping Quality | 59.4         |

---

# Mission 04 – Variant Calling and Annotation

## Variant Calling

Variants were identified using FreeBayes.

### Command

```bash
freebayes \
-f reference.fna \
--min-mapping-quality 20 \
--min-basequality 20 \
--min-coverage 10 \
alignment_sorted.bam \
> variants_raw.vcf
```

---

## Variant Filtering

### Command

```bash
bcftools filter \
-e 'QUAL < 30 || INFO/DP < 10 || AF < 0.1' \
variants_raw.vcf \
-o variants_filtered.vcf
```

---

## Variant Normalization

### Command

```bash
bcftools norm \
-f reference.fna \
-m- \
variants_filtered.vcf \
-o variants_norm.vcf
```

---

## Reference Renaming

### Command

```bash
sed 's/NC_000962.3/Chromosome/g' \
variants_norm.vcf \
> variants_norm_renamed.vcf
```

---

## Variant Annotation

Variants were annotated using SnpEff.

### Command

```bash
snpEff ann \
-v \
-stats snpEff_summary.html \
Mycobacterium_tuberculosis_h37rv \
variants_norm_renamed.vcf \
> variants_annotated.vcf
```

---

## Variant Summary

A total of 1,147 variants were identified.

| Variant Type | Count |
| ------------ | ----- |
| SNP          | 988   |
| MNP          | 68    |
| Insertions   | 38    |
| Deletions    | 47    |
| Mixed        | 6     |
| Total        | 1,147 |

---

# Extended Analysis – TBProfiler

Because local installation of TBProfiler was unsuccessful due to dependency conflicts, resistance prediction and lineage analysis were performed using the TBProfiler web platform.

Software version:

TBProfiler 6.7.0

Database version:

7fe4364e

---

## Lineage Assignment

| Feature       | Result                 |
| ------------- | ---------------------- |
| Major Lineage | Lineage 4              |
| Sublineage    | 4.1.1.3                |
| Family        | Euro-American (X-type) |
| RD Marker     | RD193                  |

---

## Drug Resistance Prediction

The isolate was classified as:

**MDR-TB (Multidrug Resistant Tuberculosis)**

Detected resistance-associated mutations:

| Gene | Mutation  | Associated Drug          |
| ---- | --------- | ------------------------ |
| rpoB | Ser450Leu | Rifampicin               |
| katG | Ser315Thr | Isoniazid                |
| embB | Met306Ile | Ethambutol               |
| pncA | c.454delG | Pyrazinamide             |
| rpsL | Lys43Arg  | Streptomycin             |
| folC | Glu40Gln  | Para-aminosalicylic acid |

No confirmed resistance-associated mutations were detected for fluoroquinolones, bedaquiline, linezolid, delamanid, or pretomanid.
