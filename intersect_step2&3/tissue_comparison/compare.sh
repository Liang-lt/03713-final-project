#!/bin/bash



#SBATCH -p RM-shared

#SBATCH -t 24:00:00

#SBATCH --ntasks-per-node=4



# Load necessary modules (e.g., bedtools)

module load bedtools



# Define paths to your files (replace ~ with the absolute path)

LIVER_PROJECTED_FILE_HUMAN="/jet/home/myang17/ocean/projects/bio230007p/myang17/Halper_out/halper_result_human2mouse_liver/idr.optimal_peak_liver_human.HumanToMouse.HALPER.narrowPeak"

SPLEEN_PROJECTED_FILE_HUMAN="/jet/home/myang17/ocean/projects/bio230007p/myang17/Halper_out/halper_result_human2mouse_spleen/idr.optimal_peak_spleen_human.HumanToMouse.HALPER.narrowPeak"

LIVER_ATAC_HUMAN="/jet/home/myang17/ocean/projects/bio230007p/myang17/MouseATACpeaks/liver/idr.optimal_peak.narrowPeak"

SPLEEN_ATAC_HUMAN="/jet/home/myang17/ocean/projects/bio230007p/myang17/MouseATACpeaks/spleen/idr.optimal_peak.narrowPeak"



LIVER_PROJECTED_FILE_MOUSE="/jet/home/myang17/ocean/projects/bio230007p/myang17/Halper_out/halper_result_mouse2human_liver/idr.optimal_peak_liver_mouse.MouseToHuman.HALPER.narrowPeak"

SPLEEN_PROJECTED_FILE_MOUSE="/jet/home/myang17/ocean/projects/bio230007p/myang17/Halper_out/halper_result_mouse2human_spleen/idr.optimal_peak_spleen_mouse.MouseToHuman.HALPER.narrowPeak"

LIVER_ATAC_MOUSE="/jet/home/myang17/ocean/projects/bio230007p/myang17/HumanATACpeaks/liver/idr.optimal_peak.narrowPeak"

SPLEEN_ATAC_MOUSE="/jet/home/myang17/ocean/projects/bio230007p/myang17/HumanATACpeaks/spleen/idr.optimal_peak.narrowPeak"



# Define the output directory

OUTPUT_DIR="/jet/home/myang17/ocean/projects/bio230007p/myang17/Classify_results/comparison_analysis"



# Create the output directory if it doesn't exist

mkdir -p $OUTPUT_DIR



# Step 1: Intersect with Liver ATAC peaks for human

bedtools intersect -u -a $LIVER_PROJECTED_FILE_HUMAN -b $LIVER_ATAC_HUMAN | sort -u > $OUTPUT_DIR/human_active_in_liver.bed



# Step 2: Intersect with Spleen ATAC peaks for human

bedtools intersect -u -a $SPLEEN_PROJECTED_FILE_HUMAN -b $SPLEEN_ATAC_HUMAN | sort -u > $OUTPUT_DIR/human_active_in_spleen.bed



# Step 3: Find shared regions (active in both liver and spleen) for human

bedtools intersect -u -a $OUTPUT_DIR/human_active_in_liver.bed -b $OUTPUT_DIR/human_active_in_spleen.bed | sort -u > $OUTPUT_DIR/human_shared_regions.bed



# Step 4: Find liver-specific regions (active only in liver) for human

bedtools subtract -a $OUTPUT_DIR/human_active_in_liver.bed -b $OUTPUT_DIR/human_active_in_spleen.bed | sort -u > $OUTPUT_DIR/human_liver_specific.bed



# Step 5: Find spleen-specific regions (active only in spleen) for human

bedtools subtract -a $OUTPUT_DIR/human_active_in_spleen.bed -b $OUTPUT_DIR/human_active_in_liver.bed | sort -u > $OUTPUT_DIR/human_spleen_specific.bed



# Step 6: Intersect with Liver ATAC peaks for mouse

bedtools intersect -u -a $LIVER_PROJECTED_FILE_MOUSE -b $LIVER_ATAC_MOUSE | sort -u > $OUTPUT_DIR/mouse_active_in_liver.bed



# Step 7: Intersect with Spleen ATAC peaks for mouse

bedtools intersect -u -a $SPLEEN_PROJECTED_FILE_MOUSE -b $SPLEEN_ATAC_MOUSE | sort -u > $OUTPUT_DIR/mouse_active_in_spleen.bed



# Step 8: Find shared regions (active in both liver and spleen) for mouse

bedtools intersect -u -a $OUTPUT_DIR/mouse_active_in_liver.bed -b $OUTPUT_DIR/mouse_active_in_spleen.bed | sort -u > $OUTPUT_DIR/mouse_shared_regions.bed



# Step 9: Find liver-specific regions (active only in liver) for mouse

bedtools subtract -a $OUTPUT_DIR/mouse_active_in_liver.bed -b $OUTPUT_DIR/mouse_active_in_spleen.bed | sort -u > $OUTPUT_DIR/mouse_liver_specific.bed



