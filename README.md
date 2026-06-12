![Bioinformatics](https://img.shields.io/badge/Field-Bioinformatics-blue)
![WGS](https://img.shields.io/badge/Analysis-WGS-green)
![Tuberculosis](https://img.shields.io/badge/Organism-M.tuberculosis-red)
![Linux](https://img.shields.io/badge/Linux-Bash-black)

# Mycobacterium tuberculosis WGS Bioinformatics Pipeline

## Project Highlights

✔ Public NCBI SRA dataset analysis


✔ End-to-end WGS workflow

✔ 99.44% genome coverage

✔ Mean depth 66.86×

✔ 1,147 genomic variants identified

✔ MDR-TB isolate detected

✔ Lineage 4.1.1.3 (Euro-American)

## Overview

This repository demonstrates an end-to-end whole genome sequencing (WGS) analysis workflow for *Mycobacterium tuberculosis* using publicly available Illumina sequencing data from the NCBI Sequence Read Archive (SRA).

The project was developed through a hands-on microbial genomics training workflow (by INBIO Indonesia on June 2026) and extended with independent downstream analysis using TBProfiler for lineage determination and antimicrobial resistance prediction.

This project demonstrates practical bioinformatics competencies in:

- Linux command-line bioinformatics
- NCBI SRA data retrieval
- Sequence quality assessment
- Read preprocessing and trimming
- Reference-based genome mapping
- BAM processing and alignment statistics
- Variant calling and filtering
- Variant annotation
- Tuberculosis lineage determination
- Antimicrobial resistance prediction
- Genomic data interpretation

---

# Project Objectives

1. Perform WGS analysis of *Mycobacterium tuberculosis* from raw sequencing data.
2. Assess sequencing quality and preprocessing performance.
3. Identify genomic variants relative to the H37Rv reference genome.
4. Predict phylogenetic lineage and antimicrobial resistance-associated mutations.
5. Demonstrate reproducible microbial genomics workflows for portfolio purposes.

---

# Dataset

Public sequencing data were obtained from the NCBI Sequence Read Archive (SRA).

| Item | Description |
|--------|--------|
| Organism | *Mycobacterium tuberculosis* |
| SRA Accession | SRR37582408 |
| Sequencing Platform | Illumina |
| Analysis Type | Whole Genome Sequencing (WGS) |
| Reference Genome | H37Rv (NC_000962.3) |

---

# Bioinformatics Workflow

<img width="2816" height="1536" alt="workflow" src="https://github.com/user-attachments/assets/6476bc29-2ff5-4046-8e44-dbecca6a3155" />

**Figure 1. End-to-End Bioinformatics Pipeline for Whole Genome Sequencing (WGS) Analysis of *Mycobacterium tuberculosis*.** The diagram illustrates the systematic workflow executed in this project:
1. **Data Retrieval & Preprocessing:** Retrieval of raw reads from NCBI SRA (SRR37582408), followed by quality assessment using FastQC and read trimming via fastp.
2. **Alignment & Variant Detection:** Reference-based genome mapping against *M. tuberculosis* H37Rv (NC_000962.3) using BWA-MEM, processing with SAMtools, variant calling via FreeBayes, filtering with bcftools, and functional annotation using SnpEff.
3. **Extended Analysis:** Lineage identification (Lineage 4.1.1.3 Euro-American) and antimicrobial resistance prediction (MDR-TB status characterized by key mutations including *rpoB* Ser450Leu and *katG* Ser315Thr) using TBProfiler.
---

# Software Environment

| Software | Version |
|-----------|-----------|
| Conda | 26.3.2 |
| SRA Toolkit | 3.4.1 |
| FastQC | 0.12.1 |
| fastp | 1.3.3 |
| BWA | 0.7.19 |
| SAMtools | 1.23.1 |
| FreeBayes | 1.3.8 |
| SnpEff | 5.4c |
| TBProfiler Web | 6.7.0 |

---

# Repository Structure

```
tb-wgs-bioinformatics-pipeline/
│
├── README.md
│
├── data/
│   └── sample_metadata.csv
│
├── docs/
│   ├── interpretation.md
│   ├── methods.md
│   └── portfolio_summary.md
│
├── workflow/
│   ├── workflow_diagram.png
│   └── analysis_pipeline.md
│
├── scripts/
│   ├── mission01_data_preparation.sh
│   ├── mission02_mapping.sh
│   ├── mission03_converting_shorting.sh
│   └── mission04_variant_calling.sh
│
├── results/
│   ├── resistance/
│   │   └── tbprofiler_report.txt
│   │
│   ├── variants/
│   │   ├── variants_filtered.vcf
│   │   └── variants_annotated.vcf
│   │
│   └── figures/
│
└── environment/
    └── software_versions.md
```

---

# Sequencing Quality Assessment

## Raw Reads

| Metric | Read 1 | Read 2 |
|----------|----------|----------|
| Total Sequences | 1,050,097 | 1,050,097 |
| GC Content | 65% | 65% |
| Per Base Quality | Pass | Pass |
| Adapter Content | Pass | Pass |
| Sequence Length Distribution | Warning | Warning |
| Per Sequence GC Content | Pass | Warning |

---

## fastp Preprocessing Summary

| Metric | Before | After |
|----------|----------|----------|
| Total Reads | 2,100,194 | 2,022,114 |
| Reads Passed Filter | - | 96.28% |
| GC Content | 65.18% | 65.17% |
| Q20 | 95.54% | 96.65% |
| Q30 | 88.84% | 90.83% |
| Adapter Content | Present | ~0% |

The preprocessing step improved overall read quality while retaining more than 96% of sequencing reads.

---

## Quality Improvement

<img width="2816" height="1536" alt="quality inmprovement" src="https://github.com/user-attachments/assets/994fda33-06e0-4255-abd8-375f5e81560a" />

**Figure 2. Quality Improvement Before vs. After fastp Preprocessing (SRR37582408).** This comparative figure visualizes the significant enhancement in sequencing quality metrics achieved by the fastp cleaning step. The left column displays the raw input data (from SRR37582408_1.fastq and SRR37582408_2.fastq), while the right column shows the cleaned output (from sample_clean_1.fastq and sample_clean_2.fastq). The systematic analysis covers:
1. **Per sequence quality scores:** Demonstrates a pronounced rightward shift in Phred score distribution, with an improved average Q30 percentage from 88.84% to 90.83%.
2. **Per sequence GC content:** Validates effective bias reduction; the raw data ("Warning" status on R2) shows shoulders and non-canonical distributions, whereas the cleaned data exhibits smooth, symmetric curves tightly adhering to the theoretical M. tuberculosis H37Rv GC profile (65.17%).
3. **Sequence Length Distribution:** Confirms standard length unification; the mixed length distribution ("Warning") in raw reads is consolidated into a single, clean peak at the expected insert size (e.g., 100bp) after removing adapter content and short sequences.
---

# Mapping Statistics

Reference genome:

**Mycobacterium tuberculosis H37Rv (NC_000962.3)**

## Alignment Summary

| Metric | Value |
|----------|----------|
| Total Reads | 2,025,128 |
| Mapped Reads | 2,004,332 |
| Mapping Rate | 98.97% |
| Properly Paired Reads | 1,983,768 |
| Properly Paired Rate | 98.10% |
| Singletons | 13,176 |

---

## Coverage Statistics

| Metric | Value |
|----------|----------|
| Genome Size | 4,411,532 bp |
| Covered Bases | 4,386,945 bp |
| Genome Coverage | 99.44% |
| Mean Depth | 66.86× |
| Mean Mapping Quality | 59.4 |

The high mapping rate and genome coverage indicate excellent sequencing quality and suitability for downstream variant analysis.

---

# Variant Calling Results

## Variant Summary

A total of **1,147 genomic variants** were identified relative to the H37Rv reference genome.  Variants were identified using FreeBayes and annotated using SnpEff.

<img width="1024" height="559" alt="variants distribution" src="https://github.com/user-attachments/assets/1f4ba0a4-e782-41df-851d-9dd95d033d5c" />

---

# TBProfiler Results

## Lineage Identification

| Feature | Result |
|----------|----------|
| Major Lineage | Lineage 4 |
| Sublineage | 4.1.1.3 |
| Family | Euro-American (X-type) |
| Region of Difference | RD193 |

The isolate belongs to the globally distributed Euro-American lineage.

---

## Drug Resistance Classification

### Overall Classification

**MDR-TB (Multidrug Resistant Tuberculosis)**

---

### Predicted Resistant Drugs and Resistance-Associated Mutasions

<img width="1408" height="768" alt="resistance" src="https://github.com/user-attachments/assets/3d88f013-388e-4720-b5e2-5dab2589d4df" />

---

## Biological Interpretation

The isolate fulfills the genomic criteria for MDR-TB due to the presence of canonical resistance-conferring mutations in:

- rpoB (Rifampicin resistance)
- katG (Isoniazid resistance)

Additional resistance-associated mutations affecting Ethambutol, Pyrazinamide, Streptomycin, and PAS were detected.

No confirmed resistance mutations were identified for:

- Fluoroquinolones
- Bedaquiline
- Linezolid
- Delamanid
- Pretomanid

These findings suggest potential susceptibility to several WHO-recommended second-line anti-tuberculosis drugs.

---

# Skills Demonstrated

## Bioinformatics

- NGS quality assessment
- Read preprocessing
- Reference-based genome mapping
- BAM processing
- Variant calling
- Variant filtering
- Variant annotation
- AMR prediction
- Tuberculosis genomics

## Computational

- Linux command line
- Bash workflow execution
- Conda environment management
- Reproducible analysis
- Genomic data handling

## Biological

- *Mycobacterium tuberculosis* genomics
- Antimicrobial resistance mechanisms
- Molecular epidemiology
- Public sequencing data analysis

---

# Future Extensions

Potential future analyses include:

- Phylogenomic reconstruction
- SNP distance analysis
- Comparative genomics
- Resistome profiling
- Virulome characterization
- Workflow automation using Snakemake or Nextflow

---

# Author

**Dr. drh. Ferdinand Prayogo Cahyo Santoso**

Veterinarian | Microbiologist | Bioinformatics Enthusiast

LinkedIn: https://www.linkedin.com/in/ferdinandpcs/

Email: ferdinand.prayogo.c@mail.ugm.ac.id | ferdinandvet@gmail.com

Research interests:
- Microbial genomics
- Antimicrobial resistance
- Veterinary microbiology
- Virology
- Immunology
- Computational biology

---

# Disclaimer

This repository is intended for professional portfolio purposes.

All sequencing data originate from publicly available repositories. Biological and clinical conclusions should be validated using complementary laboratory and epidemiological information.

Workflow diagrams, summary illustrations, and selected graphical elements in this repository were generated with AI-assisted tools and subsequently reviewed and curated by the author. These visualizations are provided for communication and educational purposes only. All reported methods, analytical results, biological interpretations, and conclusions are based on actual bioinformatics analyses performed on the dataset described in this repository.
