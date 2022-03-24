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

# Read in the agronomic data file and clean up the column names a bit
tar_target(ag_data, 
           read_and_clean(ag_file)), 

# Read in and clean the nir data
tar_target(nir_data, 
           snfR::clean_nir_files(files = nir_files, nir_masterfile = nir_masterfile)),

# Merge the agronomic data with the yield data
tar_target(merged_data, 
           merge_data(nir_data, ag_data)),

# Export the merged data
tar_target(export_data, 
           export_merged_data(file = merged_data, dir = here("exports", "merged_plant_rows_2021.csv"), 
                              format = "file"))


)
