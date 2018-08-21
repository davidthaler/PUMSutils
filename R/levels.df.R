#' Splits data dict into chunks separated by blank lines
#'
#' @importFrom stringr str_split
#'
#' @noRd
#'
#' @param dd the data dictionary as a string
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
#' @noRd
#'
#' @param s a string
#'
#' @return s, with leading and trailing whitespace stripped.
str_strip <- function(s){
  str_replace_all(s, '(^[[:blank:]]+|[[:blank:]]+$)', '')
}


#' Formats list of chunks from get.chunk.str
#'
#' @importFrom stringr str_split
#'
#' @noRd
#'
#' @param s a string with one chunk from get.chunk.str
#'
#' @return character vector with one line from data dictionary per element
fmt.chunk.str <- function(s){
  str_strip(str_split(s, '\n')[[1]])
}

#' Extract a chunk for one field out of data dict
#'
#' @importFrom stringr str_subset
#'
#' @noRd
#'
#' @param dd the data dict as a string
#' @param token the ACS short name to extract
#'
#' @return the matching chunk, or character(0) if not found
field.chunk <- function(dd, token){
  pat <- paste0('^', token, '[:blank:]')
  str_subset(get.chunk.str(dd), pat)
}

#' Check if field is numeric instead of categorical
#'
#' @importFrom stringr str_detect
#'
#' @noRd
#'
#' @param ex.field output of extract.field
#'
#' @return TRUE if field is numeric, else FALSE
sniff.numeric <- function(ex.field){
  pat <- "^-?[:digit:]+\\.\\."
  any(str_detect(ex.field, pat))
}

#' Extract text from data dictionary for a variable
#'
#' Extract all of the text after a token.
#' The token is the ACS column name. It will be in all caps.
#' It will start the first line of the field definition.
#'
#' @importFrom stringr str_detect
#'
#' @noRd
#'
#' @param dd the data dict as a string
#' @param token the ACS short name to extract
#'
#' @return character vector with part of field, one element per line
extract.field <- function(dd, token){
  dd.chunks <- get.chunk.str(dd)
  pat <- paste0('^', token, '[[:blank:]]')
  tok.str <- dd.chunks[str_detect(dd.chunks, pat)]
  fmt.chunk.str(tok.str)
}
