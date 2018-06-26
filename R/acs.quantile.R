#' Quantiles for ACS PUMS Data.
#'
#' Estimate a range of quantiles on the ACS PUMS Data, using sample weights.
#'
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field the data field to take the quantiles over
#' @param probs a vector of quantiles to take
#' @param wt.rep.num the weight replicate number, if a replicate weight
#'
#' @return a vector of quantiles for the selected field over the given data
#'
#' @importFrom Hmisc wtd.quantile
#'
#' @export
#'
acs.quantile <- function(x, field,
                         probs=c(0.1, 0.25, 0.5, 0.75, 0.9),
                         wt.rep.num=NULL){
  wt.field <- get.weight(x, wt.rep.num)
  wtd.quantile(x[[field]], weights=x[[wt.field]], probs=probs)
}

