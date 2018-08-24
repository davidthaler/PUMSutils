#' Load ACS PUMS csv files in a ready-to-use form.
#'
#' Load the ACS PUMS data from a csv file with the data types set correctly.
#' Mostly, this is integer with the following exceptions: the record type, \code{RT},
#' is meaningless so it is dropped; \code{SERIALNO} is loaded as a string because it
#' overflows on 5-year data when loaded as an integer (it is only used for
#' joins so this is fine); the inflation factors \code{ADJINC} and \code{ADJHSG} are provided
#' as 7-digit integers equal to the inflation factor times \code{1e6} and then rounded,
#' they are returned as floats after multiplication by \code{1e-6}.
#'
#' @param path path to a csv file with ACS PUMS housing or population data.
#'
#' @return data frame with ACS PUMS housing or population data from a csv file
#'
#' @export
load.pums <- function(path){
  top <- readr::read_csv(path, col_types=readr::cols(.default = 'c'), n_max = 10)
  if('SEX' %in% names(top)){
    # ACS PUMS person record
    pums <- readr::read_csv(path, col_types = readr::cols(RT='_', SERIALNO='c',
                                                          NAICSP='c', SOCP='c',
                                                          .default='i'))
    pums$ADJINC <- pums$ADJINC * 1e-6
  }else if('SERIALNO' %in% names(top)){
    # ACS PUMS housing record
    pums <- readr::read_csv(path, col_types = readr::cols(RT='_', SERIALNO='c', .default='i'))
    pums$ADJINC <- pums$ADJINC * 1e-6
    pums$ADJHSG <- pums$ADJHSG * 1e-6
  }else{
    stop('This does not appear to be an ACS PUMS dataset.')
  }
  pums
}
