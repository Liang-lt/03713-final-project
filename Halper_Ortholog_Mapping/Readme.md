# Comparative Genomics Analysis: Human and Mouse Regulatory Regions

This repository contains scripts for mapping and analyzing open chromatin regions (peaks) between human and mouse genomes across different tissues (liver and spleen).

## Scripts

### 1. Halper_mapping.job

This script performs cross-species mapping of ATAC-seq peaks using HALper, a tool for orthology mapping:

- Maps mouse spleen peaks to human genome
- Maps human spleen peaks to mouse genome
- Maps mouse liver peaks to human genome
- Maps human liver peaks to mouse genome

The script uses the HAL alignment file and the halLiftover-postprocessing pipeline.

### 2. Halper_Analysis.job

This script performs comprehensive analysis of the mapped peaks:

#### Species Conservation Analysis
- Identifies conserved open chromatin regions between species
- Quantifies the proportion of conserved regions
- Generates detailed conservation statistics

#### Tissue Comparison Analysis
- Identifies shared and tissue-specific open chromatin regions
- Compares liver and spleen regulatory landscapes
- Calculates proportions of shared vs. tissue-specific regions

## Output

Analysis results are saved in the `./Results_Comparison` directory, including:
- Conservation statistics between species
- Tissue-specific regulatory region analysis


## Requirements

- HAL tools (conda environment) 
- `halLiftover` (part of HAL tools)
- bedtools
- bash
