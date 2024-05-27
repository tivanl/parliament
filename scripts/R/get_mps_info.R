# From the mp page, get their specific info

get_mps_info <- function(mp_page){
  
  log_info(glue("Getting info for page: {mp_page}"))
  
  Sys.sleep(1)
  
  safe_read_html <- safely(read_html)
  
  # collect result and error
  mp_specific_page <- safe_read_html(mp_page)
  
  # repeat getting the page until it is not NULL
  while(is.null(mp_specific_page$result)){
    
    Sys.sleep(1)
    
    logger::log_info(glue("Attempting {mp_page} again\n"))
    
    mp_specific_page <- safe_read_html(mp_page)
    
  }
  
  mp_specific_page <- mp_specific_page$result

    
  current_pos_list <- mp_specific_page %>% 
    html_elements("#truncate-current-section") %>% 
    html_elements(".text-link") %>%
    map_dfr(
      ~get_mp_pos(.x, "current")
    )
  
  
  former_pos_list <- mp_specific_page %>% 
    html_elements("#truncate-former-section") %>% 
    html_elements(".text-link") %>%
    map_dfr(
      ~get_mp_pos(.x, "current")
    )
  
  df_out <- bind_rows(current_pos_list, former_pos_list)
  
  log_info(glue("Successfully retrieved info for page: {mp_page}"))
  
  return(df_out)
  
}
