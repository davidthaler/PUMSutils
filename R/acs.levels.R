#' Map integer levels to their descriptions
#'
#' Builds a data frame mapping integer coded categorical variable levels
#' in the ACS PUMS data to a factor named with text from the data dictionary.
#'
#' @importFrom stringr str_split str_sub
#'
#' @param dd the data dict as a string
#' @param token the ACS short name to extract
#' @param max.len max length of description in characters, default is all
#'
#' @return data frame from the integer level code to the level description
#'
#' @export
acs.levels <- function(dd, token, max.len=-1){
  parts <- str_split(extract.field(dd, token), ' \\.')
  parts <- parts[3:length(parts)]
  level.num <- suppressWarnings(sapply(parts, function(x) as.numeric(x[1])))
  level.text <- sapply(parts, function(x) x[2])
  level.text <- str_sub(level.text, end=max.len)
  data.frame(level.num=level.num, text=level.text, stringsAsFactors=FALSE)
}
