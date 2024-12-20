# BASSAA: R Package Overview

## Description
BASSAA (B27 Ankylosing Spondylitis and Acute Anterior Uveitis Atlas) is a specialized R package designed for exploring pathological signatures in scRNA-seq data. Utilizing the Sparse Decomposition of Arrays (SDA) algorithm, BASSAA offers an intuitive platform for discovering transcriptional signatures, providing biologically and pathologically relevant insights.

This package empowers researchers with tools to visualize immune mechanisms and explore high-dimensional single-cell data to study Ankylosing Spondylitis (AS) and Acute Anterior Uveitis (AAU). Interactive visualization and seamless integration with curated datasets such as Mahyari-Gill enable deep exploration of immune signatures.

## Key Features
- **Sparse Decomposition of Arrays (SDA)** for soft-clustering of transcriptional signatures.
- Interactive visualization tools including UMAP and enriched heatmaps.
- Integration of curated datasets, e.g., Mahyari-Gill and GSE194315.
- Predefined SDA components highlighting key biological pathways and signatures.
- Gene expression analysis and metadata clustering.

## Installation
To install the BASSAA R package, run the following commands in R:

```R
# Install required dependencies
install.packages("devtools")

devtools::install_github("eisascience/BASSAA")
```

## Getting Started
After installation, load the package and access the interactive tools:

```R
library(BASSAA)

# Launch the interactive interface
BASSAA::launch_app()
```

## Usage
BASSAA includes:

- SDA analysis for identifying transcriptional signatures.
- UMAP visualization of cell populations and gene expression.
- Exploration of immune pathway activity driven by IL-17/23, TNF, and IFNg.
- Integrated datasets allowing comparison of HLA-B27 positive and negative subjects with AS and AAU.

### Example Workflow
```R
# Load your dataset
sce <- load_data("path/to/data")

# Run SDA analysis
results <- run_SDA(sce)

# Visualize UMAP for SDA components
plot_UMAP(results, component = "MRI")
```

## Interactive Features
- **Visualization Inputs:** Dimensionality reduction methods (e.g., UMAP), dataset origin, and metadata selection.
- **Cell Selection Inputs:** Filter data based on experimental conditions and major cell types.
- **SDA Components:** Analyze key immunological signatures such as:
  - B-Cell Defect Signature (BCDS)
  - Myeloid Regulation Imbalance (MRI)
  - pDC-Monocyte Differential Signature (PMDS)
  - TNK Cytotoxic Module (TCM)
- **Gene-Level Insights:** Search genes, set expression thresholds, and download gene lists.

## Citation
If you use BASSAA in your research, please cite:

Mahyari, E., et al. (In Review). "Divergent B cell and cytotoxic TNK cell activation signatures in HLA-B27-associated ankylosing spondylitis and acute anterior uveitis."

## Troubleshooting
- **Data Loading Errors:** Ensure selected SDA run is valid.
- **Performance Issues:** Optimize dataset size; the app is designed for curated datasets.
- **Missing Outputs:** Verify threshold settings are within valid ranges.

For further assistance, contact the development team at the Gill Lab or via the package repository.
