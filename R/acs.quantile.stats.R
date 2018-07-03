#' Compute quantiles and standard errors of quantiles on ACS PUMS data
#'
#' Estimate a range of quantiles on ACS PUMS data using the sample weights for the
#' point estimate and the direct method, involving the replicate weights for
#' estimating the standard errors of those quantiles.
#'
#' @param x a data frame of PUMS data
#' @param field (string) name of a numerical field to take the quantiles over
#' @param result.name name of estimate column in result; default is \code{field}
#' @param probs a vector of quantiles to take; decimals in \code{[0.0, 1.0]}
#'
#' @return data.frame containing point estimate, standard error, and 90%
#' margin-of-error for the selected quantiles of \code{x$field}
#'
#' @examples
#' # Some quantiles of household income for Washington State in 2016
#' acs.quantile.stats(wa.house16, 'HINCP', 'HH.Income')
#'
#' @export
acs.quantile.stats <- function(x, field, result.name=NULL,
                           probs=c(0.1, 0.25, 0.5, 0.75, 0.9)){
  if(is.null(result.name)) result.name <- field
  pt.est <- acs.quantile(x, field=field, probs=probs)
  fn <- function(n) acs.quantile(x, field=field, probs=probs, wt.rep.num=n)
  rep.ests <- sapply(1:80, fn)
  SE <- sqrt((4/80) * rowSums((pt.est - rep.ests)^2))
  out <- data.frame(SE=SE, MoE=1.645 * SE)
  out[result.name] <- pt.est
  out[c(result.name, 'SE', 'MoE')]
}
