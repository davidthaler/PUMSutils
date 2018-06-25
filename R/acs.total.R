#' Compute a weighted total of a numerical field in ACS PUMS data.
#'
#' Computes an estimate of a total of a numerical field in the
#' ACS PUMS data using the correct sample weights. Note that these
#' values may be slightly in error due to top or bottom coding of some
#' numeric variables.
#'
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field the data field to take the median of
#' @param wt.rep.num the weight replicate number, if a replicate weight
#'
#' @return an estimate of the weighted total of field in the data
#'
#' @examples
#' # Estimated total rent paid by reters in Washington State in 2016.
#' 12 * acs.total(wa.house16, 'GRNTP')
#'
#' @export
acs.total <- function(x, field, wt.rep.num=NULL){
  wt.field <- get.weight(x, wt.rep.num)
  x.mask <- x[is.finite(x[[field]]), ]
  sum(x.mask[[wt.field]] * as.numeric(x.mask[[field]]))
}
