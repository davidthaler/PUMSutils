#' Compute Standard Errors for Proportions from the ACS PUMS Data 
#'
#' Estimates the standard error for a proportion 
#' from the ACS PUMS data (either housing or population) 
#' using direct estimation method involving the replicate weights.
#' 
#' @param numerator data frame with the records of the subset class (numerator)
#' @param denominator data frame with records of the population (denominator)
#' 
#' @return The standard error for the proportion
#' 
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2013_PUMS_README.pdf}
#' 
#' @export
#' 
se.proportion <- function(numerator, denominator){
  pt.est <- proportion(numerator, denominator)
  rep.ests <- sapply(1:80, function(n) proportion(numerator, denominator, n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}
