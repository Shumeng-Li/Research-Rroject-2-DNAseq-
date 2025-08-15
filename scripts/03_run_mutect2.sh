##!/bin/bash
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate gatk_env

set -euo pipefail

# Set memory limit for Java
export _JAVA_OPTIONS="-Xmx14g"

# -------- Config --------
SAMPLE_ID="P4"
REF="/Users/afra/.mounty/TOURO_S/genome/GRCh38_GATK/Homo_sapiens_assembly38.fasta"
ALIGN_DIR="/Users/afra/.mounty/TOURO_S/WES-cSCC-Project/aligned"
VARIANT_DIR="/Users/afra/.mounty/TOURO_S/WES-cSCC-Project/variants"
GERMLINE="/Users/afra/.mounty/TOURO_S/genome/GRCh38_GATK/af-only-gnomad.hg38.vcf.gz"
PON="/Users/afra/.mounty/TOURO_S/genome/GRCh38_GATK/1000g_pon.hg38.vcf.gz"

# Run Mutect2
echo "🔹 Running Mutect2..."

gatk Mutect2 \
    -R "$REF" \
    -I "$ALIGN_DIR/${SAMPLE_ID}_Tumor.markdup.bam" \
    -tumor "${SAMPLE_ID}_Tumor" \
    -I "$ALIGN_DIR/${SAMPLE_ID}_Normal.markdup.bam" \
    -normal "${SAMPLE_ID}_Normal" \
    --germline-resource "$GERMLINE" \
    --panel-of-normals "$PON" \
    --native-pair-hmm-threads 8 \
    --f1r2-tar-gz "$VARIANT_DIR/${SAMPLE_ID}.f1r2.tar.gz" \
    -O "$VARIANT_DIR/${SAMPLE_ID}.unfiltered.vcf.gz"

echo "✅ Step 3: Mutect2 done!"