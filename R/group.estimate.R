#' Compute estimates and standard errors on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' any statistic across groups defined by \code{gp.var} and (optionally)
#' over the whole data. If x is grouped already, \code{gp.var} is added
#' to the grouping, but in this case, \code{gp.var} can be NULL,
#' which does not add a new grouping.
#'
#' @param x a data frame of PUMS data. If x is already grouped, then this
#'        function optionally adds a level to the grouping.
#' @param f a function to calculate the statistic.
#'        It must take data and a weight replicate number called
#'        \code{wt.rep.num} with a default value of NULL.
#' @param gp.var name of variable in x to group data by (string) or NULL
#'        if x is grouped and you do not want to add a level of grouping.
#'        May not be NULL if x is not grouped.
#' @param ... other data passed to f
#' @param result.name name of estimate column in result.
#'        Default of NULL uses \code{deparse(substitute(f))}.
#' @param include.total include the total across all groups, default TRUE
#' @param drop.na.group default FALSE, drop the group where \code{gp.var} is NA
#'
#' @import dplyr
#'
#' @return data frame of estimate, standard error of the estimate,
#'         and the margin of error of the estimate, for the statistic
#'         defined by `f`, over the groups defined by \code{gp.var}
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
#' # First example, with data already grouped using group_by
#' library(dplyr)
#' gp <- group_by(wa.house16, TEN)
#' group.estimate(gp, estimate, NULL, drop.na.group=TRUE)
#'
#' @export
group.estimate <- function(x, f, gp.var, ..., result.name=NULL,
                               drop.na.group=FALSE, include.total=TRUE){
  if(!is_grouped_df(x) && is.null(gp.var)) {
    stop('gp.var must be used if x not grouped_df.')
  }
  if(!is.null(gp.var) && !(gp.var %in% names(x))){
    stop(gp.var, ' not in data')
  }
  if(is.null(result.name)) result.name <- deparse(substitute(f))
  if(is_grouped_df(x)){
    if(is.null(gp.var)){
      gp <- x
    }else{
      gp <- group_by_(x, gp.var, add=TRUE)
    }
  }else{
    gp <- group_by_(x, gp.var)
  }
  # Want to filter NA in all group variables
  if(drop.na.group){
    grps <- groups(gp)
    x <- ungroup(gp)
    x <- filter_at(x, vars(!!!grps), all_vars(!is.na(.)))
    gp <- group_by(x, !!! grps)
  }
  out <- as.data.frame(do(gp, line.estimate(., f, ..., result.name=result.name)))
  if(include.total){
    le <- line.estimate(x, f, ..., result.name=result.name)
    le[group_vars(gp)] <- ''
    le[names(out)[1]] <- 'All'
    out <- rbind(out, le)
  }
  out
}
