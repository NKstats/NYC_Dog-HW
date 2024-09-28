
suppressMessages(library(tidyverse))

unique_dogs <- read_csv("unique_dogs.csv",show_col_types = F)

# Total number of dogs born in each year
dogs_per_year <- unique_dogs %>% group_by(birth_year) %>%
  summarise(total_dogs = n(), .groups = 'drop')

# Total number of dogs with a given name in each year
dogs_per_name_year <- unique_dogs %>% group_by(birth_year, name) %>%
  summarise(name_count = n(), .groups = 'drop')

joined_data <- dogs_per_name_year %>% 
  left_join(dogs_per_year, by = "birth_year") %>%
  mutate(rate = name_count / total_dogs)

# Most popular dog name in 1999 and 2023
most_popular_1999 <- joined_data %>% filter(birth_year == 1999) %>%
  arrange(desc(rate)) %>% slice(1) %>% pull(name)

most_popular_2023 <- joined_data %>% filter(birth_year == 2023) %>%
  arrange(desc(rate)) %>% slice(1) %>% pull(name)


cat(sprintf("\nMost popular dog name in 1999: %s", most_popular_1999))
cat(sprintf("\nMost popular dog name in 2023: %s\n\n", most_popular_2023))


plot <- joined_data %>%
  filter(name %in% c(most_popular_1999, most_popular_2023)) %>%
  mutate(name_year = case_when(
    name == most_popular_1999 ~ paste(most_popular_1999, "(1999)"),
    name == most_popular_2023 ~ paste(most_popular_2023, "(2023)")
  )) %>%
  ggplot(aes(x = birth_year, y = rate, color = name_year)) +
  geom_line(lwd=1) +
  labs(title = "Rate of Most Popular Dog Names in 1999 and 2023 Over Time",
       x = "Year", y = "Rate", color = "Dog Name (Year)") + theme_classic()


ggsave("most_popular_dogs.png",  plot=plot, width=10, height=6, units="in")
