#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param nir_data
#' @param ag_data
merge_data <- function(nir_data, ag_data) {

  # Keep only one observation per genotype
  # The ionly duplicated genotype in this data set is one with
  # similar values for protein and oil so I figured it was likely just a repeat
  nir_data_clean <- nir_data %>% 
    filter(!is.na(genotype)) %>% 
    group_by(genotype) %>% 
    top_n(1) %>% 
    rename(cross = code) %>% 
    select(test, 
           plot, 
           cross,
           genotype, 
           loc, 
           year, 
           oil_dry_basis, 
           protein_dry_basis)
  
  # Merge the two sets of data by genotype
  ag_merged <- left_join(ag_data, nir_data_clean, by = "genotype")
  
  # Add some columns that are the same for every observation
  # and then reorder the columns
  ag_merged %<>% 
    mutate(test = "Plant Rows", 
           plot = str_replace(genotype, "N21", "RM21"), 
           year = 2021, 
           loc  = "CLA", 
           fc   = toupper(fc), 
           pb   = toupper(pb), 
           det  = toupper(det)) %>%
    select(test, 
           genotype, 
           cross,
           plant_no, 
           plot,
           year, 
           loc,
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
           oil_dry_basis, 
           protein_dry_basis) %>% 
    filter(!is.na(yield))
    
  # And return this merged data
  return(ag_merged)
}
