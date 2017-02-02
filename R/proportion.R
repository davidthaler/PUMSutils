#' Estimates a Proportion from the ACS PUMS Data
#' 
#' Estimates a proportion from the ACS PUMS data (either housing or population) 
#' using the sample weights.
#' 
#' @param numerator data frame with the records of the subset class (numerator)
#' @param denominator data frame with records of the population (denominator)
#' @param wt.rep.num the weight replicate number, if a replicate weight
#' 
#' @return The point estimate of the proportion
#' 
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2013_PUMS_README.pdf}
#' 
#' @export
#' 
proportion <- function(numerator, denominator, wt.rep.num=NULL){
  estimate(numerator, wt.rep.num) / estimate(denominator, wt.rep.num)
}
