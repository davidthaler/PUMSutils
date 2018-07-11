#' Compute an estimate and standard error from ACS PUMS data.
#'
#' Compute point estimate, standard error and 90% margin of error
#' of any statistic on ACS PUMS data using the direct method,
#' involving replicate weights and return results on one line.
#'
#' @param x a data frame of PUMS data.
#' @param f a function to calculate the statistic.
#'        It must take data and a weight replicate number called
#'        \code{wt.rep.num} with a default value of NULL.
#' @param ... other data passed to f
#' @param result.name name of estimate column in result.
#'        Default of NULL uses \code{deparse(substitute(f))}.
#'
#' @return the point estimate, standard error and 90% margin of error
#' for the size of this sample.
#'
#' @examples
#' # Number of households in Washington State in 2016
#' line.estimate(wa.house16, estimate)
#'
#' # Fraction of Washington State households that rent for cash
#' line.estimate(subset(wa.house16, TEN==3), proportion, wa.house16,
#'               result.name='Renters.Pct')
#'
#' @export
line.estimate <- function(x, f, ..., result.name=NULL){
  out <- list()
  if(is.null(result.name)){
    result.name <- deparse(substitute(f))
  }
  out[[result.name]] <- f(x, ...)
  out$SE <- acs.se(x, f, ...)
  out$MoE <- 1.645 * out$SE
  as.data.frame(out)
}
