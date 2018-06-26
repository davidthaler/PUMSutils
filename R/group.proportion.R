#' Compute proportion of group sizes on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the proportion of sizes of the groups defined by `gp.var`.
#'
#' @param x a data frame of PUMS data
#' @param result.name name of estimate column in result
#' @param gp.var name of variable in x to group data by, a string
#' @param drop.na.group drop the group where `gp.var` is NA
#'
#' @return data frame of proportion, standard error of the proportion,
#'         and the margin of error of the proportion of the sizes of
#'         the groups defined by `gp.var`.
#'
#' @examples
#' # Fraction of occupied households by tenure type for Washington State in 2016
#' group.proportion(wa.house16, 'HH.Pct', 'TEN', drop.na.group=TRUE)
#'
#' @export
group.proportion <- function(x, result.name, gp.var, drop.na.group=TRUE){
  if(drop.na.group){
    x <- filter(x, is.finite(x[[gp.var]]))
  }
  group.estimate(result.name, proportion, x, gp.var, x,
                 drop.na.group = drop.na.group, include.total = FALSE)
}
