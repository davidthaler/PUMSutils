# Breaks up a chunk sting into stripped lines
fmt.chunk.str <- function(s){
  str_strip(str_split(s, '\n')[[1]])
}
