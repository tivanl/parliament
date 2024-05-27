# this function takes the dates listed for the current and past positions and
# outputs a start and an end date

get_start_end_date <- function(date){
  
  # There are 4 permutations of the date shown below
  # date = "from 23rd April 2019 until 8th May 2019"
  # date = "since 22nd May 2019"
  # date = "until 6th May 2014"
  # date = ""
  
  date_type <- case_when(
    grepl("^from ", date) ~ "start_end",
    grepl("^since ", date) ~ "start_no_end",
    grepl("^until ", date) ~ "end_no_start",
    "" == date ~ "no_date",
  )
  
  if(date_type == "start_end"){
    
    start_date = gsub("(^from )([0-9]+)([a-z]+)( [A-Za-z]+ )([0-9]{4}).*", "\\2\\4\\5", date) %>% 
      dmy()
    end_date = gsub("(.*until )([0-9]+)([a-z]+)( [A-Za-z]+ )([0-9]{4}).*", "\\2\\4\\5", date) %>% 
      dmy()
    
  } else if(date_type == "start_no_end"){
    
    start_date = gsub("(^since )([0-9]+)([a-z]+)( [A-Za-z]+ )([0-9]{4}).*", "\\2\\4\\5", date) %>% 
      dmy()
    end_date = NA_Date_
    
  } else if(date_type == "end_no_start"){
    
    start_date = NA_Date_
    end_date = gsub("(^until )([0-9]+)([a-z]+)( [A-Za-z]+ )([0-9]{4}).*", "\\2\\4\\5", date) %>%
      dmy()
    
  } else{
    
    start_date = NA_Date_
    end_date = NA_Date_
    
  }
  
  df_out <- tibble(
    start_date = start_date,
    end_date = end_date
  )
  
  return(df_out)
  
}