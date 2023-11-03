test_that("Can find dplyr", {
  skip_on_cran()

  expect_false(available_on_bioc("ACME"))
})

test_that("Can't find made up package", {
  skip_on_cran()

  expect_true(available_on_bioc("This_is_not_a_pkg"))
})
