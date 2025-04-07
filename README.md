**Project Title**: Comparative Analysis of Open Chromatin Regions and Regulatory Conservation Across Human and Mouse Tissues

**Team Members:** Harini Sundar, Litian Liang, Meiven Yang, Liyuan Liu

**Course:** 03-713: Bioinformatics Data Integration Practicum - Spring 2025

**Project Overview:**
This project investigates the evolutionary conservation and functional relevance of regulatory elements across human and mouse genomes, specifically focusing on liver and spleen tissues using ATAC-seq data.
We identify orthologous enhancer regions, classify promoters vs enhancers, and validate regulatory activity using ATAC-seq overlap and motif enrichment. The goal is to understand how transcriptional regulation differs or is conserved across species and tissues.

**Workflow Summary:**
The analysis began with ATAC-seq quality control (QC) to evaluate mapping quality, fragment periodicity, TSS enrichment, and duplicate rates. Based on QC results, liver and spleen tissues were selected for both human and mouse. Next, peak regions were identified and filtered using narrowPeak files. These peaks were then annotated using the ChIPseeker package in R, classifying them as promoters, introns, or distal intergenic regions. High-confidence regulatory elements were extracted and saved as enhancers.bed files. To investigate cross-species regulatory conservation, enhancer coordinates were mapped between human and mouse using halLiftover, which required both the enhancer BED files and the genome alignment file mm10.hg38.hal. The raw liftover output was refined using HALPER, which filters for syntenic, high-identity orthologs. The resulting high-confidence conserved enhancer sets were then validated using bedtools intersect, comparing the orthologous regions to ATAC-seq peaks in the target species to confirm chromatin accessibility. Finally, the biologically relevant enhancer sets will be used for functional enrichment analysis using tools like GREAT and g:Profiler, and motif discovery will be performed using tools such as MEME-ChIP and HOMER to explore regulatory sequence patterns


**Tools and Dependecies**: 

**ChIPseeker** - Enhancer/promoter annotation
**halLiftover** - Cross-species coordinate mapping
**HALPER** - Syntenic ortholog filtering
**bedtools** - Peak intersection & validation
**MEME Suite** - Motif enrichment analysis
**HOME**R - Alternate motif analysis
**GREAT / g:Profiler** - GO and pathway enrichment
