context("Load packages from CRAN")

test_that("Can find dplyr", {
  expect_true(length(available("dplyr"))>0)
})

test_that("Can't find made up package", {
  expect_true(available("This_is_not_a_pkg"))
})

