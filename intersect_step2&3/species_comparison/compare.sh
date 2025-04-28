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

OUTPUT_DIR="/jet/home/myang17/ocean/projects/bio230007p/myang17/Classify_results/comparison"



# Create the output directory if it doesn't exist

mkdir -p $OUTPUT_DIR



# Perform intersection comparisons using bedtools

# Mouse->Human comparisons

bedtools intersect -a $LIVER_PROJECTED_FILE_MOUSE -b $LIVER_ATAC_HUMAN -wa -u -f 0.25 -r > $OUTPUT_DIR/liver_m2h_open.bed

bedtools intersect -a $LIVER_PROJECTED_FILE_MOUSE -b $LIVER_ATAC_HUMAN -wa -v -f 0.25 -r > $OUTPUT_DIR/liver_m2h_closed.bed



bedtools intersect -a $SPLEEN_PROJECTED_FILE_MOUSE -b $SPLEEN_ATAC_HUMAN -wa -u -f 0.25 -r > $OUTPUT_DIR/spleen_m2h_open.bed

bedtools intersect -a $SPLEEN_PROJECTED_FILE_MOUSE -b $SPLEEN_ATAC_HUMAN -wa -v -f 0.25 -r > $OUTPUT_DIR/spleen_m2h_closed.bed



# Human->Mouse comparisons

bedtools intersect -a $LIVER_PROJECTED_FILE_HUMAN -b $LIVER_ATAC_MOUSE -wa -u -f 0.25 -r > $OUTPUT_DIR/liver_h2m_open.bed

bedtools intersect -a $LIVER_PROJECTED_FILE_HUMAN -b $LIVER_ATAC_MOUSE -wa -v -f 0.25 -r > $OUTPUT_DIR/liver_h2m_closed.bed



bedtools intersect -a $SPLEEN_PROJECTED_FILE_HUMAN -b $SPLEEN_ATAC_MOUSE -wa -u -f 0.25 -r > $OUTPUT_DIR/spleen_h2m_open.bed

bedtools intersect -a $SPLEEN_PROJECTED_FILE_HUMAN -b $SPLEEN_ATAC_MOUSE -wa -v -f 0.25 -r > $OUTPUT_DIR/spleen_h2m_closed.bed



# Remove duplicate entries (if any) in the open and closed region files

# This ensures we are counting unique regions only

sort -u $OUTPUT_DIR/liver_m2h_open.bed -o $OUTPUT_DIR/liver_m2h_open.bed

sort -u $OUTPUT_DIR/spleen_m2h_open.bed -o $OUTPUT_DIR/spleen_m2h_open.bed

sort -u $OUTPUT_DIR/liver_h2m_open.bed -o $OUTPUT_DIR/liver_h2m_open.bed

sort -u $OUTPUT_DIR/spleen_h2m_open.bed -o $OUTPUT_DIR/spleen_h2m_open.bed



sort -u $OUTPUT_DIR/liver_m2h_closed.bed -o $OUTPUT_DIR/liver_m2h_closed.bed

sort -u $OUTPUT_DIR/spleen_m2h_closed.bed -o $OUTPUT_DIR/spleen_m2h_closed.bed

sort -u $OUTPUT_DIR/liver_h2m_closed.bed -o $OUTPUT_DIR/liver_h2m_closed.bed

sort -u $OUTPUT_DIR/spleen_h2m_closed.bed -o $OUTPUT_DIR/spleen_h2m_closed.bed



# Conservation Analysis Summary

{

echo "Conservation Analysis Summary"

echo "==========================="



# Spleen Mouse->Human

echo "Spleen Mouse->Human:"

SPLEEN_M2H_OPEN=$(wc -l < $OUTPUT_DIR/spleen_m2h_open.bed)

SPLEEN_M2H_CLOSED=$(wc -l < $OUTPUT_DIR/spleen_m2h_closed.bed)

SPLEEN_M2H_TOTAL=$((SPLEEN_M2H_OPEN + SPLEEN_M2H_CLOSED))

echo "Open regions conserved: $SPLEEN_M2H_OPEN"

echo "Open regions not conserved: $SPLEEN_M2H_CLOSED"

echo "Proportion conserved: $(bc -l <<< "scale=3; $SPLEEN_M2H_OPEN / $SPLEEN_M2H_TOTAL")"

echo ""



# Spleen Human->Mouse

echo "Spleen Human->Mouse:"

SPLEEN_H2M_OPEN=$(wc -l < $OUTPUT_DIR/spleen_h2m_open.bed)

SPLEEN_H2M_CLOSED=$(wc -l < $OUTPUT_DIR/spleen_h2m_closed.bed)

SPLEEN_H2M_TOTAL=$((SPLEEN_H2M_OPEN + SPLEEN_H2M_CLOSED))

echo "Open regions conserved: $SPLEEN_H2M_OPEN"

echo "Open regions not conserved: $SPLEEN_H2M_CLOSED"

echo "Proportion conserved: $(bc -l <<< "scale=3; $SPLEEN_H2M_OPEN / $SPLEEN_H2M_TOTAL")"

echo ""



# Liver Mouse->Human

echo "Liver Mouse->Human:"

LIVER_M2H_OPEN=$(wc -l < $OUTPUT_DIR/liver_m2h_open.bed)

LIVER_M2H_CLOSED=$(wc -l < $OUTPUT_DIR/liver_m2h_closed.bed)

LIVER_M2H_TOTAL=$((LIVER_M2H_OPEN + LIVER_M2H_CLOSED))

echo "Open regions conserved: $LIVER_M2H_OPEN"

echo "Open regions not conserved: $LIVER_M2H_CLOSED"

echo "Proportion conserved: $(bc -l <<< "scale=3; $LIVER_M2H_OPEN / $LIVER_M2H_TOTAL")"

echo ""



# Liver Human->Mouse

echo "Liver Human->Mouse:"

LIVER_H2M_OPEN=$(wc -l < $OUTPUT_DIR/liver_h2m_open.bed)

LIVER_H2M_CLOSED=$(wc -l < $OUTPUT_DIR/liver_h2m_closed.bed)

LIVER_H2M_TOTAL=$((LIVER_H2M_OPEN + LIVER_H2M_CLOSED))

echo "Open regions conserved: $LIVER_H2M_OPEN"

echo "Open regions not conserved: $LIVER_H2M_CLOSED"

echo "Proportion conserved: $(bc -l <<< "scale=3; $LIVER_H2M_OPEN / $LIVER_H2M_TOTAL")"

echo ""



} > $OUTPUT_DIR/conservation_analysis.txt
