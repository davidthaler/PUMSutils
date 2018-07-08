#' Count number of persons in households matching a list of conditions.
#'
#' Counts the rows in the population table, grouped by household,
#' that match a list of conditions given as the \code{...} argument,
#' filling \code{NA} values with 0.
#' The result can be joined to the housing data on \code{SERIALNO},
#' and the housing weights (called \code{WGTP}) should be used to
#' compute estimates.
#'
#' @param house ACS housing data or subset with the \code{SERIALNO} field
#' @param pop ACS population data or subset with the \code{SERIALNO} field
#' @param ... a list of conditions that define the subset,
#'            as bare expressions, not as strings
#'
#' @return a 2-column data frame with columns \code{SERIALNO} and
#'        a result column called either \code{n} or \code{result.name}
#'
#' @importFrom dplyr quos filter count left_join
#'
#' @export
match.count <- function(house, pop, ...){
  cond.list <- quos(...)
  x <- filter(pop, !!! cond.list)
  cts <- count(x, SERIALNO)
  out <- house['SERIALNO']
  out <- left_join(out, cts)
  out$n <- ifelse(is.na(out$n), 0, out$n)
  out$n
}
