#' Get Expansion Weight From ACS PUMS Data.
#' 
#' Extracts an expansion weight or weight replicate from either ACS housing 
#' or population data, regardless of case (which varies).
#' Fails with error if the requested weight is not present.
#'
#' @param data ACS housing or population data frame
#' @param wt.rep.num The weight replicate number, if a replicate weight
#'      default is NULL for a point estimate
#'
#' @importFrom stringr regex str_detect
#' 
#' @return The correct weight name in this data.
#' 
#' @export
#' 
get.weight <- function(data, wt.rep.num=NULL){
  if(!(is.null(wt.rep.num) || (wt.rep.num %in% 1:80))){
    stop('wt.rep.num must either be NULL or in range of 1:80')
  }
  pat <- regex(paste0('(^wgtp|^pwgtp)', wt.rep.num, '$'), ignore_case = TRUE)
  out <- names(data)[str_detect(names(data), pat)]
  if(length(out)==0){
    stop('Weight not found. Is this an ACS population or housing data set?')
  }else{
    out
  }
}