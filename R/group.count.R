#' Compute weighted size of groups in ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the size of the groups defined by \code{gp.var} and the whole data.
#'
#' @param x a data frame of PUMS data
#' @param result.name name of estimate column in result
#' @param gp.var name of variable in x to group data by, a string
#' @param drop.na.group drop the group where \code{gp.var} is NA; default FALSE
#'
#' @return data frame of count, standard error of the count,
#'         and the margin of error of the count over the groups
#'         defined by \code{gp.var} and for the whole data.
#'
#' @examples
#' # Count of occupied households by tenure type for Washington State in 2016
#' group.count(wa.house16, 'Occ.HH', 'TEN', drop.na.group=TRUE)
#'
#' @export
group.count <- function(x, result.name, gp.var, drop.na.group=FALSE){
  group.estimate(result.name, estimate, x, gp.var, drop.na.group=drop.na.group)
}
