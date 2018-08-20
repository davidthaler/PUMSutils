levels.df <- function(dd, token){
  # Builds a data frame mapping integer coded categorical variable levels
  # to a factor named with text from the data dictionary.
  #
  # Args:
  #   dd: the data dict as a string
  #   token: the ACS short name to extract
  #
  # Returns:
  #   data frame from the integer level code to the description of that level
  parts <- str_split(extract.field(dd, token), ' \\.')
  parts <- parts[3:length(parts)]
  level.num <- suppressWarnings(sapply(parts, function(x) as.numeric(x[1])))
  level.text <- sapply(parts, function(x) x[2])
  data.frame(level.num=level.num, text=level.text)
}
