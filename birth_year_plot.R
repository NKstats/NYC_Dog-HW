
suppressMessages(library(patchwork))
suppressMessages(library(tidyverse))

cc_data <- read_csv("cleaned_data.csv",show_col_types = F)

# Plot the clean data
p1 <- ggplot(cc_data, aes(x = birth_year)) + geom_bar() + 
  labs(title = "Number of Dogs Born by Year", x = "Year of Birth",
       y = "Number of Dogs") + theme_classic()+
  theme(axis.title.y = element_text(margin = margin(r = 10)))

# Restrict to years with 50 or more dogs
birth_year_counts <- cc_data %>%
  group_by(birth_year) %>%
  summarise(count = n())

non_trivial_years <- birth_year_counts %>% filter(count >= 50)

p2 <- ggplot(non_trivial_years, aes(x = birth_year, y = count)) +
  geom_bar(stat = "identity", fill="blue") +
  labs(title = sprintf("Number of Dogs Born by Year (Years with ≥ %d Dogs)",50),
       x = "Year of Birth", y = "Number of Dogs") + theme_classic()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x = element_text(margin = margin(t = 10)),
        axis.title.y = element_text(margin = margin(r = 10))) +
  scale_x_continuous(breaks = non_trivial_years$birth_year)

plt <- p1+p2

ggsave("Year_of_birth_plot.png", plot=plt, width=12, height=6, units="in")