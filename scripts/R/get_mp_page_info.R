# From the mp page, get their specific info

# use this as an example
# mp_page <- "https://www.pa.org.za/person/noxolo-abraham-ntantiso/"

get_mp_page_info <- function(mp_page){
  
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

  ## Get the positions of the MP
  
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
      ~get_mp_pos(.x, "former")
    )
  
  df_out_1 <- bind_rows(current_pos_list, former_pos_list)
  
  
  # get the interests of the mp
  
  ## Yearly list of interests for the MP
  list_declarations <- mp_specific_page %>% 
    html_elements(".person-interests") %>% 
    html_elements(".mp-year-contents__inner") 
  
  years <- mp_specific_page %>% 
    html_elements(".mp-year-collapse") %>% 
    html_elements("h3") %>% 
    html_text() %>% 
    gsub("\\s", "", .)
  
  df_out_2 <- map2_dfr(
    .x = list_declarations,
    .y = years,
    get_mp_interests
  )
  # get the values for each year
  # see function get_mp_interests()
  
  list_out <- list(
    positions = df_out_1,
    interests = df_out_2
  )
  
  
  log_info(glue("Successfully retrieved info for page: {mp_page}"))
  
  return(list_out)
  
}
