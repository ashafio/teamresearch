###############################################################
# 7COM1079 – Restaurant Reviews Analysis
# Full script using "Restaurant reviews.csv"
###############################################################

# 0. LOAD PACKAGES ---------------------------------------------------------

# Install packages once if needed:
# install.packages("readr")
# install.packages("ggplot2")
# install.packages("dplyr")

library(readr)
library(ggplot2)
library(dplyr)

cat("\n--- Packages loaded successfully ---\n")


# 1. LOAD DATA -------------------------------------------------------------

Restaurant_reviews <- read_csv("Restaurant reviews.csv")

cat("\n--- Data loaded from 'Restaurant reviews.csv' ---\n")
cat("Rows:", nrow(Restaurant_reviews), "Columns:", ncol(Restaurant_reviews), "\n\n")

# Look at first few rows
print(head(Restaurant_reviews, 3))

# Use a working copy called df
df <- Restaurant_reviews


# 2. CLEANING & FEATURE ENGINEERING ---------------------------------------

cat("\n--- Cleaning data and creating new variables ---\n")

# Ensure Rating is numeric
df$Rating <- as.numeric(df$Rating)

# Remove rows with missing Rating
df <- df %>% filter(!is.na(Rating))

# Create review length from Review text
df$ReviewLength <- nchar(df$Review)

# Create ReviewType: Picture vs NoPicture
df$ReviewType <- ifelse(df$Pictures > 0, "Picture", "NoPicture")

# Parse Time column into a POSIXct Date/time (if format matches)
df$Date <- as.POSIXct(df$Time, format = "%Y-%m-%d %H:%M:%S")

# Extract hour of day for advanced analysis (if Time parsed correctly)
df$ReviewHour <- suppressWarnings(as.numeric(format(df$Date, "%H")))

# Quick summary of key variables
cat("\nSummary of key variables:\n")
print(summary(df[, c("Rating", "Pictures", "ReviewLength", "ReviewHour")]))

cat("\nFrequency of ReviewType:\n")
print(table(df$ReviewType))


# 3. SUMMARY STATISTICS ----------------------------------------------------

cat("\n--- Summary statistics by ReviewType ---\n")

summary_stats <- df %>%
  group_by(ReviewType) %>%
  summarise(
    MeanRating = mean(Rating),
    SDRating   = sd(Rating),
    Count      = n()
  )

print(summary_stats)


# 4. VISUALISATIONS (4 GRAPHS) --------------------------------------------

cat("\n--- Drawing graphs (check Plots pane / graphics window) ---\n")

# GRAPH 1: Boxplot of Ratings by ReviewType
print(
  ggplot(df, aes(x = ReviewType, y = Rating, fill = ReviewType)) +
    geom_boxplot(alpha = 0.85) +
    labs(
      title = "Rating Comparison: Picture vs No-Picture Reviews",
      x = "Review Type",
      y = "Rating (1–5)"
    ) +
    scale_fill_manual(values = c("Picture" = "#1e90ff", "NoPicture" = "#ff7f50")) +
    theme_minimal()
)

# GRAPH 2: Histogram of Ratings by ReviewType
print(
  ggplot(df, aes(x = Rating, fill = ReviewType)) +
    geom_histogram(binwidth = 1, position = "dodge", alpha = 0.8) +
    labs(
      title = "Rating Distribution by Review Type",
      x = "Rating",
      y = "Frequency"
    ) +
    scale_fill_manual(values = c("Picture" = "#1e90ff", "NoPicture" = "#ff7f50")) +
    theme_minimal()
)

# GRAPH 3: Scatter – ReviewLength vs Rating
print(
  ggplot(df, aes(x = ReviewLength, y = Rating)) +
    geom_point(alpha = 0.25, color = "#4b0082") +
    geom_smooth(method = "lm", color = "red", linewidth = 1.1) +
    labs(
      title = "Review Length vs Rating",
      x = "Review Length (characters)",
      y = "Rating"
    ) +
    theme_minimal()
)

# GRAPH 4: Scatter – Pictures vs Rating
print(
  ggplot(df, aes(x = Pictures, y = Rating)) +
    geom_point(alpha = 0.3, color = "darkgreen") +
    geom_smooth(method = "lm", color = "black", linewidth = 1.1) +
    labs(
      title = "Number of Pictures vs Rating",
      x = "Number of Pictures",
      y = "Rating"
    ) +
    theme_minimal()
)


# 5. INDEPENDENT SAMPLES T-TEST -------------------------------------------

cat("\n--- Independent samples t-test: Rating ~ ReviewType ---\n")

t_test_result <- t.test(Rating ~ ReviewType, data = df)
print(t_test_result)


# 6. CORRELATION ANALYSIS --------------------------------------------------

cat("\n--- Correlation: ReviewLength vs Rating ---\n")
cor_length <- cor.test(df$ReviewLength, df$Rating)
print(cor_length)

cat("\n--- Correlation: Pictures vs Rating ---\n")
cor_pics <- cor.test(df$Pictures, df$Rating)
print(cor_pics)


# 7. MULTIPLE LINEAR REGRESSION (ADVANCED) --------------------------------

cat("\n--- Multiple linear regression model ---\n")

# Use ReviewHour only if available; NA values are okay in lm()
model <- lm(Rating ~ Pictures + ReviewLength + ReviewHour, data = df)
print(summary(model))


# 8. END -------------------------------------------------------------------

cat("\n--- END OF FULL ANALYSIS SCRIPT ---\n")

