test_that("Can find dplyr", {
  skip_on_cran()

  expect_false(available_on_cran("dplyr"))
})

test_that("Can't find made up package", {
  skip_on_cran()

  expect_true(available_on_cran("This_is_not_a_pkg"))
})
