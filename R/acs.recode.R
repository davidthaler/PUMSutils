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
#' @param max.len max length of description in characters, default is all
#'
#' @return factor column with integer levels in \code{x[field]} replaced
#'         with the desciption for that level from the data dictionary.
#'
#' @examples
#' library(readr)
#' # Get file path for data dict, which is in inst/extdata/ in the package
#' dd.file <- system.file('extdata', 'PUMS_Data_Dictionary_2016.txt',
#'                package='PUMSutils', mustWork=TRUE)
#' dd <- read_file(dd.file)
#' wa.pop16$employment <- acs.recode(wa.pop16, 'ESR', dd, max.len=40)
#' group.count(wa.pop16, 'employment')
#'
#' @export
acs.recode <- function(x, field, dd, max.len=-1){
  levelmap <- levels.df(dd, field, max.len=max.len)
  acs.translate(x, field, old=levelmap$level.num, new=levelmap$text)
}
