## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

# The agronomic/yield data
  tar_target(ag_file, 
             here("data", "Mian_2021_plant_rows.xlsx"), 
             format = "file"),
  
# The NIR data
tar_target(nir_files, 
           list.files(here("data", "nir"), full.names = TRUE), 
           format = "file"),

# The NIR masterfile
tar_target(nir_masterfile, 
           here("data", "nir_masterfile_plantrows.csv"), 
           format = "file"),

# The single plants masterfile
tar_target(sp_masterfile, 
           here("data", "nir_masterfile_2021.csv"), 
           format = "file"),

# The single plants nir data
tar_target(sp_nir, 
           list.files(here("data", "nir", "single_plants"), full.names = TRUE), 
           format = "file"),

# Read in the agronomic data file and clean up the column names a bit
tar_target(ag_data, 
           read_and_clean(ag_file)), 

# Read in and clean the nir data
tar_target(nir_data, 
           snfR::clean_nir_files(files = nir_files, nir_masterfile = nir_masterfile)),

# Clean up the single plant nir data
tar_target(sp_nir_data, 
           snfR::clean_nir_files(files = sp_nir, nir_masterfile = sp_masterfile)),

# Clean up and export the single plant data 
tar_target(export_sp, 
           export_sp_data(sp_nir_data), 
           format = "file"),

# Merge the agronomic data with the yield data
tar_target(merged_data, 
           merge_data(nir_data, ag_data)),

## Section: HOLL data merging
##################################################

# The HOLL plant rows data
tar_target(holl_file, 
           here("data", "2021 plant rows data _HOLL.xlsx"), 
           format = "file"),

# Read in the holl data
tar_target(holl_data, 
           read_excel(holl_file)), 

# Clean up the NIR data again, but this time include the fatty acid columns
tar_target(nir_data_fa, 
           snfR::clean_nir_files(files = nir_files, nir_masterfile = nir_masterfile, select_FA = TRUE)), 

# And merge this data with the holl agronomic data
tar_target(holl_merged, 
           merge_holl_data(ag = holl_data, nir = nir_data_fa)),

# Export the merged data
tar_target(export_data, 
           export_merged_data(file = merged_data, dir = here("exports", "merged_plant_rows_2021.csv")),
           format = "file"), 

tar_target(export_holl, 
           export_merged_data(file = holl_merged, dir = here("exports", "merged_holl_2021.csv")), 
           format = "file")


)
