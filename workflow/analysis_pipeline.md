# Analysis Pipeline

## Project Overview

This project demonstrates a complete whole genome sequencing (WGS) bioinformatics workflow for the analysis of *Mycobacterium tuberculosis* using publicly available Illumina paired-end sequencing data obtained from the NCBI Sequence Read Archive (SRA).

The workflow was performed using open-source bioinformatics tools within a Linux (WSL2) environment and includes sequence retrieval, quality assessment, read preprocessing, reference-based genome mapping, variant detection, variant annotation, and downstream tuberculosis-specific genomic interpretation.

---

# Workflow Summary

```text
NCBI SRA (SRR37582408)
        │
        ▼
Data Retrieval
(SRA Toolkit)
        │
        ▼
Quality Control
(FastQC)
        │
        ▼
Read Cleaning
(fastp)
        │
        ▼
Reference Genome Mapping
(BWA)
        │
        ▼
SAM/BAM Processing
(SAMtools)
        │
        ▼
Variant Calling
(FreeBayes)
        │
        ▼
Variant Filtering
(bcftools)
        │
        ▼
Variant Annotation
(SnpEff)
        │
        ▼
TBProfiler Analysis
        │
 ┌──────┴────────┐
 ▼               ▼
Lineage      Drug Resistance
Analysis     Prediction
```

---

# Step 1 – Data Retrieval

Raw sequencing data were downloaded from the NCBI Sequence Read Archive using SRA Toolkit.

Dataset:

| Parameter     | Value                      |
| ------------- | -------------------------- |
| Organism      | Mycobacterium tuberculosis |
| SRA Accession | SRR37582408                |
| Platform      | Illumina                   |
| Data Type     | Paired-end WGS             |

Commands:

```bash
prefetch SRR37582408

fastq-dump \
    --split-files \
    SRR37582408/SRR37582408.sra
```

Output:

```text
SRR37582408_1.fastq
SRR37582408_2.fastq
```

---

# Step 2 – Quality Assessment

Initial quality assessment was performed using FastQC to evaluate read quality, GC content, adapter contamination, and sequence length distribution.

Commands:

```bash
fastqc SRR37582408_1.fastq

fastqc SRR37582408_2.fastq
```

Key observations before trimming:

| Metric                       | Read 1    | Read 2    |
| ---------------------------- | --------- | --------- |
| Total Reads                  | 1,050,097 | 1,050,097 |
| GC Content                   | 65%       | 65%       |
| Per Base Quality             | Pass      | Pass      |
| Adapter Content              | Pass      | Pass      |
| Sequence Length Distribution | Warning   | Warning   |
| GC Distribution              | Pass      | Warning   |

---

# Step 3 – Read Cleaning and Trimming

Reads were processed using fastp to remove low-quality bases and residual adapter sequences.

Command:

```bash
fastp \
    -i SRR37582408_1.fastq \
    -I SRR37582408_2.fastq \
    -o sample_clean_1.fastq \
    -O sample_clean_2.fastq \
    --detect_adapter_for_pe \
    --html fastp_report.html \
    --json fastp_report.json
```

Results:

| Metric          | Before    | After     |
| --------------- | --------- | --------- |
| Reads           | 2,100,194 | 2,022,114 |
| Passed Filters  | -         | 96.28%    |
| GC Content      | 65.18%    | 65.17%    |
| Q20             | 95.54%    | 96.65%    |
| Q30             | 88.84%    | 90.83%    |
| Adapter Content | Low       | ~0%       |

Quality verification after trimming confirmed retention of high-quality reads suitable for downstream analysis.

---

# Step 4 – Reference Genome Mapping

Trimmed reads were aligned against the *Mycobacterium tuberculosis* H37Rv reference genome (NC_000962.3) using BWA-MEM.

Reference:

| Parameter        | Value       |
| ---------------- | ----------- |
| Reference Genome | H37Rv       |
| Accession        | NC_000962.3 |

Command:

