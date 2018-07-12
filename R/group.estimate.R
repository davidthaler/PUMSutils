#' Compute estimates and standard errors on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' any statistic across groups defined by \code{gp.var} and (optionally)
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param f a function to calculate the statistic.
#'        It must take data and a weight replicate number called
#'        \code{wt.rep.num} with a default value of NULL.
#' @param gp.var name of variable in x to group data by, a string
#' @param ... other data passed to f
#' @param result.name name of estimate column in result.
#'        Default of NULL uses \code{deparse(substitute(f))}.
#' @param include.total include the total across all groups, default TRUE
#' @param drop.na.group default FALSE, drop the group where \code{gp.var} is NA
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
#' group.estimate(wa.house16, estimate, 'TEN', drop.na.group=TRUE)
#'
#' # 90% household income by tenure type for Washington State in 2016
#' group.estimate(wa.house16, acs.quantile, 'TEN', field='HINCP',
#'                probs=0.9, result.name='HH.Inc90', drop.na.group = TRUE)
#'
#' @export
group.estimate <- function(x, f, gp.var, ..., result.name=NULL,
                               drop.na.group=FALSE, include.total=TRUE){
  if(is.null(result.name)) result.name <- deparse(substitute(f))
  if(drop.na.group){
    x <- filter(x, !is.na(x[[gp.var]]))
  }
  gp <- group_by_(x, gp.var)
  out <- as.data.frame(do(gp, line.estimate(., f, ..., result.name=result.name)))
  if(include.total){
    le <- line.estimate(x, f, ..., result.name=result.name)
    le[gp.var] = 'All'
    out <- rbind(out, le)
  }
  out
}
