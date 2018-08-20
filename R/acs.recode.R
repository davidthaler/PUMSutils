#' Rewrite variable levels using data dictionary
#'
#' In the ACS PUMS data, many fields are integer-coded categoricals.
#' There is a data dictionary (a text document) that describes the mapping
#' from integers to level definitions. Function \code{rename.levels} takes
#' the data dicitonary as a string and uses it to construct a factor variable
#' that recodes integer levels to the text definitions given in the data
#' dictionary.
#'
#' @param x ACS PUMS data frame
#' @param field column name for a variable in the ACS PUMS data
#' @param dd the ACS data dictionary loaded as a string
#'
#' @return factor column with integer levels in \code{x[field]} replaced
#'         with the desciption for that level from the data dictionary.
#'
#' @export
acs.recode <- function(x, field, dd){
  levelmap <- levels.df(dd, field)
  acs.translate(x, field, old=levelmap$level.num, new=levelmap$text)
}
