
# Remove useless column
df <- df %>% select(-`7514`)

# Remove missing ratings
df <- df %>% filter(!is.na(Rating))

# Remove blank reviews
df <- df %>% filter(!is.na(Review), Review != "")

# Replace missing pictures with 0
df$Pictures[is.na(df$Pictures)] <- 0

# Convert to correct types
df$Rating <- as.numeric(df$Rating)
df$Pictures <- as.numeric(df$Pictures)

# Remove duplicates
df <- df %>% distinct()

# Remove rows where all fields are empty / useless
df <- df[rowSums(is.na(df)) != ncol(df), ]

cat("\n--- CLEANED DATASET SUMMARY ---\n")
print(summary(df))
cat("\nRows remaining:", nrow(df), "\n")

# Save cleaned dataset
library(readr)

write_csv(df, "Restaurant_reviews_clean.csv")

cat("\n✔ Clean dataset saved successfully as 'Restaurant_reviews_clean.csv'\n")

