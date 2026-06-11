# 🧬 Protocol Inventory - Chloroplast Genomes & K-mer Analysis

This page serves as an inventory of protocols for analyzing **chloroplast genomes** and **k-mer-based methods** within the group. Each protocol includes **step-by-step instructions** and **SLURM job templates** for running on HPC.

## Table of Contents  
- [Quality Control & Preprocessing](#quality-control--preprocessing)  
  - [Read Quality Assessment](#read-quality-assessment)  
  - [Adapter & Contaminant Removal](#adapter--contaminant-removal)  
  - [Error Correction](#error-correction)  
- [Chloroplast Genome Analysis](#chloroplast-genome-analysis)  
  - [Assembly](#assembly)  
  - [Annotation](#annotation)  
  - [Read Mapping](#read-mapping)  
<!-- - [K-mer Analysis](#k-mer-analysis)  
  - [K-mer Counting](#k-mer-counting)  
  - [Phylogenetic Tree Construction](#phylogenetic-tree-construction)  
- [SLURM Job Templates](#slurm-job-templates)  

## Quality Control & Preprocessing   -->

### Read Quality Assessment  
- Checks sequencing quality before analysis.  
- **Tools:**
- **SLURM Script:** [`qc_assessment.slurm`](qc_assessment.slurm)  

### Adapter & Contaminant Removal  
- Removes adapters and contaminants.  
- **Tools:** Trimmomatic, Cutadapt, fastp  
- **SLURM Script:** [`adapter_trimming.slurm`](adapter_trimming.slurm)  

### Error Correction  
- Corrects sequencing errors in reads.  
- **Tools:** BFC, Lighter, Musket  
- **SLURM Script:** [`error_correction.slurm`](error_correction.slurm)  

<!-- ## Chloroplast Genome Analysis  

### Assembly  
- Assembles chloroplast genomes from reads.  
- **Tools:** SPAdes, GetOrganelle, NOVOPlasty  
- **SLURM Script:** [`assembly.slurm`](assembly.slurm)  

### Annotation  
- Annotates chloroplast genomes using Chloe.jl.  
- **Tools:** Chloe.jl, GeSeq  
- **SLURM Script:** [`annotation.slurm`](annotation.slurm)  

### Read Mapping  
- Maps reads to reference chloroplast genomes.  
- **Tools:** BBMap, Bowtie2  
- **SLURM Script:** [`read_mapping.slurm`](read_mapping.slurm)  

## K-mer Analysis  

### K-mer Counting  
- Counts k-mers in sequencing reads.  
- **Tools:** Jellyfish, Meryl  
- **SLURM Script:** [`kmer_counting.slurm`](kmer_counting.slurm)  

### Phylogenetic Tree Construction  
- Builds phylogenetic trees from k-mer distances.  
- **Tools:** Mashtree, FastME  
- **SLURM Script:** [`kmer_tree.slurm`](kmer_tree.slurm)  

## SLURM Job Templates  
SLURM scripts for all protocols are available. Modify them as needed.  

- [`qc_assessment.slurm`](qc_assessment.slurm) - Quality check  
- [`adapter_trimming.slurm`](adapter_trimming.slurm) - Remove adapters  
- [`error_correction.slurm`](error_correction.slurm) - Correct errors  
- [`assembly.slurm`](assembly.slurm) - Assemble genomes  
- [`annotation.slurm`](annotation.slurm) - Annotate genomes  
- [`read_mapping.slurm`](read_mapping.slurm) - Map reads  
- [`kmer_counting.slurm`](kmer_counting.slurm) - Count k-mers  
- [`kmer_tree.slurm`](kmer_tree.slurm) - Build k-mer phylogenetic trees  

## How to Use  
1. Find the relevant protocol.  
2. Read the instructions and requirements.  
3. Modify and submit the SLURM script:  
   ```sh
   sbatch your_script.slurm -->
