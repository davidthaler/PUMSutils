#' Compute weighted size of groups in ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the size of the groups defined by \code{gp.var} and the whole data.
#'
#' @param x a data frame of PUMS data
#' @param gp.var name of variable in x to group data by, a string
#' @param result.name name of estimate column in result.
#'        Default is 'Count'.
#' @param drop.na.group drop the group where \code{gp.var} is NA; default FALSE
#'
#' @return data frame of count, standard error of the count,
#'         and the margin of error of the count over the groups
#'         defined by \code{gp.var} and for the whole data.
#'
#' @examples
#' # Count of occupied households by tenure type for Washington State in 2016
#' group.count(wa.house16, 'TEN', result.name='Occ.HH', drop.na.group=TRUE)
#'
#' @export
group.count <- function(x, gp.var, result.name=NULL, drop.na.group=FALSE){
  result.name <- ifelse(is.null(result.name), 'Count', result.name)
  group.estimate(x, estimate, gp.var, result.name=result.name,
                 drop.na.group=drop.na.group)
}
