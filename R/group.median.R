#' Compute weighted median of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the median of `med.var` across groups defined by `gp.var` and
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param result.name name of estimate column in result
#' @param gp.var name of variable in x to group data by, a string
#' @param med.var (string) name of a numerical column in `x` to take median over
#' @param drop.na.group drop the group where `gp.var` is NA
#'
#' @return data frame of median, standard error of the median,
#'         and the margin of error of the median of `med.var`
#'         over the groups defined by `gp.var` and for the whole data.
#'
#' @examples
#' # Median income by tenure type for Washington State in 2016
#' group.median(wa.house16, 'Med.HH.Inc', 'TEN', 'HINCP', drop.na.group=TRUE)
#'
#' @export
group.median <- function(x,result.name, gp.var, med.var, drop.na.group){
  group.estimate(result.name, acs.median, x, gp.var, med.var,
                 drop.na.group = drop.na.group)
}
