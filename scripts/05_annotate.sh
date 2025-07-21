#!/bin/bash
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate vep_env

set -euo pipefail

# -------- Config --------
SAMPLE_ID="P3"
BASE="/Volumes/TOURO_S/WES-cSCC-Project"
VEP_CACHE="/Volumes/TOURO_S/vep_cache"
VEP_DATA="${BASE}/variants"
VEP_OUTPUT="${VEP_DATA}/${SAMPLE_ID}.vep.vcf"
INPUT_VCF="${VEP_DATA}/${SAMPLE_ID}.filtered.vcf.gz"

# -------- Run VEP Annotation --------
echo "🔹 Annotating variants using VEP..."

vep \
  --input_file "$INPUT_VCF" \
  --output_file "$VEP_OUTPUT" \
  --vcf \
  --cache \
  --offline \
  --dir_cache "$VEP_CACHE" \
  --species homo_sapiens \
  --assembly GRCh38 \
  --everything \
  --fork 4 \
  --force_overwrite

echo "✅ Step 5: VEP annotation done!"