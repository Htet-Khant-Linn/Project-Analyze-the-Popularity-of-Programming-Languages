library(readr)
library(dplyr)
library(ggplot2)

installed.packages() %>%
  as_tibble() %>%
  select(Package, Version)

data <- read_csv("C:/Users/user/Desktop/Analyze the Popularity of Programming Languages/files/stack_overflow_data.csv")

head(data)
str(data)
glimpse(data)

# What was the percentage of R questions for 2020? 
r_2020 <- data %>% 
    filter(year == 2020 & tag == "r") %>%
    mutate(percentage = num_questions/year_total*100)
r_2020
