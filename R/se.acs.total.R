#' Estimates the standard error of a total on the ACS PUMS data.
#'
#' Computes standard errors of the weighted total of a numerical field in the
#' ACS PUMS data by the direct method, involving the replicate weights.
#'
#' @param x a data.frame or similar of ACS PUMS data or a subset
#' @param field (string) name of a numerical column to take a weighted total over
#'
#' @return the standard error of the weighted total of `x$field`
#'
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2016_PUMS_README.pdf}
#'
#' @export
se.acs.total <- function(x, field){
  pt.est <- acs.total(x, field)
  rep.ests <- sapply(1:80, function(n) acs.total(x, field, n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}
