se.acs.total <- function(x, field){
  pt.est <- acs.total(x, field)
  rep.ests <- sapply(1:80, function(n) acs.total(x, field, n))
  sqrt((4/80) * sum((rep.ests - pt.est)^2))
}
