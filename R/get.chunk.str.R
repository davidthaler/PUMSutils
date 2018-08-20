# Splits data dict into chunks separated by blank lines
get.chunk.str <- function(dd){
  str_split(dd, '\n[[:blank:]]*\n')[[1]]
}
