# Overlap Validation with ATAC-seq Peaks

This step validates conserved regulatory regions by checking whether projected enhancers or promoters overlap with tissue-matched open chromatin regions from ATAC-seq data. This overlap is a proxy for functional conservation.

---

## Tools Required
- `bedtools` (intersect)
- `sort`, `cut`, `wc` (standard UNIX tools)

---

## Input
- BED file of conserved regions (output of HALPER)
- Tissue-matched ATAC-seq peak BED file (same genome as projection target)

---

## Output
- `validated_overlap.bed`: Conserved regions overlapping open chromatin
- `total_regions.txt`: Total number of input regions
- `conserved_regions.txt`: Number of regions validated via ATAC-seq overlap

---

## Step-by-Step Instructions

### Step 1: Clean and Sort BED File
Ensure BED file has only chromosome, start, and end columns and is sorted:
```bash
cut -f1-3 input_raw.bed | sort -k1,1 -k2,2n > input_clean_sorted.bed
```

### Step 2: Validate via Intersection with ATAC-seq
Intersect with tissue-specific ATAC-seq peaks:
```bash
bedtools intersect \
  -a input_clean_sorted.bed \
  -b atac_peaks.bed \
  -u > validated_overlap.bed
```

- `-u` reports only the intervals in `-a` that overlap with `-b`

### Step 3: Calculate Validation Percentage
```bash
wc -l input_clean_sorted.bed > total_regions.txt
wc -l validated_overlap.bed > conserved_regions.txt
```
Then compute:
```bash
echo "scale=2; $(cat conserved_regions.txt | awk '{print $1}') / $(cat total_regions.txt | awk '{print $1}') * 100" | bc
```
This gives the **percent of conserved regions with open chromatin support.**

---

## Notes
- Use tissue-matched ATAC-seq peaks for functional relevance
- Sorting is important for consistent overlap computation
- Use `bedtools intersect -wa -wb` to inspect exact overlaps if needed
