#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param ag
#' @param nir
merge_holl_data <- function(ag = holl_data, nir = nir_data_fa) {

  # Take the nir data and select only the oil columns
  # and keep only one observation per genotype
  fa_data_clean <- nir %>% 
    select(genotype, 
           date_time_of_analysis,
           contains("acid")) %>% 
    group_by(genotype) %>% 
    top_n(1, wt = date_time_of_analysis) %>% 
    select(-date_time_of_analysis) %>% 
    ungroup() %>% 
    distinct()
  
  # Join this to the agronomic data with the genotype column
  holl_merged <- left_join(ag, fa_data_clean, by = "genotype")
  
  # And return the merged data
  return(holl_merged)
}
