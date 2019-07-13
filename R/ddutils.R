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
#' @param ex.field output of fmt.chunk.str(field.chunk(dd, field))
#'
#' @return TRUE if field is numeric, else FALSE
sniff.numeric <- function(ex.field){
  pat <- "^-?[:digit:]+\\.\\."
  any(str_detect(ex.field, pat))
}

#' Truncate each element of character vector to max number of words.
#' Used to truncate level descriptions from data dictionary.
#'
#' @importFrom stringr str_split
#' @importFrom stringi stri_c_list
#'
#' @noRd
#'
#' @param x input character vector
#' @param max.len max number of words in output elements
#'
#' @return x, with each element truncated to at most max.len words
word.cut <- function(x, max.len=NULL){
  if (!is.null(max.len)){
    word.list <- str_split(x, '[:blank:]+')
    word.list <- lapply(word.list, function(x) x[1:min(max.len, length(x))])
    out <- stri_c_list(word.list, sep=" ")
  }else{
    out <- x
  }
  out
}
