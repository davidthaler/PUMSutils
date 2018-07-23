#' Describe Households as Renters or Owners
#'
#' In the ACS PUMS data, housing tenure is described with a 4-level
#' integer-coded categorical that uses NA to mark vacant units.
#' This function recodes tenure to a 3-level factor with no NA's.
#' The levels are 'Own', 'Rent' and 'Vacant/GQ'.
#'
#' @param house a data frame of PUMS housing data
#'
#' @return a factor column of recoded tenure
#'
#' @examples
#' wa.house16$Tenure <- own.rent(wa.house16)
#' group.count(wa.house16, 'Tenure')
#'
#' @export
own.rent <- function(house){
  acs.translate(house, 'TEN', c(1,2,3,4,NA),
                c('Own', 'Own', 'Rent', 'Rent', 'Vacant/GQ'))
}
