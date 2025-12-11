# R Code Explanation: Service Mentions Analysis
**Prepared by: Abdul Rehman**

This document explains the logic behind the `Analysis.R` script, which investigates the relationship between service-related keywords in reviews and the resulting star ratings.

## 1. Setup and Library Management
- **Objective**: Ensure a reproducible environment.
- **Action**: The script checks for necessary packages (`tidyverse`, `lubridate`, `effsize`) and installs them into a local user library if they are missing. This prevents permission errors on university or shared computers.

## 2. Data Loading and Preprocessing
- **Data Source**: `Restaurant reviews.csv`
- **Cleaning Steps**:
    1.  **Type Conversion**: `Rating` is converted to numeric, and `Time` is parsed into a proper date-time format using `lubridate`.
    2.  **Text Normalization**: All reviews are converted to lowercase (`review_lower`) to ensure case-insensitive matching.
    3.  **Keyword Flagging**: We use `str_detect` to create a binary variable `mentions_service`. This is `TRUE` if the review contains words like "service", "staff", "waiter", "polite", "rude", etc.
    4.  **Ambience Flagging**: Similarly, we create `mentions_ambience` to check for words like "atmosphere", "decor", or "music".

## 3. Statistical Analysis
We employ two main statistical tests to validate our hypotheses:

### 3.1. Welch's Two-Sample t-test
- **Purpose**: To compare the **mean rating** of reviews that mention service vs. those that do not.
- **Why Welch's?**: It does not assume equal variance between the two groups, making it more robust for unequal sample sizes.
- **Effect Size**: We calculate **Cohen's d** to quantify the magnitude of the difference (Small/Medium/Large).

### 3.2. Chi-Squared Test
- **Purpose**: To compare the **proportion of 5-star ratings** between the two groups.
- **Logic**: We create a contingency table (Service Mention vs. 5-Star) and test if the variables are independent.

## 4. Visualization
The script generates two key figures:
1.  **`mean_rating_by_service.png`**: A bar chart showing the mean rating for both groups with 95% confidence intervals. This visually confirms if the difference is significant.
2.  **`histogram_ratings_overlay.png`**: A histogram of all ratings with a normal distribution curve overlaid, showing the overall data skewness.

## 5. Output
- All statistical results (t-statistic, p-values, group means) are automatically saved to `analysis_results.txt`.
- This ensures that the numbers reported in the final document are accurate and directly from the code.
