# Software Environment

## Project Environment

This project was performed using a Linux-based bioinformatics environment running under Windows Subsystem for Linux (WSL2).

### System Information

| Parameter           | Value               |
| ------------------- | ------------------- |
| Operating System    | Ubuntu 26.04 (WSL2) |
| Architecture        | x86_64              |
| Platform            | linux-64            |
| Environment Manager | Conda               |
| Conda Version       | 26.3.2              |

---

## Software Versions

### Data Retrieval

| Software                 | Version |
| ------------------------ | ------- |
| SRA Toolkit (prefetch)   | 3.4.1   |
| SRA Toolkit (fastq-dump) | 3.4.1   |

### Quality Control and Read Processing

| Software | Version |
| -------- | ------- |
| FastQC   | 0.12.1  |
| fastp    | 1.3.3   |

### Genome Mapping and Alignment

| Software | Version |
| -------- | ------- |
| BWA      | 0.7.19  |
| SAMtools | 1.23.1  |

### Variant Detection and Annotation

| Software  | Version |
| --------- | ------- |
| FreeBayes | 1.3.8   |
| SnpEff    | 5.4c    |

### Drug Resistance and Lineage Analysis

| Software       | Version |
| -------------- | ------- |
| TBProfiler Web | 6.7.0   |

---

## Reference Genome

| Item        | Description                      |
| ----------- | -------------------------------- |
| Organism    | Mycobacterium tuberculosis H37Rv |
| Accession   | NC_000962.3                      |
| Source      | NCBI GenBank                     |
| File Format | FASTA (.fna)                     |

---

## Conda Environment

The bioinformatics workflow was executed within a dedicated Conda environment:

```bash
conda activate wgs
```

Conda channels:

```text
conda-forge
bioconda
defaults
```

Channel priority:

```text
strict
```

---

## Notes

The TBProfiler analysis included in this repository was performed using the official TBProfiler web platform because local installation dependencies were not fully compatible with the software environment used during this project.

All upstream analyses, including sequence retrieval, quality control, read preprocessing, genome mapping, BAM processing, variant calling, variant filtering, and variant annotation, were performed locally through command-line execution.
