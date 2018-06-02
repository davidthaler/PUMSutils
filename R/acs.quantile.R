#' Median of Field in ACS PUMS Data
#' 
#' Estimates the median of a field in the ACS PUMS data, using the sample weights.
#' 
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field the data field to take the median of
#' 
#' @return median for a field in the data
#'
#' @export
#' 
acs.median <- function(x, field){
  acs.quantile(x, field, 0.5)
}

#' Quantiles for ACS PUMS Data.
#' 
#' Estimate a range of quantiles on the ACS PUMS Data, using sample weights.
#' 
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field the data field to take the quantiles over
#' @param probs a vector of quantiles to take
#' 
#' @return a vector of quantiles for the selected field over the given data
#' 
#' @export
#' 
acs.quantile <- function(x, field, probs=c(0.1, 0.25, 0.5, 0.75, 0.9)){
  wt.field <- get.weight(x)
  Hmisc::wtd.quantile(x[[field]], weights=x[[wt.field]], probs=probs)
}

