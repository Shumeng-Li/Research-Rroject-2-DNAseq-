#!/bin/bash
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate gatk_env

set -euo pipefail

# -------- Config --------
SAMPLE_ID="P3"
BASE="/Volumes/TOURO_S/WES-cSCC-Project"
REF="/Volumes/TOURO_S/genome/GRCh38_GATK/Homo_sapiens_assembly38.fasta"

VARIANT_DIR="$BASE/variants"


# -------- Learn Read Orientation Model --------
echo "🔹 Learning Read Orientation Model..."

gatk --java-options "-Xmx8g" LearnReadOrientationModel \
  -I "$VARIANT_DIR/${SAMPLE_ID}.f1r2.tar.gz" \
  -O "$VARIANT_DIR/${SAMPLE_ID}.read-orientation-model.tar.gz"


# -------- Filter Mutect Calls --------
echo "🔹 Filtering Mutect2 Calls..."

gatk --java-options "-Xmx8g" FilterMutectCalls \
  -V "$VARIANT_DIR/${SAMPLE_ID}.unfiltered.vcf.gz" \
  -R "$REF" \
  --ob-priors "$VARIANT_DIR/${SAMPLE_ID}.read-orientation-model.tar.gz" \
  -O "$VARIANT_DIR/${SAMPLE_ID}.filtered.vcf.gz"

echo "✅ Step 4: Filtering done!"