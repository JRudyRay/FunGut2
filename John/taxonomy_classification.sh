#!/bin/bash







# Define variables
CLASSIFIER="./data/classifiers/unite_ver10_99_04.04.2024-Q2-2024.5.qza"
READS="./data/rep-seqs.qza"
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
  --p-reads-per-batch 10 \
  --p-n-jobs 0 \
  --o-classification "$OUTPUT"

# Check if the output was successfully generated
if [ -f "$OUTPUT" ]; then
    echo "Classification completed successfully. Output saved to: $OUTPUT"
else
    echo "Failed to generate output."
    exit 1
fi
