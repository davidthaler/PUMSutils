#' Splits data dict into chunks separated by blank lines
#'
#' @param dd the data dictionary as a string
#'
#' @importFrom stringr str_split
#'
#' @return list of all chunks in the data dictionary
get.chunk.str <- function(dd){
  str_split(dd, '\n[[:blank:]]*\n+')[[1]]
}


#' Strips blank characters off either end of string.
#
#' This function is used instead of stringr::str_trim becasue that fails
#' on non-ASCII characters, which are present in some versions of the
#' data dictionary.
#'
#' @importFrom stringr str_replace_all
#'
#' @param s a string
#'
#' @return s, with leading and trailing whitespace stripped.
#'
str_strip <- function(s){
  str_replace_all(s, '(^[[:blank:]]+|[[:blank:]]+$)', '')
}


#' Formats list of chunks from get.chunk.str
#'
#' @param s a string with one chunk from get.chunk.str
#'
#' @importFrom stringr str_split
#'
#' @return character vector with one line from data dictionary per element
fmt.chunk.str <- function(s){
  str_strip(str_split(s, '\n')[[1]])
}


#' Extract text from data dictionary for a variable
#'
#' Extract all of the text after a token.
#' The token is the ACS column name. It will be in all caps.
#' It will start the first line of the field definition.
#'
#' @param dd the data dict as a string
#' @param token the ACS short name to extract
#'
#' @importFrom stringr str_detect
#'
#' @return character vector with part of field, one element per line
extract.field <- function(dd, token){
  dd.chunks <- get.chunk.str(dd)
  pat <- paste0('^', token, '[[:blank:]]')
  tok.str <- dd.chunks[str_detect(dd.chunks, pat)]
  fmt.chunk.str(tok.str)
}


#' Map integer levels to their descriptions
#'
#' Builds a data frame mapping integer coded categorical variable levels
#' in the ACS PUMS data to a factor named with text from the data dictionary.
#'
#' @param dd the data dict as a string
#' @param token the ACS short name to extract
#' @param max.len max length of description in characters, default is all
#'
#' @return data frame from the integer level code to the level description
#'
#' @importFrom stringr str_split str_sub
levels.df <- function(dd, token, max.len=-1){
  parts <- str_split(extract.field(dd, token), ' \\.')
  parts <- parts[3:length(parts)]
  level.num <- suppressWarnings(sapply(parts, function(x) as.numeric(x[1])))
  level.text <- sapply(parts, function(x) x[2])
  level.text <- str_sub(level.text, end=max.len)
  data.frame(level.num=level.num, text=level.text, stringsAsFactors=FALSE)
}