# Step 10: Find spleen-specific regions (active only in spleen) for mouse

bedtools subtract -a $OUTPUT_DIR/mouse_active_in_spleen.bed -b $OUTPUT_DIR/mouse_active_in_liver.bed | sort -u > $OUTPUT_DIR/mouse_spleen_specific.bed



# Write summary to file

{

    # Calculate totals for percentages (Human)

    HUMAN_SHARED=$(wc -l < $OUTPUT_DIR/human_shared_regions.bed)

    HUMAN_LIVER=$(wc -l < $OUTPUT_DIR/human_liver_specific.bed)

    HUMAN_SPLEEN=$(wc -l < $OUTPUT_DIR/human_spleen_specific.bed)

    HUMAN_TOTAL=$((HUMAN_SHARED + HUMAN_LIVER + HUMAN_SPLEEN))



    # Calculate totals for percentages (Mouse)

    MOUSE_SHARED=$(wc -l < $OUTPUT_DIR/mouse_shared_regions.bed)

    MOUSE_LIVER=$(wc -l < $OUTPUT_DIR/mouse_liver_specific.bed) 

    MOUSE_SPLEEN=$(wc -l < $OUTPUT_DIR/mouse_spleen_specific.bed)

    MOUSE_TOTAL=$((MOUSE_SHARED + MOUSE_LIVER + MOUSE_SPLEEN))



    # Write combined analysis

    echo "Combined Tissue Comparison Analysis"

    echo "================================="

    echo "Raw Counts:"

    echo "-----------"

    echo "Human Analysis:"

    echo "Shared regions: $HUMAN_SHARED"

    echo "Liver-specific: $HUMAN_LIVER" 

    echo "Spleen-specific: $HUMAN_SPLEEN"

    echo "Total: $HUMAN_TOTAL"

    echo ""

    echo "Mouse Analysis:"

    echo "Shared regions: $MOUSE_SHARED"

    echo "Liver-specific: $MOUSE_LIVER"

    echo "Spleen-specific: $MOUSE_SPLEEN" 

    echo "Total: $MOUSE_TOTAL"

    echo ""

    echo "Proportions:"

    echo "-----------"

    echo "Human Proportions:"

    echo "Shared: $(awk "BEGIN {printf \"%.3f\", $HUMAN_SHARED/$HUMAN_TOTAL}")"

    echo "Liver-specific: $(awk "BEGIN {printf \"%.3f\", $HUMAN_LIVER/$HUMAN_TOTAL}")"

    echo "Spleen-specific: $(awk "BEGIN {printf \"%.3f\", $HUMAN_SPLEEN/$HUMAN_TOTAL}")"

    echo ""

    echo "Mouse Proportions:"

    echo "Shared: $(awk "BEGIN {printf \"%.3f\", $MOUSE_SHARED/$MOUSE_TOTAL}")"

    echo "Liver-specific: $(awk "BEGIN {printf \"%.3f\", $MOUSE_LIVER/$MOUSE_TOTAL}")"

    echo "Spleen-specific: $(awk "BEGIN {printf \"%.3f\", $MOUSE_SPLEEN/$MOUSE_TOTAL}")"

} > $OUTPUT_DIR/combined_analysis.txt



# Write main summary

echo "Tissue Comparison Analysis Summary" | tee $OUTPUT_DIR/tissue_comparison.txt

echo "================================" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Human Tissue Comparison:" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Regions open in both liver and spleen: $HUMAN_SHARED ($(awk "BEGIN {printf \"%.1f%%\", $HUMAN_SHARED*100/$HUMAN_TOTAL}"))" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Liver-specific open regions: $HUMAN_LIVER ($(awk "BEGIN {printf \"%.1f%%\", $HUMAN_LIVER*100/$HUMAN_TOTAL}"))" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Spleen-specific open regions: $HUMAN_SPLEEN ($(awk "BEGIN {printf \"%.1f%%\", $HUMAN_SPLEEN*100/$HUMAN_TOTAL}"))" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Total regions: $HUMAN_TOTAL" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Mouse Tissue Comparison:" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Regions open in both liver and spleen: $MOUSE_SHARED ($(awk "BEGIN {printf \"%.1f%%\", $MOUSE_SHARED*100/$MOUSE_TOTAL}"))" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Liver-specific open regions: $MOUSE_LIVER ($(awk "BEGIN {printf \"%.1f%%\", $MOUSE_LIVER*100/$MOUSE_TOTAL}"))" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Spleen-specific open regions: $MOUSE_SPLEEN ($(awk "BEGIN {printf \"%.1f%%\", $MOUSE_SPLEEN*100/$MOUSE_TOTAL}"))" | tee -a $OUTPUT_DIR/tissue_comparison.txt

echo "Total regions: $MOUSE_TOTAL" | tee -a $OUTPUT_DIR/tissue_comparison.txt
