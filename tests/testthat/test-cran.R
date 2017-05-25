context("Load packages from CRAN")

test_that("Can find dplyr", {
  expect_true(length(available_on_cran("dplyr"))>0)
})

test_that("Can't find made up package", {
  expect_true(available_on_cran("This_is_not_a_pkg"))
})

