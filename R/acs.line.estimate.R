#' Compute count statistics from ACS PUMS data.
#'
#' Compute point estimate, standard error and 90% margin of error
#' on ACS PUMS data using the replicate weights and return results on one line.
#'
#' @param x a data frame of PUMS data, filtered to the in-sample rows.
#'
#' @return the point estimate, standard error and 90% margin of error
#' for the size of this sample.
#'
#' @export
#'
line.estimate <- function(x){
  out <- list(Count=estimate(x),
              SE=se.estimate(x))
  out$MOE90 <- 1.645 * out$SE
  as.data.frame(out)
}
