# tb-wgs-bioinformatics-pipeline
Professional bioinformatics portfolio project: WGS analysis of Mycobacterium tuberculosis for lineage determination and antimicrobial resistance prediction.

# Mycobacterium tuberculosis WGS Bioinformatics Pipeline

## Overview

This repository showcases an end-to-end bioinformatics workflow for the analysis of **Mycobacterium tuberculosis whole genome sequencing (WGS)** data using publicly available sequencing datasets.

The project demonstrates practical skills in:

* Linux command-line bioinformatics
* Quality control of NGS data
* Read trimming and preprocessing
* Reference-based genome mapping
* Variant calling
* Drug resistance prediction
* Lineage determination
* Genomic data interpretation
* Reproducible bioinformatics workflows

This repository was developed as a professional bioinformatics portfolio project.

---

## Project Objectives

The main objectives of this project are:

1. Perform WGS analysis of *Mycobacterium tuberculosis*.
2. Determine phylogenetic lineage.
3. Identify genomic variants associated with antimicrobial resistance.
4. Classify drug-resistance profile based on WHO-associated mutations.
5. Demonstrate practical bioinformatics skills relevant to microbial genomics and infectious disease research.

---

## Dataset

Public sequencing data were obtained from the NCBI Sequence Read Archive (SRA).

| Item                | Description                      |
| ------------------- | ---------------------------------|
| Organism            | Mycobacterium tuberculosis       |
| Sequencing platform | Illumina                         |
| Data source         | NCBI SRA (Acc. Numb. SRR37582408)|
| Analysis type       | Whole Genome Sequencing (WGS)    |

---

## Bioinformatics Workflow

```text
Raw FASTQ
    │
    ▼
Quality Control (FastQC)
    │
    ▼
Read Trimming (Trimmomatic)
    │
    ▼
Reference Mapping (BWA)
    │
    ▼
BAM Processing (SAMtools)
    │
    ▼
Variant Calling (FreeBayes)
    │
    ▼
TBProfiler Analysis
    │
 ┌──┴─────────────┐
 ▼                ▼
Lineage       Drug Resistance
Analysis      Prediction
```

---

## Software

| Software    | Version |
| ----------- | ------- |
| FastQC      | latest  |
| Trimmomatic | 0.39    |
| BWA         | 0.7.17  |
| SAMtools    | 1.18    |
| FreeBayes   | 1.3.6   |
| TBProfiler  | 6.7.0   |

---

## Repository Structure

```text
tb-wgs-bioinformatics-pipeline/
│
├── README.md
│
├── data/
│   └── sample_metadata.csv
│
├── workflow/
│   └── workflow_diagram.png
│
├── scripts/
│   ├── fastqc.sh
│   ├── trimming.sh
│   ├── bwa_mapping.sh
│   ├── variant_calling.sh
│   └── tbprofiler.sh
│
├── results/
│   ├── qc/
│   ├── lineage/
│   ├── resistance/
│   ├── variants/
│   └── figures/
│
├── docs/
│   ├── methods.md
│   ├── interpretation.md
│   └── portfolio_summary.md
│
└── environment/
    └── environment.yml
```

---

## Key Results

### Lineage Identification

| Feature              | Result                 |
| -------------------- | ---------------------- |
| Major Lineage        | Lineage 4              |
| Sublineage           | 4.1.1.3                |
| Family               | Euro-American (X-type) |
| Region of Difference | RD193                  |

Interpretation:

The isolate belongs to the Euro-American lineage, one of the globally distributed *M. tuberculosis* lineages frequently reported across multiple continents.

---

### Drug Resistance Profile

| Drug                     | Prediction |
| ------------------------ | ---------- |
| Rifampicin               | Resistant  |
| Isoniazid                | Resistant  |
| Ethambutol               | Resistant  |
| Pyrazinamide             | Resistant  |
| Streptomycin             | Resistant  |
| Para-aminosalicylic acid | Resistant  |

Overall classification:

**MDR-TB (Multidrug Resistant Tuberculosis)**

---

### Resistance-Associated Mutations

| Gene | Mutation  | Associated Drug |
| ---- | --------- | --------------- |
| rpoB | Ser450Leu | Rifampicin      |
| katG | Ser315Thr | Isoniazid       |
| embB | Met306Ile | Ethambutol      |
| pncA | 454delG   | Pyrazinamide    |
| rpsL | Lys43Arg  | Streptomycin    |
| folC | Glu40Gln  | PAS             |

---

### Coverage Metrics

| Metric                | Value |
| --------------------- | ----- |
| Median Depth          | 58X   |
| Genome Coverage       | High  |
| Lineage Confidence    | High  |
| Resistance Confidence | High  |

---

## Biological Interpretation

The analyzed isolate was classified as MDR-TB due to the presence of canonical resistance mutations in both:

* rpoB (Rifampicin resistance)
* katG (Isoniazid resistance)

Additional mutations associated with resistance to Ethambutol, Pyrazinamide, Streptomycin, and PAS were also detected.

No confirmed resistance-associated mutations were detected for:

* Fluoroquinolones
* Bedaquiline
* Linezolid
* Delamanid
* Pretomanid

These findings suggest that several WHO-recommended second-line drugs may remain effective.

---

## Skills Demonstrated

### Bioinformatics

* NGS data processing
* Genome mapping
* Variant calling
* Microbial genomics
* Antimicrobial resistance analysis
* WGS interpretation

### Computational

* Linux
* Bash scripting
* Conda environments
* Reproducible workflows
* Data management

### Biological

* Tuberculosis genomics
* Drug resistance mechanisms
* Molecular epidemiology
* Genomic surveillance

---

## Future Improvements

Potential extensions of this project include:

* Phylogenomic analysis
* SNP distance analysis
* Comparative genomics
* Resistome characterization
* Virulome characterization
* Interactive workflow automation using Snakemake or Nextflow

---

## Author

**Dr. drh. Ferdinand Prayogo Cahyo Santoso**

Veterinarian | Microbiologist | Bioinformatics Enthusiast

Research interests:

* Microbial genomics
* Antimicrobial resistance
* Veterinary microbiology
* Virology
* Immunology
* Computational biology

---

## Disclaimer

This repository is intended for educational and portfolio purposes only.

The analyzed sequencing data originate from publicly available datasets and all biological interpretations should be validated using complementary laboratory and clinical information.
