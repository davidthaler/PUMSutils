#' Ground Truth for 2016 ACS Washington Housing Data
#'
#' 2016 ACS PUMS ground truth point estimates and standard errors for 12 housing characteristics for Washington State.
#'
#' @format A data frame with 4 variables:
#' \describe{
#' \item{characteristic}{name of estimated characteristic in 2015 ACS}
#' \item{pums_est_16}{point estimate of the charcteristic}
#' \item{pums_se_16}{standard error of estimate}
#' }
#'
#' @source
#' \url{http://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html} {PUMS Estimates for User Verification}
'wa.gold16'

#' 2016 ACS Washington Housing Data
#'
#' Parital 2016 ACS PUMS housing data for Washington State.
#' Data has 33241 rows (all rows), but only 86 columns.
#' Included variables are GRNTP, HINCP, NP, VACS, TEN,
#' the expansion weight (WGTP), and the 80 replicate weights.
#' VACS and TEN are the only variables used in the ACS PUMS estimates
#' for user verification, and the expansion weights and replicate weights
#' are needed to compute point estimates and standard errors.
#' The other variables are actual numbers (not categorical)
#' and are used in tests and vignettes.
#'
#' @format A data frame with 86 variables:
#' \describe{
#' \item{NP}{number of persons in household}
#' \item{GRNTP}{monthly gross rent}
#' \item{HINCP}{monthly household income}
#' \item{VACS}{vacancy status: NA=not vacant, 1=for rent, 3=for sale...for others, see reference}
#' \item{TEN}{tenure status: NA=vacant, 1=owned with mortgage, 2=owned with free and clear, 3=rented, 4=occupied w/o rent}
#' \item{WGTP}{expansion weight, the number of household in the population represented by this row}
#' \item{wgtp1..wgtp80}{80 replicate weights for computing standard errors}
#' }
#'
#' @references 2016 ACS PUMS Data Dictionary \url{http://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html}
'wa.house16'
