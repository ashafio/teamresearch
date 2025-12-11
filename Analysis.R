# --- 0. Setup & Package Installation ---
# Set CRAN mirror
r <- getOption("repos")
r["CRAN"] <- "https://cloud.r-project.org/"
options(repos = r)

# Increase download timeout to avoid failures on slow connections
options(timeout = 300) 

# Function to install and load packages safely
install_and_load <- function(package) {
  if (!require(package, character.only = TRUE)) {
    cat(paste0("\nInstalling missing package: ", package, "...\n"))
    
    # Determine a writable library path
    lib_dir <- Sys.getenv("R_LIBS_USER")
    if (nchar(lib_dir) == 0) {
       lib_dir <- file.path(Sys.getenv("USERPROFILE"), "Documents", "R", "win-library", paste0(R.version$major, ".", R.version$minor))
    }
    
    if (!dir.exists(lib_dir)) {
      dir.create(lib_dir, recursive = TRUE, showWarnings = FALSE)
    }
    
    # Install the package
    tryCatch({
      install.packages(package, lib = lib_dir, dependencies = TRUE)
      library(package, lib.loc = lib_dir, character.only = TRUE)
    }, error = function(e) {
      cat(paste0("\nError installing ", package, ": ", e$message, "\n"))
    })
  } else {
    cat(paste0("\nPackage '", package, "' is already installed and loaded.\n"))
  }
}

# Install specific packages individually to avoid massive download failures
# We need readr for reading data, dplyr for manipulation, ggplot2 for plotting
install_and_load("readr")
install_and_load("dplyr")
install_and_load("ggplot2")
install_and_load("tidyr") # For replace_na



# --- 1. Data Loading ---
# Read the dataset
# We use read_csv for better performance and type inference
# Suppress column type messages for cleaner output
df <- read_csv("Restaurant reviews.csv", show_col_types = FALSE)

# --- 2. Data Cleaning & Preprocessing ---
# Remove the weird column '7514' if it exists (artifact from scraping/saving)
if("7514" %in% names(df)) {
  df <- df %>% select(-`7514`)
}

# Clean and transform data
clean_df <- df %>%
  # Convert columns to numeric, handling potential parsing errors
  mutate(
    Rating = as.numeric(Rating),
    Pictures = as.numeric(Pictures)
  ) %>%
  # Handle missing values
  mutate(
    Pictures = replace_na(Pictures, 0) # Assume NA pictures means 0
  ) %>%
  # Filter out invalid ratings if any (e.g., NA ratings)
  filter(!is.na(Rating)) %>%
  # Create a categorical variable for the analysis
  mutate(
    ReviewType = if_else(Pictures > 0, "Photographic Review", "Text-Only Review")
  )

# Summary of the cleaned data
cat("Data Summary:\n")
print(table(clean_df$ReviewType))

# --- 3. Visualization ---
# Set a custom theme for "super human" aesthetics
custom_theme <- theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5, color = "gray40"),
    legend.position = "top",
    panel.grid.minor = element_blank(),
    axis.title = element_text(face = "bold")
  )

# 3.1 Density Plot / Histogram
# This helps visualize the distribution shape
p1 <- ggplot(clean_df, aes(x = Rating, fill = ReviewType)) +
  geom_density(alpha = 0.6) +
  scale_fill_manual(values = c("#FF6B6B", "#4ECDC4")) +
  labs(
    title = "Distribution of Ratings by Review Type",
    subtitle = "Comparing density of ratings for Text-Only vs. Photographic reviews",
    x = "Rating (1-5)",
    y = "Density",
    fill = "Review Type"
  ) +
  custom_theme

# 3.2 Boxplot with Mean points
# This directly addresses the comparison of means and spread
p2 <- ggplot(clean_df, aes(x = ReviewType, y = Rating, fill = ReviewType)) +
  geom_boxplot(alpha = 0.7, outlier.shape = 21, outlier.fill = "white") +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 4, fill = "white", stroke = 1.5) +
  scale_fill_manual(values = c("#FF6B6B", "#4ECDC4")) +
  labs(
    title = "Rating Comparison: Text vs. Photographic",
    subtitle = "Boxplot showing median, quartiles, and mean (diamond)",
    x = "Review Type",
    y = "Rating"
  ) +
  custom_theme

# Save plots
ggsave("rating_distribution.png", p1, width = 8, height = 6)
ggsave("rating_boxplot.png", p2, width = 8, height = 6)

cat("\nPlots saved as 'rating_distribution.png' and 'rating_boxplot.png'.\n")

# --- 4. Statistical Analysis ---
# Research Question: Is there a difference in mean rating between restaurants that received 
# photographic reviews and those that received only text based reviews?

# H0: Mean(Photo) = Mean(Text)
# H1: Mean(Photo) != Mean(Text)

# We use Welch's t-test (does not assume equal variance)
t_test_result <- t.test(Rating ~ ReviewType, data = clean_df)

# Capture output to a file for the report
sink("analysis_results.txt")

cat("--- Statistical Analysis Results ---\n")
cat("Research Question: Difference in mean rating (Photo vs Text)\n\n")

cat("1. Group Statistics:\n")
print(clean_df %>% 
  group_by(ReviewType) %>% 
  summarise(
    Mean_Rating = mean(Rating),
    SD_Rating = sd(Rating),
    Count = n()
  ))
cat("\n")

cat("2. T-Test Results:\n")
print(t_test_result)

# Interpretation helper
if(t_test_result$p.value < 0.05) {
  cat("\nResult: Reject the Null Hypothesis (H0).\n")
  cat("Conclusion: There is a statistically significant difference in mean ratings between photographic and text-only reviews.\n")
} else {
  cat("\nResult: Fail to reject the Null Hypothesis (H0).\n")
  cat("Conclusion: There is no statistically significant difference in mean ratings.\n")
}

sink() # Stop writing to file

cat("\n--- Analysis Complete ---\n")
cat("1. Statistical results saved to 'analysis_results.txt'\n")
cat("2. Plots saved to 'rating_distribution.png' and 'rating_boxplot.png'\n")

