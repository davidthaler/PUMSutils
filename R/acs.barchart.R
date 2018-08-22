#' Make barchart from ACS PUMS data.
#'
#' Make a barchart of weighted counts within categories from the ACS PUMS data.
#' Optionally, this can be a stacked barchart, partitioned over two variables.
#'
#' @import ggplot2
#'
#' @param data ACS PUMS data for housing or population
#' @param x (string) name of categorical variable in data to put on x-axis
#' @param stack optional (string) name of categorical value for stacked bar chart
#' @param title optional plot title
#' @param xlab optional x label
#' @param ylab optional y label
#'
#' @return ggplot of weighted count data
#'
#' @examples
#' wa.house16$Tenure <- own.rent(wa.house16)
#' acs.barchart(wa.house16, 'Tenure',
#'              title='Housing Unit Count by Tenure', xlab='Tenure')
#'
#' wa.pop16$sex <- acs.recode(wa.pop16, 'SEX', data.dict16)
#' wa.pop16$emp.stat <- acs.translate(wa.pop16, 'ESR', c(NA, 1:6),
#'     c('NILF', 'Employed', 'Employed', 'Unemployed', 'Employed', 'Employed', 'NILF'))
#' acs.barchart(wa.pop16, 'emp.stat', stack='sex',
#'              title='Employment Status by Gender',
#'              xlab='Employment Status')
#'
#' @export
acs.barchart <- function(data, x, stack=NULL, title=NULL, xlab=NULL, ylab=NULL){
  g <- ggplot(data, aes_string(x))
  wt <- get.weight(data)
  if(is.null(stack)){
    g <- g + geom_bar(aes_string(weight=wt))
  }else{
    if(is.factor(data[[stack]]) | is.character(data[[stack]])){
      g <- g + geom_bar(aes_string(weight=wt, fill=stack))
    }else{
      stop('Stack column: ', stack, ' must have type factor or character')
    }
  }
  g <- set.labels(g, title, xlab, ylab)
  g
}
