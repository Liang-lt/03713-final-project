# Functional Enrichment with GREAT

This step in the pipeline assigns biological meaning to conserved enhancers using **GREAT (Genomic Regions Enrichment of Annotations Tool)**. It maps enhancer coordinates to nearby genes and identifies enriched Gene Ontology (GO) terms, pathways, and phenotype annotations.

---

## Accessing GREAT

GREAT is a web-based tool and can be accessed at:
https://great.stanford.edu/public/html/

---

## Input
- BED file of validated conserved enhancers (e.g., `results/conserved_enhancers.bed`)
- Select correct genome assembly (e.g., `mm10`, `hg38`)

---

## Usage Instructions

### Step 1: Prepare BED file for upload
Ensure your BED file contains only 3 columns: chromosome, start, end
```bash
cut -f1-3 results/conserved_enhancers.bed > results/input_clean.bed
```

### Step 2: Upload to [GREAT](http://great.stanford.edu/public/html/)
Options to set:
- **Species Assembly**: Choose `hg38` for human or `mm10` for mouse
- **Test Regions**: Upload `input_clean.bed`
- **Background Regions**: Use default (whole genome) or choose manually

### Step 3: Download Results
- Enrichment tables (e.g., GO terms, MGI/OMIM phenotype associations)
- Region-to-gene association graphs
- Export PDF or image plots for report use

---

## Output Examples
- `GO_enrichment.tsv`  → Enriched GO Biological Process terms
- `phenotype_enrichment.tsv` → MGI/OMIM phenotype associations
- Region plots or term bar graphs saved as PDF or PNG

---

## Notes
- GREAT is not available as a command-line tool
- Use the same genome build across all steps
- Associations are based on genomic proximity, not overlap alone
