#' Compute weighted mean of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the mean of \code{mean.var} across groups defined by \code{gp.var} and
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param result.name name of estimate column in result
#' @param gp.var name of variable in x to group data by, a string
#' @param mean.var (string) name of a numerical column in x to average over
#' @param drop.na.group drop the group where \code{gp.var} is NA; default TRUE
#'
#' @return data frame of mean, standard error of the mean,
#'         and the margin of error of the mean of \code{mean.var}
#'         over the groups defined by \code{gp.var} and for the whole data.
#'
#' @examples
#' # Average household size by tenure for Washington State in 2016
#' group.mean(wa.house16, 'Mean.HH.Size', 'TEN', 'NP', drop.na.group=TRUE)
#'
#' @export
group.mean <- function(x, result.name, gp.var, mean.var, drop.na.group=TRUE){
  group.estimate(result.name, acs.mean, x, gp.var, mean.var,
                 drop.na.group = drop.na.group)
}
