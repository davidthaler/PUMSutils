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
