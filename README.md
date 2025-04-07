**Project Title**: Comparative Analysis of Open Chromatin Regions and Regulatory Conservation Across Human and Mouse Tissues
**Team Members:** Harini Sundar, Litian Liang, Meiven Yang, Liyuan Liu

**Course:** 03-713: Bioinformatics Data Integration Practicum - Spring 2025

**Project Overview:**
This project investigates the evolutionary conservation and functional relevance of regulatory elements across human and mouse genomes, specifically focusing on liver and spleen tissues using ATAC-seq data.
We identify orthologous enhancer regions, classify promoters vs enhancers, and validate regulatory activity using ATAC-seq overlap and motif enrichment. The goal is to understand how transcriptional regulation differs or is conserved across species and tissues.

**Workflow Summary:**
[ATAC-seq QC] 
    ↓
[Peak Calling + Filtering]
    ↓
[ChIPseeker Annotation → enhancers.bed]
    ↓
[halLiftover] ← mm10.hg38.hal + enhancers.bed
    ↓
[HALPER Filtering] → high-confidence orthologs
    ↓
[ATAC-seq Validation via bedtools intersect]
    ↓
[Functional Annotation (GREAT, gProfiler)]
    ↓
[Motif Discovery (MEME-ChIP, HOMER)]


**Directory Structure:**
/atac_project/
    ├── data/
    │   ├── human_liver.bed
    │   ├── mouse_spleen.bed
    │   └── ...
    ├── annotation/
    │   ├── enhancers.bed
    │   ├── annotation_pie_chart.pdf
    ├── liftover/
    │   ├── lifted_human_to_mouse.bed
    │   └── halper_filtered.bed
    ├── validation/
    │   ├── validated_output.bed
    ├── motif_discovery/
    │   ├── meme_out/
    │   └── homer_out/
    └── results/
        ├── summary_plots/
        └── final_tables/
