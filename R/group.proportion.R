#' Compute proportion of group sizes on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the proportion of sizes of the groups defined by \code{gp.var}.
#'
#' @param x a data frame of PUMS data. If x is already grouped, then this
#'        function optionally adds a level to the grouping.
#' @param gp.var name of variable in x to group data by (string) or NULL
#'        if x is grouped and you do not want to add a level of grouping.
#'        May not be NULL if x is not grouped.
#' @param result.name name of estimate column in result
#'        Default is "Pct.".
#' @param drop.na.group drop the group where \code{gp.var} is NA
#'
#' @return data frame of proportion, standard error of the proportion,
#'         and the margin of error of the proportion of the sizes of
#'         the groups defined by \code{gp.var}.
#'
#' @import dplyr
#'
#' @examples
#' # Fraction of occupied households by tenure type for Washington State in 2016
#' group.proportion(wa.house16, 'TEN')
#'
#' # Same example using data grouped with group_by
#' library(dplyr)
#' gp <- group_by(wa.house16, TEN)
#' group.proportion(gp, NULL)
#'
#' @export
group.proportion <- function(x, gp.var, result.name='Pct.', drop.na.group=TRUE){
  if(!is_grouped_df(x) && is.null(gp.var)) {
    stop('gp.var must be used if x not grouped_df.')
  }
  if(!is.null(gp.var) && !(gp.var %in% names(x))){
    stop(gp.var, ' not in data')
  }
  # Remove NA's from any grouping columns of denominator
  if(drop.na.group){
    if(is.null(gp.var)){
      drop.cols <- vars(!!!groups(x))
    }else{
      # NB: still works if x not grouped
      drop.cols <- vars(!!!groups(x), matches(gp.var))
    }
    denom <- filter_at(ungroup(x), drop.cols, all_vars(!is.na(.)))
  }else{
    denom <- x
  }
  group.estimate(x, proportion, gp.var, denom, result.name=result.name,
                 drop.na.group = drop.na.group, include.total = FALSE)
}
