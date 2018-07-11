#' Compute aggregate of numerical column on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' aggregate of \code{tot.var} across groups defined by \code{gp.var} and
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param gp.var name of variable in x to group data by, a string
#' @param tot.var (string) name of a numerical column in x to aggregate
#' @param result.name name of estimate column in result.
#'        Default is 'Total.
#' @param drop.na.group drop the group where \code{gp.var} is NA; default TRUE
#'
#' @return data frame of aggregate, standard error of the aggregate,
#'         and the margin of error of the aggregate of \code{tot.var}
#'         over the groups defined by \code{gp.var} and for the whole data.
#'
#' @examples
#' # Total household population of Washington State in 2016
#' group.total(wa.house16, 'TEN', 'NP', result.name='HH.Pop', drop.na.group=TRUE)
#'
#' @export
group.total <- function(x, gp.var, tot.var, result.name=NULL, drop.na.group=TRUE){
  result.name <- ifelse(is.null(result.name), 'Total', result.name)
  group.estimate(x, acs.total, gp.var, tot.var, result.name=result.name,
                 drop.na.group = drop.na.group)
}
