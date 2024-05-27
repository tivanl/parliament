# per year get the interests

# the interests declared for a specific year is not a child node of that year.
# this necessitates getting the year and the interests for that year in separate 
# functions

tag <- yearly_interest_list[[1]]

get_mp_interests <- function(tag){}




tag %>% 
  html_elements(".mp-collapse")



mp_specific_page %>% 
  html_elements(".person-interests") %>% 
  html_elements(".mp-year-contents__inner") %>% 
  html_elements(".mp-collapse") %>% 
  #%>% 
  html_text() %>% 
  str_trim() %>% 
  gsub("\\s{2,}", "|", .) %>% 
  str_split(pattern = "\\|")

#\32 023 > div > div > div