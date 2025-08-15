#!/bin/bash
# Activate conda environment
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate gatk_env

set -euo pipefail

# -------- Config --------
SAMPLE_ID="P10"
RAW_DIR="/Users/afra/.mounty/TOURO_S/WES-cSCC-Project/raw_data"
REF="/Users/afra/.mounty/TOURO_S/genome/GRCh38_GATK/Homo_sapiens_assembly38.fasta"
ALIGN_DIR="/Users/afra/.mounty/TOURO_S/WES-cSCC-Project/aligned"

mkdir -p "$ALIGN_DIR"

# Read group ID
RG_ID="${SAMPLE_ID}.RG"

echo "🔹 Aligning Normal sample..."
bwa mem -M -t 4 -R "@RG\tID:${RG_ID}.N\tSM:${SAMPLE_ID}_Normal\tPL:ILLUMINA" \
    "$REF" \
    "$RAW_DIR/${SAMPLE_ID}_Normal_1.fastq.gz" \
    "$RAW_DIR/${SAMPLE_ID}_Normal_2.fastq.gz" | \
    samtools view -bS - > "$ALIGN_DIR/${SAMPLE_ID}_Normal.bam"

echo "🔹 Aligning Tumor sample..."
bwa mem -M -t 4 -R "@RG\tID:${RG_ID}.T\tSM:${SAMPLE_ID}_Tumor\tPL:ILLUMINA" \
    "$REF" \
    "$RAW_DIR/${SAMPLE_ID}_Tumor_1.fastq.gz" \
    "$RAW_DIR/${SAMPLE_ID}_Tumor_2.fastq.gz" | \
    samtools view -bS - > "$ALIGN_DIR/${SAMPLE_ID}_Tumor.bam"
    
echo "✅ Step 1: Alignment done!"