#' Compute an estimate and standard error from ACS PUMS data.
#'
#' Compute point estimate, standard error and 90% margin of error
#' of any statistic on ACS PUMS data using the direct method,
#' involving replicate weights and return results on one line.
#'
#' @param result.name name of estimate column in result
#' @param f a function to calculate the statistic.
#'        It must take data and a weight replicate number called wt.rep.num
#'        with a default value of NULL.
#' @param x a data frame of PUMS data.
#' @param ... other data passed to f
#'
#' @return the point estimate, standard error and 90% margin of error
#' for the size of this sample.
#'
#' @examples
#' # Number of households in Washington State in 2016
#' line.estimate('HH.Units', estimate, wa.house16)
#'
#' # Fraction of Washington State households that rent for cash
#' line.estimate('Renters.Pct', proportion, subset(wa.house16, TEN==3), wa.house16)
#'
#' @export
line.estimate <- function(result.name, f, x, ...){
  out <- list()
  out[[result.name]] <- f(x, ...)
  out$SE <- acs.se(f, x, ...)
  out$MoE <- 1.645 * out$SE
  as.data.frame(out)
}
