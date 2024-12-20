# BASSAA Version History

## V0.4 (Current)

This third major deployment marks a significant enhancement in BASSAA's capabilities. The integration of the Mahyari-Gill dataset with the externally downloaded GSE194315 dataset enables robust validation of our findings. Key features and improvements in V0.4 include:

- **Integration of GSE194315 Data**: This dataset provides external validation for the SDA-derived signatures, strengthening the generalizability of our findings across diverse cohorts.
- **Enhanced SDA Analysis**:
  - The SDA components highlight critical immunophenotypic differences between AS, AAU, and healthy controls.
  - New insights into Myeloid Regulation Imbalance (MRI), B-Cell Defect Signature (BCDS), and TNK Cytotoxic Module (TCM).
  - Comprehensive bi-directional analysis of gene loadings, revealing distinct biological processes in positive and negative directions for each component.
- **Improved Visualization**:
  - Precomputed rPCA-integrated UMAP serves as a unified 2D space for all visualizations, ensuring consistency and interpretability.
  - Enrichment heatmaps with chi-squared test scaling (asinh transformed residuals) for better representation of cell enrichment patterns.
- **Dataset Details**:
  - Mahyari-Gill: A curated dataset with HLA-B27 stratification and detailed immunophenotypes.
  - GSE194315: A validation dataset lacking HLA-B27 expression but essential for cross-validation.
- **User Manual**:
  - Comprehensive guidance with updated sections on SDA components, bi-directional analysis, and detailed outputs.

This version underscores the platform's commitment to providing an interactive and scientifically rigorous tool for exploring immunophenotypic differences in AS and AAU.

## V0.3

The second major deployment introduced:

- **Reduced Cell Number Models**:
  - Multiple SDA models were developed to improve computational efficiency and focus on key cell subsets.
- **Extended Analysis Features**:
  - Expanded visualization options to explore multiple components simultaneously.
- **Stability and Performance**:
  - Significant backend optimizations for faster data loading and processing.

## V0.2

This update focused on:

- **New Figures**:
  - Enhanced visualizations for key SDA components and cell clusters.
- **Cosmetic Updates**:
  - Improved layout and design for better usability and aesthetics.

## V0.1

The initial deployment laid the foundation for BASSAA with:

- **Base Platform**:
  - A single SDA model applied to a reduced cell number dataset.
- **Key Features**:
  - Initial visualization tools for exploring SDA-derived signatures.
  - Proof-of-concept deployment demonstrating the utility of the platform for AS and AAU research.
