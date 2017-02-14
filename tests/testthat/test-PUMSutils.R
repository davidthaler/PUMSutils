library(dplyr)
context('PUMSutils')

test_that('estimate() produces correct total', {
  tot.HU <- wa.gold$pums_est_15[1]
  rentals <- wa.gold$pums_est_15[7]
  expect_equal(estimate(wa.house), tot.HU)
  expect_equal(estimate(filter(wa.house, TEN==3)), rentals)
})

test_that('se.estimate() gives correct standard errors', {
  se.HU <- wa.gold$pums_se_15[1]
  se.rentals <- wa.gold$pums_se_15[7]
  expect_equal(round(se.estimate(wa.house)), se.HU)
  expect_equal(round(se.estimate(filter(wa.house, TEN==3))), se.rentals)
})

test_that('proportion() gives correct fraction', {
  tot.HU <- wa.gold$pums_est_15[1]
  rentals <- wa.gold$pums_est_15[7]
  gold.prop <- with(wa.gold, pums_est_15[7]/pums_est_15[1])
  expect_equal(proportion(filter(wa.house, TEN==3), wa.house), gold.prop)
})

test_that('acs.table() gives correct value', {
  expect_equivalent(acs.table(wa.house, 'TEN')[3], wa.gold$pums_est_15[7])
})