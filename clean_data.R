
suppressMessages(library(tidyverse))

data <- read_csv("NYC_Dog.csv", show_col_types = F)

pr <- problems(data) %>% pull(row)

print(problems(data))

problematic_data  <- data %>% filter(row_number() %in% pr)
print(problematic_data)

# Renaming columns
data <- data %>%
  rename(
    name = AnimalName,
    gender = AnimalGender,
    birth_year = AnimalBirthYear,
    breed = BreedName,
    zipcode = ZipCode,
    issue_date = LicenseIssuedDate,
    expiration_date = LicenseExpiredDate,
    extract_year = `Extract Year`
  )

# Reducing the data to complete cases

unwanted_names <- c(".", "A", "UNKNOWN", "NAME NOT PROVIDED", "NONE", "NAME")
cc_data <- data %>% filter(complete.cases(.) & !name %in% unwanted_names)

cat(sprintf("\nRows before removing incomplete cases: %d\n", nrow(data)))
cat(sprintf("Rows after removing incomplete cases: %d\nCases Removed: %d\n\n",
            nrow(cc_data), nrow(data)-nrow(cc_data)))

write_csv(cc_data, "cleaned_data.csv")
