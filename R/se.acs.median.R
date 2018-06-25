#' Estimates the standard error of the median in the ACS PUMS data.
#'
#' Computes the standard error of the median of a field in the ACS PUMS data,
#' by the direct estimation method, involving weight replicates.
#'
#' @return the standard error of the median of `x$field`
#'
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2016_PUMS_README.pdf}
#'
#' @export
se.acs.median <- function(x, field){
  pt.est <- acs.median(x, field)
  rep.ests <- sapply(1:80, function(n) acs.median(x, field, n))
  sqrt((4/80)* sum((rep.ests - pt.est)^2))
}
