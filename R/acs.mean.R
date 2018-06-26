#' Estimates means from the ACS PUMS data.
#'
#' Estimates the mean of the data field over the population
#' represented by a sample drawn from ACS PUMS data.
#'
#' @note some ACS fields are top-coded, so their means are not correct,
#' check the data dictionary or the PUMS Readme for more.
#'
#' @param x data.frame or similar with data filtered to relevant rows
#' @param field the data field to take the mean over
#' @param  wt.rep.num the weight replicate number, if a replicate weight
#'
#' @return an estimate of the mean of the data field over this data
#'
#' @importFrom Hmisc wtd.mean
#'
#' @references \url{http://www2.census.gov/programs-surveys/acs/tech_docs/pums/ACS2016_PUMS_README.pdf}
#'
#' @export
#'
acs.mean <- function(x, field, wt.rep.num=NULL){
  wt.field <- get.weight(x, wt.rep.num)
  wtd.mean(as.numeric(x[[field]]),
           weights = as.numeric(x[[wt.field]]))
}
