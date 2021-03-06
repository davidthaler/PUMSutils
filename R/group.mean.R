#' Compute weighted mean of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the mean of \code{mean.var} across groups defined by \code{gp.var} and
#' over the whole data.
#'
#' @param x a data frame of PUMS data. If x is already grouped, then this
#'        function optionally adds a level to the grouping.
#' @param gp.var name of variable in x to group data by (string) or NULL
#'        if x is grouped and you do not want to add a level of grouping.
#'        May not be NULL if x is not grouped.
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
group.mean <- function(x, gp.var, mean.var, result.name='Mean', drop.na.group=TRUE){
  group.estimate(x, acs.mean, gp.var, mean.var, result.name=result.name,
                 drop.na.group = drop.na.group)
}
