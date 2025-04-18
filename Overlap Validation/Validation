# === CLEANING ===
# Filter valid BED lines with exactly 3 columns and positive coordinates
awk 'NF>=3 && $2 >= 0 && $3 > $2' $HALPER_BED | cut -f1-3 | sort -k1,1 -k2,2n | uniq > $CLEANED_BED

# === VALIDATION ===
# Use bedtools to find intersecting regions
bedtools intersect -a $CLEANED_BED -b $ATAC_PEAKS -u > $VALIDATED_OUTPUT

# === SUMMARY STATS ===
TOTAL=$(wc -l < $CLEANED_BED)
OVERLAP=$(wc -l < $VALIDATED_OUTPUT)
PERCENT=$(awk -v a=$OVERLAP -v b=$TOTAL 'BEGIN { printf "%.2f", (a/b)*100 }')
echo "Total regions: $TOTAL" > $OVERLAP_STATS
echo "Validated overlap: $OVERLAP" >> $OVERLAP_STATS
echo "Percent overlap: $PERCENT%" >> $OVERLAP_STATS

# === DONE ===
echo "Validation complete. Overlap: $PERCENT%"
