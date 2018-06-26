#' Compute estimates and standard errors on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' any statistic across groups defined by \code{gp.var} and (optionally)
#' over the whole data.
#'
#' @param result.name name of estimate column in result
#' @param f a function to calculate the statistic.
#'        It must take data and a weight replicate number called wt.rep.num
#'        with a default value of NULL.
#' @param x a data frame of PUMS data
#' @param gp.var name of variable in x to group data by, a string
#' @param ... other data passed to f
#' @param include.total include the total across all groups, default TRUE
#' @param drop.na.group default FALSE, drop the group where `gp.var` is NA
#'
#' @importFrom dplyr group_by_ do filter
#'
#' @return data frame of estimate, standard error of the estimate,
#'         and the margin of error of the estimate, for the statistic
#'         defined by `f` , over the groups defined by \code{gp.var}
#'         and (optionally) the whole data.
#'
#' @examples
#' # Total of occupied households in Washington State in 2016
#' group.estimate('HH.Ct', estimate, wa.house16, 'TEN', drop.na.group=TRUE)
#'
#' # 90% household income by tenure type for Washington State in 2016
#' group.estimate('HH.Inc90', acs.quantile, wa.house16, 'TEN',
#'                field='HINCP', probs=0.9, drop.na.group = TRUE)
#'
#' @export
group.estimate <- function(result.name, f, x, gp.var, ...,
                               drop.na.group=FALSE, include.total=TRUE){
  if(drop.na.group){
    x <- filter(x, is.finite(x[[gp.var]]))
  }
  gp <- group_by_(x, gp.var)
  out <- as.data.frame(do(gp, line.estimate(result.name, f, ., ...)))
  if(include.total){
    le <- line.estimate(result.name, f, x, ...)
    le[gp.var] = 'All'
    out <- rbind(out, le)
  }
  out
}
