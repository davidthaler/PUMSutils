# Strips blank characters off either end of string.
#
# NB: stringr::str_trim fails on invalid characters,
# which are present in some versions of the data dict.
str_strip <- function(s){
  str_replace_all(s, '(^[[:blank:]]+|[[:blank:]]+$)', '')
}
