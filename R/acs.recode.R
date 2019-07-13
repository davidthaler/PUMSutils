#' Rewrite variable levels using data dictionary
#'
#' In the ACS PUMS data, many fields are integer-coded categoricals.
#' There is a data dictionary (a text document) that describes the mapping
#' from integers to level definitions. Function \code{acs.recode} takes
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
#' wa.pop16$employment <- acs.recode(wa.pop16, 'ESR', data.dict16, max.len=40)
#' group.count(wa.pop16, 'employment')
#'
#' @export
acs.recode <- function(x, field, dd, max.len=NULL){
  field.desc <- acs.describe(dd, field, max.len=max.len)
  if(length(unique(field.desc$Levels$Level)) !=
     length(unique(field.desc$Levels$Level.Desc))){
    stop('Field names not unique after truncation to ', max.len)
  }
  if(is.character(field.desc$Levels$Level)){
    stop(field, ' is not categorical; cannot recode')
  }
  acs.translate(x, field,
                old=field.desc$Levels$Level,
                new=field.desc$Levels$Level.Desc)
}
