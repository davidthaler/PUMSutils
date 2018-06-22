#' Median of Field in ACS PUMS Data
#'
#' Estimates the median of a field in the ACS PUMS data, using the sample weights.
#'
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field the data field to take the median of
#' @param wt.rep.num the weight replicate number, if a replicate weight
#'
#' @return median for a field in the data
#'
#' @export
#'
acs.median <- function(x, field, wt.rep.num=NULL){
  acs.quantile(x, field, 0.5, wt.rep.num)
}

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
#' @export
#'
acs.quantile <- function(x, field,
                         probs=c(0.1, 0.25, 0.5, 0.75, 0.9),
                         wt.rep.num=NULL){
  wt.field <- get.weight(x, wt.rep.num)
  Hmisc::wtd.quantile(x[[field]], weights=x[[wt.field]], probs=probs)
}

