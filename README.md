## Somatic Variant Analysis Project (Project 2)

This repository contains all code, outputs, and documentation for somatic variant analysis of cutaneous squamous cell carcinoma (cSCC) using paired tumor–normal whole-exome sequencing (WES) data.

The workflow follows GATK Best Practices, with variant annotation using VEP and downstream analysis in R (including mutational signature analysis).

### Repository Structure

| Path / File | Description |
|-------------|-------------|
| **cgi_results/** | Annotation results from Cancer Genome Interpreter (CGI) |
| **outputs/** | Summary tables from part 1, including driver mutation summary and Top 10 mutated genes |
| **p1_plots/** | Figures for Part 1 (mutation burden, mutation landscape, driver genes, COSMIC CGC cross-reference) |
| **p2_plots/** | Figures for Part 2 (mutational signatures, COSMIC mapping, mechanism grouping) |
| **signature_tables/** | Results from signature analysis, including COSMIC matches, exposures, and similarity scores |
| **Internship Project Report – Somatic Analysis.pdf** | Final project report (LaTeX compiled PDF) |
| **README.md** | Project documentation (this file) |
| **internship_code.qmd** | Quarto source for the report |
| **variant_tables/** | Per-sample and combined MAF tables, functional mutation tables, COSMIC CGC annotation results |
| **Cosmic_CancerGeneCensus_v102_GRCh38.tsv** | Reference table from COSMIC Cancer Gene Census (v102, GRCh38) |
| **wes_cscc_pipeline.png** | Workflow diagram |

---

### Data Description

- **Samples:** Seven cSCC tumor–normal WES pairs (P3–P9)  
- **Reference Genome:** GRCh38/hg38  
- **Raw Data:** Paired-end FASTQ files from [ENA PRJNA603106](https://www.ebi.ac.uk/ena/browser/view/PRJNA603106)  
- **Variant Calling:** GATK Mutect2 (tumor–normal mode)  
- **Annotation:**  
  - **VEP (offline)** – Functional consequence annotation  
  - **Cancer Genome Interpreter** – Driver and biomarker annotation

---

### Analysis Workflow

1. **Preprocessing** – QC, BWA-MEM alignment, sorting, indexing, duplicate marking  
2. **Somatic Variant Calling** – Mutect2 tumor–normal mode, filtering  
3. **Annotation** – VEP offline annotation, CGI driver mutation annotation  
4. **Part 1 Analysis** –
   - Mutation burden calculation
   - mutation landscape visualisation
   - driver gene identification
   - cross-reference with COSMIC Cancer Gene Census (CGC)
6. **Part 2 Analysis** –  
   - Construct 96-context SNV catalogue  
   - Extract mutational signatures (NMF)  
   - Match de novo signatures to COSMIC SBS  
   - Group signatures into mechanisms (UV, APOBEC, MMR)  
7. **Visualization** – Oncoplots, signature profiles, exposure plots, mechanism contributions

---

### Deliverables

- **Tables:** Variant tables, TMB statistics, signature match tables  
- **Figures:** Pipeline diagram, Mutation burden plots, oncoplots, signature exposures, mechanism plots  
- **Code:** `internship_code.qmd`  
- **Final Report:** `Internship Project Report – Somatic Analysis.pdf`
