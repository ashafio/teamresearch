# R Code Explanation: Restaurant Reviews Analysis

This document provides a step-by-step explanation of the `Analysis.R` script used to investigate whether photographic reviews influence restaurant ratings compared to text-only reviews.

## 1. Setup and Library Management
The script begins by ensuring the necessary R packages are installed and loaded.
- **Robust Installation**: We implemented a custom `install_and_load` function. This function checks if a package is missing, sets a secure download mirror (CRAN), and installs the package into a user-writable directory if the system directory is locked.
- **Key Packages**:
  - `readr`: For fast and accurate reading of the CSV dataset.
  - `dplyr`: For data manipulation (filtering, selecting, mutating).
  - `ggplot2`: For creating high-quality, publication-ready visualizations.
  - `tidyr`: For handling missing values.

## 2. Data Loading and Cleaning
We load the `Restaurant reviews.csv` file and perform several cleaning steps to ensure data integrity:
1.  **Artifact Removal**: We remove column `7514`, which appears to be an artifact from the data collection process.
2.  **Type Conversion**: We ensure `Rating` and `Pictures` are treated as numeric values.
3.  **Handling Missing Values**:
    - `Pictures`: `NA` values are replaced with `0`, assuming that a missing value means no photos were uploaded.
    - `Rating`: Rows with missing ratings are removed as they cannot be used for analysis.
4.  **Categorization**: We create a new variable `ReviewType`:
    - **Photographic Review**: If `Pictures > 0`.
    - **Text-Only Review**: If `Pictures == 0`.

## 3. Visualization
We use `ggplot2` to create two key visualizations to understand the data distribution:
- **Density Plot (`rating_distribution.png`)**: Shows the shape of the rating distribution for both groups. This helps us see if ratings are skewed (e.g., mostly 5 stars).
- **Boxplot (`rating_boxplot.png`)**: Displays the median, quartiles, and outliers. We also overlay the **mean** (represented by a diamond) to visually compare the central tendency of both groups.

## 4. Statistical Analysis
To answer the research question *"Is there a difference in mean rating between restaurants that received photographic reviews and those that received only text-based reviews?"*, we perform a **Welch's Two Sample t-test**.
- **Why Welch's t-test?**: This test is robust and does not assume that the two groups have equal variances (spread), which is often the case in real-world data.
- **Hypotheses**:
  - $H_0$: There is no difference in mean ratings.
  - $H_1$: There is a significant difference in mean ratings.

## 5. Output Generation
The script automatically saves all results to ensure reproducibility:
- **Statistical Results**: The t-test output, group means, and standard deviations are saved to `analysis_results.txt`.
- **Plots**: The visualizations are saved as high-resolution PNG files.

## How to Run
1. Open `Analysis.R` in RStudio.
2. Click the **Source** button or press `Ctrl + Shift + S`.
3. Check the project folder for the generated files: `analysis_results.txt`, `rating_distribution.png`, and `rating_boxplot.png`.
