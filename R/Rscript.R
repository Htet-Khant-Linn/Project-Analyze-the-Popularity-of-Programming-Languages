library(readr)
library(dplyr)
library(ggplot2)

installed.packages() %>%
  as_tibble() %>%
  select(Package, Version)

data <- read_csv("data/stack_overflow_data.csv")

head(data)
str(data)
glimpse(data)

# What was the percentage of R questions for 2020? 
r_2020 <- data %>% 
  filter(year == 2020 & tag == "r") %>%
  mutate(percentage = num_questions/year_total*100)
r_2020


# Identify the five programming language tags with the highest total number 
# of questions asked between 2015 and 2020 (inclusive).

sorted_tags <- data %>%
  filter(year %in% c(2015:2020)) %>%
  group_by(tag) %>%
  summarize(total_num_questions = sum(num_questions)) %>%
  arrange(desc(total_num_questions))

highest_tags <- sorted_tags %>%
                          pull(tag) %>%
                          head(n = 5)
highest_tags

# Visualizing the highest tags

data_subset <- data %>%
  filter(tag %in% highest_tags, year >= 2015) %>%
  mutate(percentage = num_questions/year_total*100)
data_subset


ggplot(data_subset, aes(x = year, y = percentage, color = tag)) +
  geom_line() +
  scale_x_log10()
