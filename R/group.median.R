#' Compute weighted median of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the median of \code{med.var} across groups defined by \code{gp.var} and
#' over the whole data.
#'
#' @param x a data frame of PUMS data. If x is already grouped, then this
#'        function optionally adds a level to the grouping.
#' @param gp.var name of variable in x to group data by (string) or NULL
#'        if x is grouped and you do not want to add a level of grouping.
#'        May not be NULL if x is not grouped.
#' @param med.var (string) name of a numerical column in x to take median over
#' @param result.name name of estimate column in result.
#'        Default is 'Median'
#' @param drop.na.group drop the group where \code{gp.var} is NA; default TRUE
#'
#' @return data frame of median, standard error of the median,
#'         and the margin of error of the median of \code{med.var}
#'         over the groups defined by \code{gp.var} and for the whole data.
#'
#' @examples
#' # Median income by tenure type for Washington State in 2016
#' group.median(wa.house16, 'TEN', 'HINCP', result.name='Med.HH.Inc',
#'              drop.na.group=TRUE)
#'
#' @export
group.median <- function(x, gp.var, med.var, result.name='Median', drop.na.group=TRUE){
  group.estimate(x, acs.median, gp.var, med.var, result.name=result.name,
                 drop.na.group = drop.na.group)
}
