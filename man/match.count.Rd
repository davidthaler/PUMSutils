% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/match.count.R
\name{match.count}
\alias{match.count}
\title{Count persons in households matching a list of conditions.}
\usage{
match.count(house, pop, ...)
}
\arguments{
\item{house}{ACS housing data or subset with the \code{SERIALNO} field}

\item{pop}{ACS population data or subset with the \code{SERIALNO} field}

\item{...}{a list of conditions that define the subset,
as bare expressions, not as strings}
}
\value{
vector of counts of people matching (...) conditions,
         should be aligned with house
}
\description{
Counts the rows in the population table, grouped by household,
that match a list of conditions given as the \code{...} argument,
filling \code{NA} values with 0.
The result can be joined to the housing data on \code{SERIALNO},
and the housing weights (called \code{WGTP}) should be used to
compute estimates.
}
\examples{
# ESR is employment status; levels 1, 2, 4, and 5 are the employed levels
wa.house16$num.work <- match.count(wa.house16, wa.pop16, ESR \%in\% c(1,2,4,5))
group.count(wa.house16, 'num.work')

}
