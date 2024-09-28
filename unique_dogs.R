
suppressMessages(library(tidyverse))

cc_data <- read_csv("cleaned_data.csv", show_col_types = F)

# unique dogs based on name, gender, birth year, breed, and zip code
unique_dogs <- cc_data %>%
  distinct(name, gender, birth_year, breed, zipcode, .keep_all = T)

cat(sprintf("\nRows count (before assumption): %d", nrow(cc_data)))
cat(sprintf("\nRows count (after assumption): %d\nRows removed: %d\n\n",
            nrow(unique_dogs), nrow(cc_data) - nrow(unique_dogs)))

# Save unique dogs data for next steps
write_csv(unique_dogs, "unique_dogs.csv")





