#' Compute Standard Errors on ACS PUMS Data
#'
#' Computes standard errors for count estimates from the ACS 
#' PUMS data by the direct method, using replicate weights.
# 
#' @param x a data frame or similar with data filtered to relevant rows.
#' 
#' @return The standard error for the population total of this data.
#' 
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2013_PUMS_README.pdf}
#' 
#' @export
#' 
se.estimate <- function(x){
  pt.est <- estimate(x)
  rep.ests <- sapply(1:80, function(n) estimate(x, n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}














