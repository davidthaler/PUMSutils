library(dplyr)
context('PUMSutils')

test_that('estimate() produces correct total', {
  tot.HU <- wa.gold16$pums_est_16[1]
  rentals <- wa.gold16$pums_est_16[7]
  expect_equal(estimate(wa.house16), tot.HU)
  expect_equal(estimate(filter(wa.house16, TEN==3)), rentals)
})

test_that('se.estimate() gives correct standard errors', {
  se.HU <- wa.gold16$pums_se_16[1]
  se.rentals <- wa.gold16$pums_se_16[7]
  expect_equal(round(se.estimate(wa.house16)), se.HU)
  expect_equal(round(se.estimate(filter(wa.house16, TEN==3))), se.rentals)
})

test_that('proportion() gives correct fraction', {
  tot.HU <- wa.gold16$pums_est_16[1]
  rentals <- wa.gold16$pums_est_16[7]
  gold.prop <- with(wa.gold16, pums_est_16[7]/pums_est_16[1])
  expect_equal(proportion(filter(wa.house16, TEN==3), wa.house16), gold.prop)
})

test_that('acs.table() gives correct value', {
  expect_equivalent(acs.table(wa.house16, 'TEN')[3], wa.gold16$pums_est_16[7])
})
