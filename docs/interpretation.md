# Biological Interpretation

## Overview

Whole genome sequencing analysis of Mycobacterium tuberculosis isolate SRR37582408 identified a multidrug-resistant strain belonging to the Euro-American lineage.

---

## Sequencing Quality

The dataset demonstrated excellent sequencing quality.

Key observations:

- GC content (~65%) matches expected M. tuberculosis genome composition.
- More than 96% of reads passed quality filtering.
- Adapter contamination was effectively removed.
- Q30 score increased after trimming.

These findings indicate that the sequencing data were suitable for downstream genomic analysis.

---

## Mapping Performance

Alignment against the H37Rv reference genome produced:

- 98.97% mapping rate
- 98.10% properly paired reads
- 99.44% genome coverage
- Mean depth of 66.86X

These metrics indicate high-quality genome reconstruction and sufficient sequencing depth for variant analysis.

---

## Variant Analysis

A total of 1,147 genomic variants were identified.

Variant composition:

- SNPs: 988
- MNPs: 68
- Insertions: 38
- Deletions: 47
- Mixed variants: 6

The predominance of SNPs is consistent with expected evolutionary patterns in Mycobacterium tuberculosis.

---

## Lineage Assignment

TBProfiler classified the isolate as:

Lineage 4.1.1.3

Family:

Euro-American (X-type)

RD marker:

RD193

Lineage 4 is among the most globally distributed M. tuberculosis lineages and has been reported across Europe, Africa, Asia, and the Americas.

---

## Drug Resistance Interpretation

The isolate was classified as:

MDR-TB

This classification is supported by canonical resistance mutations in:

### Rifampicin

Gene:

rpoB

Mutation:

Ser450Leu

This mutation is among the most frequently reported rifampicin resistance mutations worldwide.

### Isoniazid

Gene:

katG

Mutation:

Ser315Thr

This mutation is strongly associated with high-level isoniazid resistance.

---

## Additional Resistance Mutations

Additional resistance-associated variants were detected in:

| Gene | Mutation | Drug |
|--------|--------|--------|
| embB | Met306Ile | Ethambutol |
| pncA | c.454delG | Pyrazinamide |
| rpsL | Lys43Arg | Streptomycin |
| folC | Glu40Gln | PAS |

These findings suggest broader resistance beyond rifampicin and isoniazid.

---

## Second-Line Drugs

No confirmed resistance-associated mutations were detected for:

- Moxifloxacin
- Levofloxacin
- Bedaquiline
- Linezolid
- Delamanid
- Pretomanid

Therefore, the isolate does not meet genomic criteria for pre-XDR-TB or XDR-TB based on currently detected mutations.

---

## Conclusion

Whole genome sequencing successfully identified a high-confidence MDR-TB isolate belonging to Lineage 4.1.1.3 (Euro-American lineage).

The project demonstrates the application of microbial genomics for lineage determination and antimicrobial resistance prediction using publicly available sequencing data and open-source bioinformatics tools.
