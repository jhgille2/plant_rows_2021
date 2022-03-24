#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param ag_file
read_and_clean <- function(ag_file) {

  
  # Rename some of the agronomic data columns and then remove
  # a couple of columns that aren't needed
  ag_clean <- read_excel(ag_file) %>% 
    clean_names() %>%
    select(id,
           plant_no, 
           mg, 
           fc, 
           pb, 
           md, 
           yield, 
           seed_weight, 
           gs_gl, 
           ht, 
           det, 
           ldg, 
           ag_score, 
           notes) %>% 
    rename(genotype = id)
  
  return(ag_clean)

}
