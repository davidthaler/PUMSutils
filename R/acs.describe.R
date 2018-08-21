#' Describe a field in the ACS PUMS data
#'
#' Extract the description of a field in the ACS PUMS data from the
#' data dictionary. The description includes the column name (abbreviation),
#' the field name (plain English), the factor levels and their descriptions
#' for integer-coded categoricals or the range and description for numeric
#' variables.
#'
#' @importFrom stringr str_sub str_replace str_split
#'
#' @param dd the data dict as a string
#' @param field the ACS column name to extract
#' @param max.len max length of description in characters, default is all
#'
#' @return list with column name and description, levels and their definitions
#'
#' @export
acs.describe <- function(dd, field, max.len=-1){
  chunk <- field.chunk(dd, field)
  if(length(chunk) == 0){
    stop(field, ' not found in data dictionary')
  }
  chunk.lines <- fmt.chunk.str(chunk)
  out <- list(Name=field, Description=chunk.lines[2])
  chunk.lines <- chunk.lines[3:length(chunk.lines)]
  parts <- str_split(chunk.lines, '[:blank:]+\\.')
  a <- sapply(parts, function(x) x[1])
  b <- sapply(parts, function(x) x[2])
  b <- str_sub(b, end=max.len)
  if(sniff.numeric(chunk.lines)){
    a <- str_replace(a, '^b+', 'NA')
  }else{
    a <- suppressWarnings(as.numeric(a))
  }
  lvl <- data.frame(Level=a, Level.Desc=b, stringsAsFactors = FALSE)
  out$Levels <- lvl
  out
}
