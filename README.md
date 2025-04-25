**Project Title**: Comparative Analysis of Open Chromatin Regions and Regulatory Conservation Across Human and Mouse Tissues

**Team Members:** Harini Sundar, Litian Liang, Meiven Yang, Liyuan Liu

**Course:** 03-713: Bioinformatics Data Integration Practicum - Spring 2025

---

## Project Overview
This project investigates the evolutionary conservation and functional relevance of regulatory elements across human and mouse genomes, specifically focusing on liver and spleen tissues using ATAC-seq data. We identify orthologous enhancer regions, classify promoters vs enhancers, validate regulatory activity via ATAC-seq peak overlap, and uncover regulatory sequence motifs and biological pathways.

---

## Dependencies
To reproduce our pipeline, the following tools and packages are required:

### System Tools
- `bedtools` ≥ v2.29
- `halLiftover` (HAL Tools)
- `hal2maf`, `maf2bed`, `hal2fasta` (optional)
- `MEME Suite` ≥ v5.4.1 (meme-chip, fimo, streme)
- `Python` ≥ 3.6 with `halper.py`
- `R` ≥ 4.0 with:
  - `ChIPseeker`
  - `TxDb.Hsapiens.UCSC.hg38.knownGene`
  - `org.Hs.eg.db`
- `GREAT` (web interface; optional: `rGREAT`)

### Genome Assemblies
- Human: `hg38.fa`
- Mouse: `mm10.fa`
- Whole-genome alignment: `mm10.hg38.hal`

---

## Inputs
| File | Description |
|------|-------------|
| `*_enhancers.bed` | Enhancer regions annotated from ATAC-seq peaks |
| `*_promoters.bed` | Promoter regions from annotation |
| `*.hal` | Whole-genome alignment between species |
| `*.fa` | Genome reference FASTA for hg38/mm10 |
| `*_peaks.narrowPeak` | Raw ATAC-seq peak calls |

## Outputs
| Output | Description |
|--------|-------------|
| `*_centered.fa` | 200 bp FASTA for motif discovery |
| `meme_out*/` | MEME/STREME/FIMO results |
| `*_conserved.filtered.bed` | High-confidence orthologs from HALPER |
| `*_intersect.bed` | Regions validated via ATAC-seq overlap |
| `*.html` | Genome browser or MEME visual outputs |
| `GREAT_results/` | Functional enrichment GO terms |

---

## Usage (One-line Instructions)

1. **Enhancer Annotation** (ChIPseeker in R)
```r
annotatePeak("*.narrowPeak", TxDb=txdb, annoDb="org.Hs.eg.db")
```

2. **Cross-Species Liftover**
```bash
halLiftover mm10.hg38.hal mm10 input.bed hg38 output_liftover.bed
```

3. **HALPER Filtering**
```bash
python halper.py -b output_liftover.bed -g hg38 -o output_filtered.bed
```

4. **FASTA Extraction**
```bash
bedtools getfasta -fi genome.fa -bed input_centered.bed -fo output.fa
```

5. **Motif Discovery**
```bash
meme-chip -oc output_dir -dna -maxw 20 -meme-nmotifs 10 input.fa
```

6. **Functional Enrichment (GREAT)**
Upload `.bed` regions via [great.stanford.edu](http://great.stanford.edu/) and retrieve GO/phenotype enrichments.

---

## Citations
- Cory Y McLean, Dave Bristor, Michael Hiller, Shoa L Clarke, Bruce T Schaar, Craig B Lowe, Aaron M Wenger, and Gill Bejerano. "GREAT improves functional interpretation of cis-regulatory regions". Nat. Biotechnol. 28(5):495-501, 2010. PMID 20436461
- Zhang et al., 2008. MACS: ChIP-Seq analysis. *Genome Biol.*
- HAL Tools & HALPER: Comparative Genomics Toolkit (GitHub)

---

## Authors & Contact
- Harini Sundar — hsundar@andrew.cmu.edu
- Litian Liang -- litianl@andrew.cmu.edu
- Meiven Yang -- meiveny@andrew.cmu.edu
- Liyuan Liu -- liyuanli@andrew.cmu.edu
