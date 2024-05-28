# Get the interests that were declared for a given year

get_year_interest <- function(interest_types, index){
  
  interest_type = interest_types[[index]] %>% 
    html_elements(".collapse-title") %>% 
    html_text() %>% 
    gsub("\\s", "", .)
  
  
  df_out <- interest_types[[index]] %>% 
    html_table() %>% 
    clean_names() %>% 
    mutate(across(everything(), as.character)) %>% 
    pivot_longer(
      cols = everything(),
      names_to = "interest_field",
      values_to = "interest_entry"
    ) %>% 
    mutate(interest_type = interest_type)
  
  return(df_out)
  
}
