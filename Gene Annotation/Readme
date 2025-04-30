# Genomic Annotation with ChIPseeker

This step of the pipeline annotates validated conserved enhancers using the R package **ChIPseeker**. It classifies regulatory elements based on their genomic context (e.g., promoter, intron, intergenic) and generates a PDF plot summarizing the distribution.

---

## Dependencies

Install the following R packages:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ChIPseeker")
BiocManager::install("TxDb.Hsapiens.UCSC.hg38.knownGene")
BiocManager::install("clusterProfiler")
```

---

## Input
- BED file of conserved enhancer coordinates (e.g., `results/conserved_enhancers.bed`)

---

## Output
- PDF plot: Genomic annotation distribution (e.g., `results/enhancer_annotation.pdf`)
- Optional: CSV or RData of annotation summary

---

## Example Script: `05_annotate_conserved.R`

```r
library(ChIPseeker)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

args <- commandArgs(trailingOnly = TRUE)
bed_file <- args[1]
pdf_file <- args[2]

peak <- readPeakFile(bed_file)
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
peak_anno <- annotatePeak(peak, tssRegion = c(-1000, 1000), TxDb = txdb)

pdf(pdf_file)
plotAnnoBar(peak_anno)
dev.off()
```

---

## Running the Script

```bash
Rscript scripts/05_annotate_conserved.R results/conserved_enhancers.bed results/enhancer_annotation.pdf
```

---

## Notes
- The annotation database (`TxDb`) must match the genome build (e.g., hg38)
- You can modify the TSS window by changing the `tssRegion` parameter
- For mouse data, use `TxDb.Mmusculus.UCSC.mm10.knownGene
