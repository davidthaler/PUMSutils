#' Compute weighted mean of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the mean of \code{mean.var} across groups defined by \code{gp.var} and
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param gp.var name of variable in x to group data by, a string
#' @param mean.var (string) name of a numerical column in x to average over
#' @param drop.na.group drop the group where \code{gp.var} is NA; default TRUE
#' @param result.name name of estimate column in result.
#'        Default is 'Mean'.
#'
#' @return data frame of mean, standard error of the mean,
#'         and the margin of error of the mean of \code{mean.var}
#'         over the groups defined by \code{gp.var} and for the whole data.
#'
#' @examples
#' # Average household size by tenure for Washington State in 2016
#' group.mean(wa.house16, 'TEN', 'NP', result.name='Mean.HH.Size', drop.na.group=TRUE)
#'
#' @export
group.mean <- function(x, gp.var, mean.var, result.name=NULL, drop.na.group=TRUE){
  result.name <- ifelse(is.null(result.name), 'Mean', result.name)
  group.estimate(x, acs.mean, gp.var, mean.var, result.name=result.name,
                 drop.na.group = drop.na.group)
}
