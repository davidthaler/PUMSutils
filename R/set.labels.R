#' Set the title and axis labels on a ggplot
#'
#' @import ggplot2
#'
#' @noRd
#'
#' @param title optional plot title
#' @param xlab optional x label
#' @param ylab optional y label
#'
#' @return the ggplot with title and axis added
set.labels <- function(g, title=NULL, xlab=NULL, ylab=NULL){
  if(!is.null(title)){
    g <- g + ggtitle(title)
  }
  if(!is.null(xlab)){
    g <- g + xlab(xlab)
  }
  if(!is.null(ylab)){
    g <- g + ylab(ylab)
  }
  g
}
