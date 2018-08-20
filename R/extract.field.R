extract.field <- function(dd, token){
  # Extract all of the text after a token. The token is the ACS
  # column name. It will be in all caps. It will start the first
  # line of the field definition.
  #
  # Args:
  #   dd: the data dict as a string
  #   token: the ACS short name to extract
  #
  # Returns:
  #   character vector with part of field, one element per line
  #
  dd.chunks <- get.chunk.str(dd)
  pat <- paste0('^', token, '[[:blank:]]')
  tok.str <- dd.chunks[str_detect(dd.chunks, pat)]
  fmt.chunk.str(tok.str)
}
