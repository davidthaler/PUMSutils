#' Estimates standard error of the mean for ACS PUMS data.
#'
#' Computes a standard error of the mean of a field by 
#' the direct method from the ACS documents.
#' 
#' @param x a data.frame or similar with data filtered to relevant rows
#' @param data.field the column of x to take the mean of
#' 
#' @return The standard error for the mean of data.field for this data
#' 
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2013_PUMS_README.pdf}
#' 
#' @export
#' 
se.acs.mean <- function(x, data.field){
  pt.est <- acs.mean(x, data.field)
  rep.ests <- sapply(1:80, function(n) acs.mean(x, data.field, n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}