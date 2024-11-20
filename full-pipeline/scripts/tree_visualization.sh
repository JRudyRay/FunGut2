#!/bin/bash

#SBATCH --job-name=qiime_tree_viz        # Job name
#SBATCH --output=qiime_tree_viz.out      # Standard output log
#SBATCH --error=qiime_tree_viz.err       # Standard error log
#SBATCH --time=48:00:00                  # Maximum run time (hh:mm:ss)
#SBATCH --ntasks=1                       # Number of tasks (set to 1 for serial jobs)
#SBATCH --cpus-per-task=1                # Number of CPU cores per task
#SBATCH --mem-per-cpu=32G                # Total memory allocation

# Load the QIIME 2 module
source ~/.bashrc
conda activate qiime2-amplicon-2024.5-second-try

# Define variables
TREE="./fast-tree-rooted.qza"
TAXONOMY="./taxonomy_unite_dynamic_s_all.qza"
OUTPUT_VIS="./fast-tree-rooted.qzv"

# Check if tree file exists
if [ ! -f "$TREE" ]; then
    echo "Rooted tree file not found: $TREE"
    exit 1
fi

# Check if taxonomy file exists
if [ ! -f "$TAXONOMY" ]; then
    echo "Taxonomy file not found: $TAXONOMY"
    exit 1
fi

echo "Creating a tree visualization using Empress..."

# Run the qiime empress tree-plot command
qiime empress tree-plot \
    --i-tree "$TREE" \
    --m-feature-metadata-file "$TAXONOMY" \
    --o-visualization "$OUTPUT_VIS"

# Check if the visualization was successfully generated
if [ -f "$OUTPUT_VIS" ]; then
    echo "Tree visualization completed successfully. Output saved to: $OUTPUT_VIS"
else
    echo "Failed to generate the tree visualization."
    exit 1
fi
