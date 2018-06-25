se.acs.median <- function(x, field){
  pt.est <- acs.median(x, field)
  rep.ests <- sapply(1:80, function(n) acs.median(x, field, n))
  sqrt((4/80)* sum((rep.ests - pt.est)^2))
}
