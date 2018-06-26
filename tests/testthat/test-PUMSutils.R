context('PUMSutils')

test_that('estimate() produces correct total', {
  tot.HU <- wa.gold16$pums_est_16[1]
  rentals <- wa.gold16$pums_est_16[7]
  expect_equal(estimate(wa.house16), tot.HU)
  expect_equal(estimate(subset(wa.house16, TEN==3)), rentals)
})

test_that('se.estimate() gives correct standard errors', {
  gold.se.HU <- wa.gold16$pums_se_16[1]
  gold.se.rentals <- wa.gold16$pums_se_16[7]
  my.se.HU <- round(acs.se(estimate, wa.house16))
  my.se.rentals <- round(acs.se(estimate, subset(wa.house16, TEN==3)))
  expect_equal(my.se.HU, gold.se.HU)
  expect_equal(my.se.rentals, gold.se.rentals)
})

test_that('proportion() gives correct fraction', {
  tot.HU <- wa.gold16$pums_est_16[1]
  rentals <- wa.gold16$pums_est_16[7]
  gold.prop <- with(wa.gold16, pums_est_16[7]/pums_est_16[1])
  expect_equal(proportion(subset(wa.house16, TEN==3), wa.house16), gold.prop)
})
