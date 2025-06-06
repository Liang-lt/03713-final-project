# Cross-Species Regulatory Conservation Pipeline

This repository provides a reproducible and modular pipeline to identify and functionally annotate conserved enhancers across human and mouse tissues using ATAC-seq data, HAL genome alignments, and motif enrichment tools.

The pipeline spans the entire regulatory discovery workflow—from enhancer projection to functional annotation—supporting tissue-specific and cross-species comparisons.

---

## Overview

This project explores the evolutionary conservation of regulatory elements by:

- Performing ATAC-seq quality control and enhancer annotation  
- Projecting enhancers across species using HAL liftover  
- Filtering orthologous regions with HALPER  
- Validating functional conservation using tissue-matched ATAC-seq  
- Annotating regulatory classes with ChIPseeker  
- Extracting conserved sequences for motif discovery (MEME-ChIP)  
- Performing GO/phenotype enrichment using GREAT  

---

## Folder Structure

```
cross-species-regulatory-pipeline/
├── data/                    # Input ATAC-seq peaks, HAL file, genome FASTAs
├── results/                 # Output: conserved enhancers, motifs, annotations
├── scripts/                 # Modular shell/R/Python scripts
├── envs/                    # Conda environment file
├── pipeline.py              # Optional Python runner (with retry and logging)
├── Snakefile                # Snakemake pipeline
├── run_pipeline.sh          # Shell-based pipeline script
└── README.md
```

---

## Pipeline Execution Options

This repository provides **three ways** to execute the pipeline:

### 1. Python-Based Pipeline (`pipeline.py`)
- Sequential runner with automatic retry logic (3 attempts)
- Logs to `results/pipeline.log`
- Easy to customize in Python

```bash
python pipeline.py
```

### 2. Snakemake Workflow (`Snakefile`)
- Modular, rule-based pipeline manager
- Automatically handles dependencies, reruns only missing steps

```bash
snakemake --cores 1
```

### 3. Shell Script (`run_pipeline.sh`)
- Linear bash script with logging
- Fails fast if any step fails

```bash
bash run_pipeline.sh
```

---

## Workflow Summary

### Step 1: ATAC-seq QC & Peak Annotation
- Input: raw or processed ATAC-seq peaks  
- Tool: ChIPseeker or custom filtering  
- Output: filtered BEDs + annotation summary

### Step 2: Enhancer Candidate Selection
- Use distal peaks (intergenic/intronic)  
- Optional: H3K27ac or chromHMM filtering

### Step 3: Cross-Species Projection
- Tool: `halLiftover`  
- Input: enhancer BED + HAL file  
- Output: lifted regions in target genome

### Step 4: Ortholog Filtering
- Tool: `HALPER`  
- Output: functionally relevant conserved regions

### Step 5: ATAC Validation
- Tool: `bedtools intersect`  
- Output: orthologs overlapping open chromatin

### Step 6: Genomic Annotation
- Tool: `ChIPseeker` (R)  
- Output: classification (promoter, intron, intergenic)

### Step 7: FASTA Extraction
- Tool: `bedtools getfasta`  
- Output: 200bp centered, deduplicated FASTA

### Step 8: Motif Enrichment
- Tool: `MEME-ChIP`, `FIMO`  
- Output: enriched TF binding motifs

### Step 9: Functional Enrichment
- Tool: [GREAT](http://great.stanford.edu)  
- Output: GO terms and phenotype links

### Step 10 (Optional): Promoter Conservation
- Map and compare ±1kb TSS promoters to enhancer conservation

---

## Environment Setup

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/cross-species-regulatory-pipeline.git
cd cross-species-regulatory-pipeline

# Create and activate conda environment
conda env create -f envs/environment.yaml
conda activate enhancer-pipeline
```

---

## Example Outputs

- `conserved_enhancers.bed`: BED file of validated cross-species enhancers overlapping ATAC-seq peaks  
- `enhancer_annotation.pdf`: Bar plot summarizing genomic context (promoter, intron, intergenic, etc.)  
- `motifs/`: Folder containing MEME-ChIP output, motif logos, and enriched TFs  
- `GO_enrichment.tsv`: Functional enrichment results from GREAT (GO terms, phenotypes)

---

## License

MIT License. See the `LICENSE` file for full terms.

---

## Questions or Contributions

Open an issue or pull request on GitHub. 
