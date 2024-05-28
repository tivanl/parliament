# per year get the interests

# the interests declared for a specific year is not a child node of that year.
# this necessitates getting the year and the interests for that year in separate 
# functions

# library(rvest)
# library(janitor)
# library(glue)
# library(tidyverse)

  

# tag <- list_declarations[[1]]


get_mp_interests <- function(tag, year){
  
interest_types <- tag %>% 
  html_elements(".mp-collapse") 

  df_out <- map_dfr(
    .x = 1:length(interest_types), 
    ~get_year_interest(interest_types, index = .x)
  ) %>% 
    mutate(year = year)
  
  return(df_out)

}





