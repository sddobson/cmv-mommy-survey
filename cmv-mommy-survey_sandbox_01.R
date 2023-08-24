library(tidyverse)
library(readr)
library(tidyr)

id <- 
  read_excel(
    "CMV Mommies data_08-08-2023.xlsx",
    range = cell_cols("A"),
    col_names = TRUE
  ) %>% 
  filter(`Respondent ID` != 11801536972)

q2 <- 
  read_excel(
  "CMV Mommies data_08-08-2023.xlsx",
  range = cell_cols("R:X"), 
  col_names = FALSE
  ) %>% 
  slice(-2)


q2_item <- as_vector(q2[1,1])


q2_long <-
  q2 %>% 
  slice(-1) %>% 
  mutate(id = id$`Respondent ID`) %>% 
  pivot_longer(
    cols = -"id", 
    names_to = "item", 
    values_to = "response"
  ) %>% 
  drop_na() %>% 
  full_join(id, by = join_by(id == `Respondent ID`)) %>% 
  mutate(item = q2_item)