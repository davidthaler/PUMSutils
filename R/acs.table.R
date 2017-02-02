#' Compute a Table on ACS PUMS Data.
#' 
#' Computes a table for a field in the ACS PUMS data, using the sample weights.
#' 
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field name of the field to tabulate
#' 
#' @return table of weighted counts of the values of field in x
#' 
#' @export
#' 
acs.table <- function(x, field){
  wt.name <- get.weight(x)
  Hmisc::wtd.table(x[[field]], weights=x[[wt.name]])
}