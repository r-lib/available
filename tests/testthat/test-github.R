context("Load packages from GitHub")

test_that("Can find dplyr", {
  expect_true(length(available_on_github("dplyr"))>0)
})

test_that("Can't find made up package", {
  expect_true(available_on_github("This_is_not_a_pkg"))
})
