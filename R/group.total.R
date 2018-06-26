#' Compute aggregate of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' aggregate of `tot.var` across groups defined by `gp.var` and
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param result.name name of estimate column in result
#' @param gp.var name of variable in x to group data by, a string
#' @param tot.var (string) name of a numerical column in `x` to aggregate
#' @param drop.na.group drop the group where `gp.var` is NA; default TRUE
#'
#' @return data frame of aggregate, standard error of the aggregate,
#'         and the margin of error of the aggregate of `tot.var`
#'         over the groups defined by `gp.var` and for the whole data.
#'
#' @examples
#' # Total household population of Washington State in 2016
#' group.total(x, 'HH.Pop', 'TEN', 'NP', drop.na.group=TRUE)
#'
#' @export
group.total <- function(x, result.name, gp.var, tot.var, drop.na.group=TRUE){
  group.estimate(result.name, acs.total, x, gp.var, tot.var,
                 drop.na.group = drop.na.group)
}
