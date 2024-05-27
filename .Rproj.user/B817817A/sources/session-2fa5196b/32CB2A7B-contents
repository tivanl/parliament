# On the mp's specific page, get their current and former positions

# test_page <- read_html("https://www.pa.org.za/person/tamarin-breedt/")
# 
# tag <- test_page %>%
#   html_elements("#truncate-former-section") %>%
#   html_elements(".text-link")
# 
# tag %>%
#   map(~get_mp_pos(.x, "current"))


get_mp_pos <- function(tag, current_former){
  
  date <- tag %>% 
    html_element(".text-link__date") %>% 
    html_text() %>% 
    gsub("\\s+", " ", .) %>% 
    str_trim()
  
  position <- tag %>% 
    html_element(".text-link__text") %>% 
    html_text() %>% 
    gsub("\\s+", " ", .) %>% 
    str_trim()
  
  df_out <- tibble(
    position = position,
    date = date,
    current_former = current_former
  )
  
  return(df_out)
  
}