```bash
bwa mem \
    reference.fna \
    sample_clean_1.fastq \
    sample_clean_2.fastq \
    > alignment.sam
```

Output:

```text
alignment.sam
```

---

# Step 5 – BAM Processing

SAM files were converted to BAM format, sorted, indexed, and evaluated using SAMtools.

Commands:

```bash
samtools view -Sb alignment.sam > alignment.bam

samtools sort alignment.bam \
    -o alignment_sorted.bam

samtools index alignment_sorted.bam
```

Mapping Statistics:

| Metric                | Value     |
| --------------------- | --------- |
| Total Reads           | 2,025,128 |
| Mapped Reads          | 2,004,332 |
| Mapping Rate          | 98.97%    |
| Properly Paired Reads | 1,983,768 |
| Proper Pair Rate      | 98.10%    |

Coverage Statistics:

| Metric               | Value  |
| -------------------- | ------ |
| Genome Coverage      | 99.44% |
| Mean Depth           | 66.86× |
| Mean Base Quality    | 38.2   |
| Mean Mapping Quality | 59.4   |

These metrics indicate excellent alignment quality and sufficient sequencing depth for reliable variant detection.

---

# Step 6 – Variant Calling

Genomic variants were identified using FreeBayes.

Command:

```bash
freebayes \
    -f reference.fna \
    --min-mapping-quality 20 \
    --min-basequality 20 \
    --min-coverage 10 \
    alignment_sorted.bam \
    > variants_raw.vcf
```

Variant filtering:

```bash
bcftools filter \
    -e 'QUAL < 30 || INFO/DP < 10 || AF < 0.1' \
    variants_raw.vcf \
    -o variants_filtered.vcf
```

Variant normalization:

```bash
bcftools norm \
    -f reference.fna \
    -m- \
    variants_filtered.vcf \
    -o variants_norm.vcf
```

---

# Step 7 – Variant Annotation

Variants were annotated using SnpEff.

Command:

```bash
snpEff ann \
    -v \
    -stats snpEff_summary.html \
    Mycobacterium_tuberculosis_h37rv \
    variants_norm_renamed.vcf \
    > variants_annotated.vcf
```

Variant Summary:

| Variant Type   | Count |
| -------------- | ----: |
| SNP            |   988 |
| MNP            |    68 |
| Insertion      |    38 |
| Deletion       |    47 |
| Mixed          |     6 |
| Total Variants | 1,147 |

---

# Step 8 – TBProfiler Analysis

Annotated genomic data were further analyzed using TBProfiler to determine lineage and predict antimicrobial resistance.

Results:

| Feature              | Result                 |
| -------------------- | ---------------------- |
| Major Lineage        | Lineage 4              |
| Sublineage           | 4.1.1.3                |
| Family               | Euro-American (X-type) |
| Region of Difference | RD193                  |
| Median Depth         | 58×                    |

Drug Resistance Classification:

```text
MDR-TB
```

Detected Resistance Mutations:

| Gene | Mutation  | Drug         |
| ---- | --------- | ------------ |
| rpoB | Ser450Leu | Rifampicin   |
| katG | Ser315Thr | Isoniazid    |
| embB | Met306Ile | Ethambutol   |
| pncA | c.454delG | Pyrazinamide |
| rpsL | Lys43Arg  | Streptomycin |
| folC | Glu40Gln  | PAS          |

---

# Project Outcome

This workflow successfully demonstrated:

* End-to-end microbial WGS analysis
* High-quality reference genome mapping
* Variant discovery and annotation
* Tuberculosis lineage determination
* Antimicrobial resistance prediction
* Interpretation of clinically relevant genomic variants

The analyzed isolate was classified as Lineage 4.1.1.3 (Euro-American lineage) and MDR-TB based on canonical resistance-associated mutations affecting both rifampicin and isoniazid susceptibility.

---

# Reproducibility

All analyses were executed using open-source software documented in:

```text
environment/software_versions.md
```

Command histories used during the project are available in:

```text
scripts/
```
