#' Compute standard errors for ACS PUMS data by the direct method
#'
#' This function uses weight replicates to compute direct standard errors
#' on the ACS PUMS data for any statistic.
#' It is mainly for internal use (the function signature is tricky),
#' but it can be used to compute standard errors for any statistic,
#' inclding user-defined ones, so it is exported.
#' The argument `f` is a function that takes only one argument,
#' called wt.rep.num, which is a weight replicate number from 1...80.
#' That means that it must already be bound to any data and paramters it needs.
#' It should return the value of the statistic over its data,
#' based on the weight replicate number used.
#' See `estimate` or `proportion` for an example of how to do that.
#' See the ACS PUMS readme document referenced below for the details of
#' the calculation of the direct standard errors.
#'
#' @param f a function that takes a weight replicate number called wt.rep.num,
#'          with a default value of NULL
#'
#' @return the standard error of the statistic defined by f over the data
#'
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2016_PUMS_README.pdf}
#'
#' @examples
#' # Ground-truth
#' acs.mean(wa.house16, 'GRNTP')
#' se.acs.mean(wa.house16, 'GRNTP')
#'
#' # using a closure
#' my.closure <- function(x, field) function(wt.rep.num=NULL) acs.mean(x, f, n)
#' f <- my.closure(wa.house16, 'GRNTP')
#' f()
#' acs.se(f)
#'
#' # using purr::partial
#' f <- purr::partial(acs.mean, x=wa.house16, field='GRNTP')
#' f()
#' acs.se(f)
#'
#' @export
#'
acs.se <- function(f){
  pt.est <- f()
  rep.ests <- sapply(1:80, function(n) f(wt.rep.num=n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}
