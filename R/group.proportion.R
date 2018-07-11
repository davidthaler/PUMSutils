#' Compute proportion of group sizes on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the proportion of sizes of the groups defined by \code{gp.var}.
#'
#' @param x a data frame of PUMS data
#' @param gp.var name of variable in x to group data by, a string
#' @param result.name name of estimate column in result
#'        Default is "Pct.".
#' @param drop.na.group drop the group where \code{gp.var} is NA
#'
#' @return data frame of proportion, standard error of the proportion,
#'         and the margin of error of the proportion of the sizes of
#'         the groups defined by \code{gp.var}.
#'
#' @examples
#' # Fraction of occupied households by tenure type for Washington State in 2016
#' group.proportion(wa.house16, 'TEN', result.name='HH.Pct', drop.na.group=TRUE)
#'
#' @export
group.proportion <- function(x, gp.var, result.name='Pct.', drop.na.group=TRUE){
  if(drop.na.group){
    x <- filter(x, is.finite(x[[gp.var]]))
  }
  group.estimate(x, proportion, gp.var, x, result.name=result.name,
                 drop.na.group = drop.na.group, include.total = FALSE)
}
