# Mycobacterium tuberculosis WGS Bioinformatics Pipeline

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

```
<img width="2816" height="1536" alt="workflow" src="https://github.com/user-attachments/assets/0882d929-4744-42ac-b2ba-7ffbb4f48647" />

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

A total of **1,147 genomic variants** were identified relative to the H37Rv reference genome.

| Variant Type | Count |
|-------------|---------|
| SNP | 988 |
| MNP | 68 |
| Insertions | 38 |
| Deletions | 47 |
| Mixed Variants | 6 |
| Total | 1,147 |

Variants were identified using FreeBayes and annotated using SnpEff.

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

| Drug | Prediction | Gene | Mutation |
|----------|----------|----------|----------|
| Rifampicin | Resistant | rpoB | Ser450Leu |
| Rifapentine | Resistant | rpoB | Ser450Leu | Rifampicin / Rifapentine |
| Isoniazid | Resistant | katG | Ser315Thr |
| Ethambutol | Resistant | embB | Met306Ile | Ethambutol |
| Pyrazinamide | Resistant | pncA | c.454delG |
| Streptomycin | Resistant | rpsL | Lys43Arg |
| Para-aminosalicylic acid | Resistant | folC | Glu40Gln |

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
