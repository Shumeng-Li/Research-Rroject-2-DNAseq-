#!/bin/bash
#!/bin/bash
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate gatk_env

set -euo pipefail

# -------- Config --------
SAMPLE_ID="P3"
ALIGN_DIR="/Volumes/TOURO_S/WES-cSCC-Project/aligned"

echo "🔹 Sorting BAM files..."
samtools sort -o "$ALIGN_DIR/${SAMPLE_ID}_Normal.sorted.bam" "$ALIGN_DIR/${SAMPLE_ID}_Normal.bam"
samtools sort -o "$ALIGN_DIR/${SAMPLE_ID}_Tumor.sorted.bam" "$ALIGN_DIR/${SAMPLE_ID}_Tumor.bam"

echo "Marking duplicates for Normal..."
picard MarkDuplicates \
    I="$ALIGN_DIR/${SAMPLE_ID}_Normal.sorted.bam" \
    O="$ALIGN_DIR/${SAMPLE_ID}_Normal.markdup.bam" \
    M="$ALIGN_DIR/${SAMPLE_ID}_Normal.dup_metrics.txt" \
    CREATE_INDEX=true

echo "🔹 Marking duplicates for Tumor..."
picard MarkDuplicates \
    I="$ALIGN_DIR/${SAMPLE_ID}_Tumor.sorted.bam" \
    O="$ALIGN_DIR/${SAMPLE_ID}_Tumor.markdup.bam" \
    M="$ALIGN_DIR/${SAMPLE_ID}_Tumor.dup_metrics.txt" \
    CREATE_INDEX=true

echo "✅ Step 2: MarkDuplicates done!"