#' Compute count statistics on grouped ACS PUMS data.
#'
#' Collect point estimate, standard error and 90% margin-of-error for
#' the count across groups defined by \code{gp_var} and (optionally)
#' over the whole data.
#'
#' @param x a data frame of PUMS data
#' @param gp_var name of variable in x to group data by, a string
#' @param include.total include the total across all groups as last row,
#'        default TRUE
#'
#' @importFrom dplyr group_by_ do
#'
#' @return data frame of count, standard error of the count,
#'         and the margin of error of the count, over groups
#'         defined by \code{gp_var} and the whole data.
#'
#' @examples
#' acs.group.estimate(wa.house16, 'TEN')
#'
#' @export
#'
acs.group.estimate <- function(x, gp_var, include.total=TRUE){
  gp <- group_by_(x, gp_var)
  out <- as.data.frame(do(gp, acs.line.estimate(.)))
  if(include.total){
    l <- list()
    l[[gp_var]] <- 'Total'
    total <- cbind(l, acs.line.estimate(x))
    out <- rbind(out, total)
  }
  out
}
