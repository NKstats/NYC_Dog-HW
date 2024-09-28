
suppressMessages(library(tidyverse))

cc_data <- read_csv("cleaned_data.csv", show_col_types = F)

# Compare the number of distinct rows to the total rows
total_rows <- nrow(cc_data)
distinct_rows <- cc_data %>% distinct()

cat(sprintf("\nTotal number of rows: %d\nNumber of distinct rows: %d\n\n", 
            total_rows, nrow(distinct_rows)))

# Find the non-distinct (duplicate) rows
duplicate_rows <- cc_data %>% add_count(across(everything())) %>%  
  filter(n > 1) %>% arrange(desc(n))            

print(duplicate_rows)

write_csv(duplicate_rows, "duplicate_rows.csv")
write_csv(distinct_rows, "distinct_rows.csv")