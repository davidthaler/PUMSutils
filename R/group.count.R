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
#' group.count(wa.house16, 'TEN')
#'
#' # Example using data grouped with group_by
#' library(dplyr)
#' wa.house16$Size <- clip.column(wa.house16, 'NP', 5)
#' gp <- group_by(wa.house16, TEN)
#' group.count(gp, 'Size')
#'
#' @export
group.count <- function(x, gp.var, result.name='Count', drop.na.group=FALSE){
  group.estimate(x, estimate, gp.var, result.name=result.name,
                 drop.na.group=drop.na.group)
}
