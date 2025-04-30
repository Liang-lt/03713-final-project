# HALPER Ortholog Mapping Pipeline

This module maps enhancer regions from one species to another using the **HAL (Hierarchical Alignment Format)** and refines the results using **HALPER**, a post-processing tool for improving liftover projections.

---

## Tools Required
- `halLiftover` (part of HAL tools)
- `halper.py` (https://github.com/bxlab/halper)
- Reference genome FASTA for the target species (e.g., mm10.fa, hg38.fa)
- Whole-genome HAL file (e.g., mammal.hal)

---

## Input
- Source enhancer BED file (e.g., `liver_human_enhancers.bed`)
- Whole genome alignment in HAL format
- Target species genome FASTA file

---

## Output
- `raw_liftover.bed`: Unfiltered projection from halLiftover
- `halper_filtered.bed`: Refined orthologous enhancer regions

---

## Step-by-Step Usage

### Step 1: Liftover Using halLiftover
Convert enhancer coordinates from source to target genome:
```bash
halLiftover \
  mammal.hal \
  source_genome \
  source_enhancers.bed \
  target_genome \
  raw_liftover.bed
```

### Step 2: Filter with HALPER
Refine the raw liftover output into orthologous enhancer regions:
```bash
halper.py \
  -b raw_liftover.bed \
  -s target_genome \
  -q source_genome \
  -o halper_filtered.bed \
  -g target_genome.fa
```

---

## Example: Human → Mouse (Liver Enhancers)
```bash
halLiftover \
  mammal.hal \
  hg38 \
  liver_human_enhancers.bed \
  mm10 \
  liver_human_to_mouse_liftover_raw.bed

halper.py \
  -b liver_human_to_mouse_liftover_raw.bed \
  -s mm10 \
  -q hg38 \
  -o liver_human_to_mouse_enhancers.bed \
  -g mm10.fa
```

## Example: Mouse → Human (Spleen Enhancers)
```bash
halLiftover \
  mammal.hal \
  mm10 \
  spleen_mouse_enhancers.bed \
  hg38 \
  spleen_mouse_to_human_liftover_raw.bed

halper.py \
  -b spleen_mouse_to_human_liftover_raw.bed \
  -s hg38 \
  -q mm10 \
  -o spleen_mouse_to_human_enhancers.bed \
  -g hg38.fa
```

---

## Notes
- `halLiftover` may project regions outside chromosome bounds; HALPER removes invalid or low-confidence mappings
- Always verify HALPER output using downstream validation (e.g., ATAC-seq overlap)
- HALPER requires genome FASTA with matching chromosome names as HAL alignment
