context("Load packages from github")

test_that("Can find dplyr", {
  expect_error(available_github("dplyr"))
})

test_that("Can't find made up package", {
  expect_true(available_github("This_is_not_a_pkg"))
})
