context("Load packages from github")

test_that("Can find dplyr", {
  expect_true(length(available_github("dplyr"))>0)
})

test_that("Can't find made up package", {
  expect_true(available_github("This_is_not_a_pkg"))
})
