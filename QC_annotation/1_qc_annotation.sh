#!/bin/bash
# Quality control and annotation for ATAC-seq data
multiqc .
Rscript chipseeker_annotation.R
    