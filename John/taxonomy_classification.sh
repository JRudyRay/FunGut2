#!/bin/bash

#SBATCH --job-name=qiime_classification     # Job name
#SBATCH --output=qiime_classification.out   # Standard output log
#SBATCH --error=qiime_classification.err    # Standard error log
#SBATCH --time=24:00:00                     # Maximum run time (hh:mm:ss)
#SBATCH --ntasks=1                          # Number of tasks (set to 1 for serial jobs)
#SBATCH --cpus-per-task=2                   # Number of CPU cores per task
#SBATCH --mem-per-cpu=64G                   # Total memory allocation

# Load the appropriate environment and activate conda
source ~/.bashrc                            # Make sure to source your bashrc to initialize conda
conda activate qiime2-amplicon-2024.5        # Activate the QIIME2 conda environment

# Define variables
CLASSIFIER="./unite_ver10_99_all_04.04.2024-Q2-2024.5.qza"
READS="./rep-seqs.qza"
OUTPUT="./taxonomy.qza"

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
  --p-reads-per-batch 1 \
  --p-n-jobs 0 \
  --o-classification "$OUTPUT"

# Check if the output was successfully generated
if [ -f "$OUTPUT" ]; then
    echo "Classification completed successfully. Output saved to: $OUTPUT"
else
    echo "Failed to generate output."
    exit 1
fi
