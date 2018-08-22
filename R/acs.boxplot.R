#' Make boxplot from ACS PUMS data
#'
#' Make a weighted boxplot of the distribution of a numeric field in the
#' ACS PUMS data, partitioned by a categorical field.
#'
#' @import ggplot2
#'
#' @param data ACS PUMS data for housing or population
#' @param x (string) name of categorical variable in data to put on x-axis
#' @param y (string) name of numeric variable in data for y-axis
#' @param title optional plot title
#' @param xlab optional x label
#' @param ylab optional y label
#'
#' @return ggplot of the weighted distribution of y, partitioned by x
#'
#' @export
acs.boxplot <- function(data, x, y, title=NULL, xlab=NULL, ylab=NULL){
  wt <- get.weight(data)
  g <- ggplot(data, aes_string(x=x, y=y, group=x))
  g <- g + geom_boxplot(aes_string(weight=wt))
  g <- set.labels(g, title, xlab, ylab)
  g
}
