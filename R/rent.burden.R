#' Define rent burden of households.
#'
#' Households are said to be rent-burdened if their rent is more than 30%
#' of household income.
#' This function cuts the variable \code{GRPIP} in the housing data,
#' which is gross rent as a percentage of household income, into bins
#' for rent below 30%, 30% to 40%, 40% to 50% and above 50% of income.
#'
#' @param house a data frame of PUMS housing data
#'
#' @return factor column with levels of rent burden for households
#'
#' @importFrom Hmisc cut2
#'
#' @examples
#' wa.house16$Rent.Burden <- rent.burden(wa.house16)
#' group.count(wa.house16, 'Rent.Burden', drop.na.level=TRUE)
#'
#' @export
rent.burden <- function(house){
  out <- cut2(house$GRPIP, cuts=c(30, 40, 50))
  levels(out) <- c('No Burden', '30%-39%', '40%-49%', '50%+')
  out
}
