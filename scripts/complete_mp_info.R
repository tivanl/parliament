library(rvest)
library(glue)
library(logger)
library(tidyverse)
source("scripts/R/get_mp_attributes.R")
source("scripts/R/get_mp_pos.R")
source("scripts/R/get_mps_info.R")
source("scripts/R/get_start_end_date.R")

# this is the page that contains all MPs (NA and NCOP)
mp_page <- read_html("https://pmg.org.za/members/")

# Get the NA ones
mp_national_assembly <- mp_page %>% 
  html_element("#national-assembly") %>% 
  html_elements(".single-mp") %>% 
  map_dfr(~get_mp_attributes(.x, "national-assembly"))

# Get the NCOP ones
mp_ncop <- mp_page %>% 
  html_element("#national-council-of-provinces") %>% 
  html_elements(".single-mp") %>% 
  map_dfr(~get_mp_attributes(.x, "national-council-of-provinces"))


# get info from each MP's page
parliament_mp_data <- bind_rows(mp_national_assembly, mp_ncop) %>% 
  mutate(
    data = map(mp_page, get_mps_info)
  )

# get columns into clean format
full_parliament_mp <- parliament_mp_data %>% 
  unnest(data) %>% 
  mutate(
    title = gsub("(^[^,]+, )([A-Za-z]+)(.*)", "\\2", mp),
    mp = gsub("(^[^,]+, )([A-Za-z]+)(.*)", "\\1\\3", mp),
    dates = map(date, get_start_end_date),
    date_scraped = Sys.Date()
  ) %>% 
  unnest(dates) %>% 
  separate(
    col = position,
    into = c("position", "body"),
    sep = "( at )|( to the )|( of the )"
  )

# save the data
write_csv(full_parliament_mp, glue("output/members_of_parliament{Sys.Date()}.csv"))






