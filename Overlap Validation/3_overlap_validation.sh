#!/bin/bash
# Validate conserved regions with ATAC-seq peaks
bedtools intersect -a filtered_conserved.bed -b atac_mouse_liver.bed -u > validated_enhancers.bed
    