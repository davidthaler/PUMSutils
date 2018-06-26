#' Estimate count using ACS PUMS data.
#'
#' Estimates a total of the population or sub-group in this data.
#'
#' @param x data.frame or similar with data filtered to relevant rows.
#' @param wt.rep.num the weight replicate number, if a replicate weight
#'
#' @return an estimate of the population total for this data.
#'
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2016_PUMS_README.pdf}
#' @export
#'
estimate <- function(x, wt.rep.num=NULL){
  wt.field <- get.weight(x, wt.rep.num)
  sum(as.numeric(x[[wt.field]]))
}
