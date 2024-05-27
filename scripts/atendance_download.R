library(readxl)
library(tidyverse)


mp_attendance <- read_xlsx("data/committee-attendance.xlsx")


mp_attendance %>% count(committee)
  group_by(year, committee, party) %>% 
  summarise(
    num_members = n_distinct(member)
  ) %>% 
  mutate(
    num_parties_in_committee = n()
  ) %>% 
  arrange(-num_parties_in_committee)