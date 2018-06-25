#' Compute standard errors for ACS PUMS data by the direct method
#'
#' This function uses weight replicates to compute direct standard errors
#' on the ACS PUMS data for any statistic.
#' It can take any of the functions in PUMSUtils that produce single estimates,
#' including `estimate`, `proportion`, `acs.mean`, etc.
#' The function `f` must have the signature f(x, ..., wt.rep.num=NULL),
#' where `x` is the data and `wt.rep.num` is 1:80 or NULL.
#' If NULL, the main expansion weight is used.
#' If 1:80, a replicate weight is used.
#' The dots argument is passes to `f` and may be empty.
#' See the ACS PUMS readme document referenced below for the details of
#' the calculation of the direct standard errors.
#'
#' @param f a function that takes data and a weight replicate number
#'          called wt.rep.num with a default value of NULL
#'
#' @return the standard error of the statistic defined by f over the data
#'
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2016_PUMS_README.pdf}
#'
#' @examples
#' # Standard error of count of households in Washington State in 2016
#' acs.se(estimate, wa.house16)
#'
#' # Standard error of median household income in Washington State in 2016
#' acs.se(acs.median, wa.house16, 'HINCP')
#'
#' # Standard error of proportion of Washington STate households that pay cash rent
#' acs.se(proportion, subset(wa.house16, TEN==3), wa.house16)
#'
#' @export
acs.se <- function(f, x, ...){
  pt.est <- f(x, ...)
  rep.ests <- sapply(1:80, function(n) f(x, ..., wt.rep.num=n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}
