#' Estimate proportion of a population in a subset for ACS PUMS data
#'
#' Compute the proportion of a population in a subset defined by a list
#' of conditions. The conditions are combined with a logical-and.
#' The conditions should be bare expressions, not strings.
#' This function uses \code{quos} from \code{rlang}.
#'
#' @param x data.frame or similar with data filtered to relevant rows.
#' @param ... a list of conditions that define the subset,
#'            as bare expressions, not as strings
#' @param wt.rep.num the weight replicate number, if a replicate weight
#'
#' @return point estimate of the proportion of population in subset
#'
#' @importFrom dplyr quos filter
#'
#' @examples
#' # Fraction of Washington State households that pay cash rent
#' prop.cond(wa.house16, TEN==3)
#'
#' # Fraction of Washington State renter households that have only 1 person.
#' prop.cond(wa.house, TEN==3, NP==1)
#'
#' # Fraction of Washington State households that are rent-burdened renters
#' # A household is rent-burdened if it pays more than 30% of its income in rent.
#' # GRNTP is monthly gross rent, HINCP is annual household income
#' prop.cond(wa.house16, 12 * GRNTP > 0.3 * HINCP)
#'
#' @export
prop.cond <- function(x, ..., wt.rep.num = NULL){
  cond.list <- quos(...)
  top <- filter(x, !!! cond.list)
  proportion(top, x, wt.rep.num)
}
