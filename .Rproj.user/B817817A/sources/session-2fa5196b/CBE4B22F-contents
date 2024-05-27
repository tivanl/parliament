# this function gets the mp's name, party and link to their page from the 
# general mp page of the PMG

get_mp_attributes <- function(tag, house){
  
  text = tag %>%
    html_text() %>% 
    str_trim() %>% 
    str_split("\\n", n = 2)
  
  name = text[[1]][1]
  party = text[[1]][2]
  
  mp_link = tag %>%
    html_element("a") %>% 
    html_attr(name = "href")
  
  df_out <- tibble(
    party = party,
    mp = name,
    mp_page = mp_link,
    house = house
  )
  
  return(df_out)
}
