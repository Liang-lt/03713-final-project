# Motif Enrichment Analysis (MEME-ChIP & FIMO)

This module performs motif discovery and enrichment analysis on validated conserved enhancer and promoter sequences to identify potential transcription factor binding sites (TFBS) associated with regulatory conservation across species.

---

## Overview

Motif enrichment was performed on FASTA sequences derived from conserved regulatory elements (enhancers and promoters). These elements:
- Were mapped across species using `halLiftover` and refined with `HALPER`
- Overlapped with tissue-matched ATAC-seq peaks (validated by `bedtools intersect`)
- Were grouped by:
  - **Tissue**: liver, spleen
  - **Mapping direction**: human-to-mouse or mouse-to-human
  - **Regulatory class**: enhancer or promoter
  - **Subset type**: shared or tissue-specific regions

---

## Tools Used
- `bedtools getfasta` for sequence extraction
- `MEME-ChIP` for de novo motif discovery
- `TOMTOM` for motif family annotation
- `FIMO` for scanning motif occurrences

---

## Input
- Validated BED files
- Genome reference FASTA files (hg38 or mm10)

Example:
```bash
bedtools getfasta \
  -fi mm10.fa \
  -bed spleen_mouse_to_human_enhancers.bed \
  -fo spleen_mouse_to_human_enhancers.fa
```

---

## MEME-ChIP Configuration
Run `meme-chip` for de novo motif discovery:
```bash
meme-chip \
  -oc results/motifs/spleen_mouse_to_human \
  -meme-minw 15 -meme-maxw 20 \
  -meme-nmotifs 5 \
  -revcomp \
  -dna \
  spleen_mouse_to_human_enhancers.fa
```

- **Motif width**: 15–20 bp
- **Strand**: reverse complement scanning enabled
- **Background**: automatically estimated

---

## Annotation with TOMTOM
TOMTOM matches discovered motifs to known TFBS from internal motif libraries.
- Matches are ranked by statistical similarity (alignment scores and p-values)
- Useful for inferring transcriptional regulators

TOMTOM is run automatically as part of `meme-chip`.

---

## Motif Scanning with FIMO

After motif discovery, `FIMO` locates exact motif matches within the input FASTA:
```bash
fimo \
  --oc results/motifs/fimo_hits \
  meme_chip_output/meme_out/meme.xml \
  spleen_mouse_to_human_enhancers.fa
```

- **FIMO scores**: log-transformed probabilities of motif presence
- Lower scores = stronger matches

---

## Output Files
- `meme_chip.html`: interactive report of motif results
- `fimo.tsv`: motif match locations and scores
- `tomtom.tsv`: matched known TFs with statistical annotations

---

## Notes
- MEME Suite version used: v5.5.0
- Reverse strand scanning is essential for regulatory sequences
- All parameters used were MEME defaults unless otherwise noted
- Comparative results can be grouped by tissue, direction, and regulatory class
