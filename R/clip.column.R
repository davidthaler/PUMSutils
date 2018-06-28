#' Clip an integer column
#'
#' Many count variables in the ACS PUMS data have long upper tails.
#' This function clips integer columns and returns a factor with
#' level names like "1", "2", "3+" that order correctly, even if the clip level
#' is named something like ">=3", which would not sort correctly as a string.
#'
#' @param x a data frame of PUMS data
#' @param colname (string) name of column in x to clip
#' @param clip.at upper clip level
#' @param clip.name (string) name of the top clip level;
#'        for \code{clip.at} of n, the default is "n+".
#'
#' @return factor column with levels like "1", "2", ... "n+" in place
#'         of the (count) integer values in \code{x$colname}
#'
#' @examples
#' wa.house16$Size <- clip.column(wa.house16, 'NP', 5, '>=5')
#' group.count(wa.house16, 'HH.Count', 'Size')
#'
#' @export
#'
clip.column <- function(x, colname, clip.at, clip.name=NULL){
  if(is.null(clip.name)){
    clip.name <- paste0(clip.at, '+')
  }
  out <- pmin(x[[colname]], clip.at)
  values <- unique(sort(out))
  level.names <- values
  level.names[length(level.names)] <- clip.name
  dummy.df <- data.frame(out=out)
  acs.translate(dummy.df, 'out', values, level.names)
}
