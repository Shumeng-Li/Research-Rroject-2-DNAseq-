# Somatic Variant Analysis Project (Project 2)

This repository contains all scripts, annotations, and visualizations for somatic variant analysis using tumor-normal whole-exome sequencing (WES) data. The workflow is based on GATK Best Practices and includes variant annotation via VEP and CGI, as well as downstream analysis in R.

## Project Structure

- scripts/               # Shell scripts for preprocessing and variant calling
- plots/                 # Output figures from R analysis
- cgi_results/           # Annotation results from Cancer Genome Interpreter
- variant_table.zip      # Per-sample variant tables annotated via Ensembl VEP and command-line VEP
- combined_maf.maf       # Combined mutation annotation file (MAF format)
- Project 2.qmd          # Final report (Quarto format)
- README.md              # Project description

## Data Description

- **Samples**: Two tumor-normal pairs (`P3`, `P6`)
- **Reference Genome**: GRCh38
- **Raw Data**: Tumor and normal FASTQ files for each sample
- **Variant Caller**: GATK Mutect2
- **Annotation Tools**:
  - [Ensembl VEP](https://www.ensembl.org/info/docs/tools/vep/index.html)  
    - Used via Ensembl online platform to generate `P3.vep.tsv` and `P6.vep.tsv` (stored in `variant_table.zip`)
  - **Offline VEP annotation** via `05_annotate.sh`  
    - Generated `P3_annotation.vep.txt` and `P6_annotation.vep.txt` locally using command-line VEP (stored in `variant_table.zip`)
  - [Cancer Genome Interpreter (CGI)](https://www.cancergenomeinterpreter.org)  
    - Used to generate driver mutation and biomarker annotations; results stored in `cgi_results/`

## Analysis Workflow

### 1. Preprocessing & Variant Calling
Shell scripts in the `/scripts/` directory perform:
- `01_align.sh` – BWA-MEM alignment to GRCh38
- `02_markdup.sh` – Mark duplicates with GATK
- `03_run_mutect2.sh` – Call somatic variants using Mutect2
- `04_filter_calls.sh` – Apply variant filters
- `05_annotate.sh` – Run annotation (e.g., VEP)

### 2. Variant Annotation
- Ensembl VEP was used online to annotate variants for each sample (`P3.vep.tsv`, `P6.vep.tsv` inside `variant_table.zip`).
- Cancer Genome Interpreter (CGI) was used to annotate driver mutations and biomarkers. Results are in `/cgi_results/`.

### 3. Visualization & Summary
- R scripts (not included here) were used to generate figures saved in the `/plots/` directory.
- Mutation statistics were calculated and visualized using [maftools](https://bioconductor.org/packages/maftools) and `ggplot2`.

## Deliverables
- Variant tables per sample (VEP)
- Combined MAF file
- CGI-based mutation annotations
- Visualizations (e.g., oncoplots, top mutated genes)
- Project 2.qmd
