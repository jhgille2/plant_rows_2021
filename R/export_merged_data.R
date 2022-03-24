#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param file
#' @param dir
#' @param format
export_merged_data <- function(file = merged_data, dir = here("exports",
                               "merged_plant_rows_2021.csv"), format = "file") {

  # Write the data to a csv file
  write_csv(file, dir, na = "")
  
  # And return the path to this file
  return(dir)
}
