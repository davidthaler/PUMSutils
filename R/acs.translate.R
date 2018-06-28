#' Rewrite values in ACS PUMS data
#'
#' Many variables in the ACS PUMS data are integer-coded categorical values.
#' For readability, we often want to replace these with strings or factors.
#' \code{acs.translate} takes the values in the variable \code{field} and
#' substitutes elements of \code{new} for the corresponing element of \code{old}.
#' The result is a factor with the levels in the order of \code{level.order} if used,
#' or in the order of \code{unique(new)} otherwise.
#'
#' @param x a data frame of PUMS data
#' @param field string name of the field in x to translate
#' @param old vector of the unique values in \code{x$field}
#' @param new vector of replacement values (strings).
#'        Must be same length as \code{old}, but values do not have
#'        to be unique (see example).
#' @param level.order order to give to factor levels, if used.
#'        Default NULL uses ordering of \code{unique(new)}
#'
#' @return factor vector of same length as \code{x$field} with values from
#'         \code{new} substituted for the originals
#'
#' @examples
#' new.vals <- c('own','own','rent', 'rent', 'vacant')
#' wa.house16$Tenure <- acs.translate(wa.house16, 'TEN', c(1:4, NA), new.vals)
#' group.count(wa.house16, 'HH.Count', 'Tenure')
#'
#' # Strings would not be in this order
#' in.order <- c('vacant', 'own', 'rent')
#' wa.house16$Tenure <- acs.translate(wa.house16, 'TEN', c(1:4, NA),
#'                                    new.vals, level.order=in.order)
#' group.count(wa.house16, 'HH.Count', 'Tenure')
#'
#' @export
#'
acs.translate <- function(x, field, old, new, level.order=NULL){
  out <- plyr::mapvalues(x[[field]], old, new)
  if(is.null(level.order)){
    level.order <- unique(new)
  }
  out <- factor(out, levels=level.order)
  out
}
