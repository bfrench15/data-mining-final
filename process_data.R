#' Load and process the data.
#' @author Gabriel Hooks

heart <- read.csv("data/heart_2020_cleaned.csv")

# print unique values for each column
lapply(heart, unique)


# Create column for numeric representation of AgeCategory
library(tibble)

numRange <- function(x) {
  # Replace "80 or older" with "80-100", then split by '-' and convert to num vec
  n <- gsub(" or older", "-100", x)
  limits <- as.numeric(unlist(strsplit(n, '-')))
  seq(limits[1], limits[2])
}

# Create the AgeRange and add it to heart
AgeRange <- sapply(heart$AgeCategory, numRange)
heart <- tibble::add_column(heart, AgeRange, .after = "AgeCategory")


# Columns to be converted to factor
factor_columns <- c("HeartDisease", "Smoking", "AlcoholDrinking", "Stroke",
                    "DiffWalking", "Sex", "AgeCategory", "Race", "Diabetic",
                    "PhysicalActivity", "GenHealth", "Asthma", "KidneyDisease",
                    "SkinCancer")

# Convert those columns to factor columns
heart[factor_columns] <- lapply(heart[factor_columns], as.factor)
