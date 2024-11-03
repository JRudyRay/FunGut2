#!/bin/bash

#SBATCH --job-name=qiime_classification     # Job name
#SBATCH --output=qiime_classification.out   # Standard output log
#SBATCH --error=qiime_classification.err    # Standard error log
#SBATCH --time=48:00:00                     # Maximum run time (hh:mm:ss)
#SBATCH --ntasks=1                          # Number of tasks (set to 1 for serial jobs)
#SBATCH --cpus-per-task=1                   # Number of CPU cores per task
#SBATCH --mem-per-cpu=128G                  # Total memory allocation

# Activate qiime2 environment
source ~/.bashrc
conda activate qiime2-amplicon-2024.5-second-try

# Define path variables
CLASSIFIER="./unite_ver10_dynamic_s_all_04.04.2024-Q2-2024.5.qza"
READS="./rep-seqs.qza"
OUTPUT="./taxonomy_unite_dynamic_s_all.qza"

# Check if classifier file exists
if [ ! -f "$CLASSIFIER" ]; then
    echo "Classifier file not found: $CLASSIFIER"
    exit 1
fi

# Check if reads file exists
if [ ! -f "$READS" ]; then
    echo "Reads file not found: $READS"
    exit 1
fi

# Run the qiime command
qiime feature-classifier classify-sklearn \
  --i-classifier "$CLASSIFIER" \
  --i-reads "$READS" \
  --p-reads-per-batch 1000 \
  --o-classification "$OUTPUT"

# Check if the output was successfully generated
if [ -f "$OUTPUT" ]; then
    echo "Classification completed successfully. Output saved to: $OUTPUT"
else
    echo "Failed to generate output."
    exit 1
fi
