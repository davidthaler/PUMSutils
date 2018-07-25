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
#' Partial 2016 ACS PUMS housing data for Washington State.
#' Data has 33241 rows (all rows), but only 89 columns.
#' Included variables are SERIALNO, NP, GRPIP, GRNTP, HINCP, VACS, TEN, BDSP,
#' the expansion weight (WGTP), and the 80 replicate weights.
#' VACS and TEN are the only variables used in the ACS PUMS estimates
#' for user verification, and the expansion weights and replicate weights
#' are needed to compute point estimates and standard errors.
#' The other variables are actual numbers (not categorical)
#' and are used in tests and vignettes.
#'
#' @format A data frame with 89 variables:
#' \describe{
#' \item{SERIALNO}{household serial number, a unique identifier. This is the join key to the person records.}
#' \item{NP}{number of persons in household}
#' \item{GRPIP}{gross rent as a percentage of household income}
#' \item{GRNTP}{monthly gross rent}
#' \item{HINCP}{monthly household income}
#' \item{VACS}{vacancy status: NA=not vacant, 1=for rent, 3=for sale...for others, see reference}
#' \item{TEN}{tenure status: NA=vacant, 1=owned with mortgage, 2=owned with free and clear, 3=rented, 4=occupied w/o rent}
#' \item{BDSP}{number of bedrooms}
#' \item{WGTP}{expansion weight, the number of households in the population represented by this row}
#' \item{wgtp1..wgtp80}{80 replicate weights for computing standard errors}
#' }
#'
#' @references 2016 ACS PUMS Data Dictionary \url{http://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html}
'wa.house16'

#' 2016 ACS Population Data for Seattle
#'
#' Partial 2016 ACS PUMS person records for Seattle.
#' The geography is approximate; data is for Public Use Microdata
#' Areas (PUMA) 11601:11605, which approximate Seattle.
#' Data has 6053 rows and 89 columns
#' Included variables are SERIALNO, PUMA, RELP, AGEP, SEX, ESR, RAC1P, HISP,
#' the expansion weight (PWGTP), and the 80 replicate weights.
#'
#' @format A data frame with 89 variables:
#' \describe{
#' \item{SERIALNO}{household serial number, a unique identifier. This is the join key to the housing data.}
#' \item{PUMA}{Public Use Microdata Area}
#' \item{RELP}{relationship of this person to the reference person. See references.}
#' \item{AGEP}{age}
#' \item{SEX}{sex}
#' \item{ESR}{Employment Status. See references. Coded as NA=under 16; 1,2,4,5=employed; 3=unemployed; 6=Not in Labor Force}
#' \item{RAC1P}{Race. See references. Coded  as 1=White, 2=Black, 3,4,5=Native, 6,7=Asian or Pacific Islander, 8=Other Race, 9=Mixed}
#' \item{HISP}{Hispanic Ancestry. See references. Coded 1 for "not Hispanic", anything else is Hispanic}
#' \item{PWGTP}{expansion weight, the number of people in the population represented by this row}
#' \item{pwgtp1..pwgtp80}{80 replicate weights for computing standard errors}
#' }
#'
#' @references 2016 ACS PUMS Data Dictionary \url{http://www.census.gov/programs-surveys/acs/technical-documentation/pums/documentation.html}
'sea.pop16'
