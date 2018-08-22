#' Cut numeric column and assign labels to bins
#'
#' Cuts a numeric column using \code{Hmisc::cut2} and optionally assigns different
#' labels to the levels produced.
#' If labels are provided, there must be as many of them as there are levels.
#'
#' @param x input data frame
#' @param field name of numeric column in x to cut
#' @param cuts cut points. If \code{cuts} does not cover the range of the data,
#'     then extra bins will be returned on the ends.
#' @param labels optional character vector of level labels.
#'      If used, must be same length as the factor produced.
#'
#' @return factor with binned values for \code{x[[field]]}
#'         and the names from \code{labels}
#'
#' @importFrom Hmisc cut2
#'
#' @examples
#' med.inc <- acs.median(wa.house16, 'HINCP')
#' cuts <- med.inc * c(0.3, 0.5, 0.8, 1.2)
#' labels <- c('0-30 AMI', '30-50 AMI', '50-80 AMI', '80-120 AMI', '>120 AMI')
#' wa.house16$Income.Band <- column.cut(wa.house16, 'HINCP', cuts=cuts, labels=labels)
#' group.count(wa.house16, 'Income.Band', drop.na.group=TRUE)
#'
#' @export
column.cut <- function(x, field, cuts, labels=NULL){
  out <- cut2(x[[field]], cuts=cuts)
  nlab <- length(labels)
  nlvl <- length(levels(out))
  if(!is.null(labels)){
    if(nlab != nlvl){
      stop('Labels have length ', nlab, ' but cuts produced ', nlvl, ' levels.')
    }else{
      levels(out) <- labels
    }
  }
  out
}
