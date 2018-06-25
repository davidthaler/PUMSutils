#' Compute estimates and standard errors on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' any statistic across groups defined by \code{gp_var} and (optionally)
#' over the whole data.
#'
#' @param result.name name of estimate column in result
#' @param f a function to calculate the statistic.
#'        It must take data and a weight replicate number called wt.rep.num
#'        with a default value of NULL.
#' @param ... other data passed to f
#' @param x a data frame of PUMS data
#' @param gp_var name of variable in x to group data by, a string
#' @param include.total include the total across all groups, default TRUE
#' @param drop.na.group default FALSE, drop the group where `gp_var` is NA
#'
#' @importFrom dplyr group_by_ do filter
#'
#' @return data frame of estimate, standard error of the estimate,
#'         and the margin of error of the estimate, for the statistic
#'         defined by `f` , over the groups defined by \code{gp_var}
#'         and (optionally) the whole data.
#'
#' @examples
#' # Total of occupied households in Washington State in 2016
#' group.estimate('HH.Ct', estimate, wa.house16, 'TEN', drop.na.group=TRUE)
#'
#' @export
#'
group.estimate <- function(result.name, f, x, gp_var, ...,
                               drop.na.group=FALSE, include.total=TRUE){
  if(drop.na.group){
    x <- filter(x, is.finite(x[[gp_var]]))
  }
  gp <- group_by_(x, gp_var)
  out <- as.data.frame(do(gp, line.estimate(result.name, f, ., ...)))
  if(include.total){
    l <- list()
    l[[gp_var]] <- 'All'
    total <- cbind(l, line.estimate(result.name, f, x, ...))
    out <- rbind(out, total)
  }
  out
}
