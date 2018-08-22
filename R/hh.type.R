#' Classify households by type
#'
#' Classifies each household as vacant, one person, a couple, a family with
#' children present, or a composite household (none of the above).
#' Note that \code{house} has to be full ACS PUMS housing data, not the
#' subset of columns used in \code{wa.house16}.
#'
#' @param house ACS housing data or subset
#'
#' @return character vector of household type
#'
#' @importFrom dplyr case_when
#'
#' @export
hh.type <- function(house){
  vars.used <- c('NP', 'HHT', 'PARTNER', 'HUPAC')
  if(!(all(vars.used %in% names(house)))){
    stop('Data must have columns: NP, HHT, PARTNER, HUPAC')
  }
  with(house,
        case_when(
          NP==0 ~ 'Vacant',
          NP==1 ~ 'One.Person',
          (NP==2) & (HHT==1 | PARTNER %in% 1:4) ~ 'Couple',
          HUPAC %in% 1:3 ~ 'Family',
          TRUE ~ 'Composite'
          )
       )
}
