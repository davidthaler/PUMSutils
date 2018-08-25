#' Load ACS PUMS csv files in a ready-to-use form.
#'
#' Load the ACS PUMS data from a csv file with the data types set correctly.
#' Most fields in the ACS data are simple integers, but a few are not.
#' See the details section for specifics.
#'
#' Most fields in the ACS PUMS data are either integer-coded categoricals or
#' counts, but there are exceptions, and the exceptions vary by year and span
#' (1 year or 5 year data). This function loads most fields as integers and handles
#' the exceptions correctly. The exceptions are:
#'
#' 1. \code{RT}, the record type, is 'H' in housing records and 'P' in person
#' records. For any given file, it is constant so it is dropped.
#'
#' 2. \code{SERIALNO}, is loaded as a string because it overflows on
#' 5-year data as an integer. It is only used for joining person records
#' to housing records so this is fine.
#'
#' 3. Inflation factors. In older data, this is just \code{ADJUST}.
#' In recent years, housing data has \code{ADJINC} and \code{ADJHSG},
#' and person records have just \code{ADJINC}. In any case, they are
#' 7-digit integers equal to the inflation factor times \code{1e6}.
#' This function returns them as floats after multiplication by \code{1e-6}.
#'
#' 4. \code{NAICSP} is an occupation code. It is quasi-numeric with a few
#' values like "33641M1". It is returned as a character column.
#'
#' 5. \code{SOCP} or \code{SOCP10} and \code{SOCP12}. These are quasi-numeric
#' occupation codes like \code{NAICSP}. They have a few values like "4750XX".
#' In 1-year files and some 5-year files, \code{SOCP} is present. In other
#' files both \code{SOCP10} and \code{SOCP12} are present. In either case,
#' they are returned as character columns.
#'
#' 6. \code{OCCP} or \code{OCCP10} and \code{OCCP12} are occupation codes.
#' \code{OCCP10} and \code{OCCP12} are nearly numeric; they include two NA
#' values, one for not in labor force and the other indicates that the code
#' for that row is under the other system. They are loaded as character columns
#' to preserve that information. \code{OCCP} can load as numeric, but it is
#' loaded as character for consistency with \code{OCCP10} and \code{OCCP12}.
#'
#' @param path path to a csv file with ACS PUMS housing or population data.
#'
#' @return data frame with ACS PUMS housing or population data from a csv file
#'
#' @export
load.pums <- function(path){
  top <- readr::read_csv(path, col_types=readr::cols(.default = 'c'), n_max = 10)
  if('SEX' %in% names(top)){
    # 'SEX' is in the ACS PUMS person records

    # Start the column specification
    colspec <- readr::cols(RT='_', SERIALNO='c', NAICSP='c', .default='i')

    # Some of these fields will be present, and should be col_character().
    # OCCP* almost numeric, but OCCP10/12 have 2 NA values (NILF & other code)
    odds <- c('SOCP', 'SOCP10', 'SOCP12', 'OCCP', 'OCCP10', 'OCCP12')
    char.cols <- intersect(names(top), odds)
    for(colname in char.cols){
      colspec$cols[[colname]] <- readr::col_character()
    }

    pums <- readr::read_csv(path, col_types = colspec)
  }else if('SERIALNO' %in% names(top)){
    pums <- readr::read_csv(path, col_types = readr::cols(RT='_',
                                                          SERIALNO='c',
                                                          .default='i'))
  }else{
    stop('This does not appear to be an ACS PUMS dataset.')
  }

  # Set whatever inflation rates are present to floats w/6 dp
  infl.rates <- intersect(names(top), c('ADJUST', 'ADJINC', 'ADJHSG'))
  for(ir in infl.rates){
    pums[[ir]] <- 1e-6 * pums[[ir]]
  }
  pums
}
