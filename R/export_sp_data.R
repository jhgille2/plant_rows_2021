#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param sp_nir_data
export_sp_data <- function(sp_nir_data) {

  sp_clean <- sp_nir_data %>% 
    filter(!is.na(nir_no) & !is.na(test)) %>%
    rename(color = rep, 
           plant_no = genotype, 
           cross = code) %>% 
    arrange(nir_no) %>%
    select(-mg)
  
  write_csv(sp_clean, here("exports", "single_plant_nir_2021.csv"))
  
  return(here("exports", "single_plant_nir_2021.csv"))
}
