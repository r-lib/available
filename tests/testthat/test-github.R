test_that("Can find ", {
  skip_on_cran()

  expect_false(available_on_github("svrepmisc")$available)
})

test_that("Can't find made up package", {
  skip_on_cran()

  expect_true(available_on_github("This_is_not_a_pkg")$available)
})

test_that("github_locations() tests", {
  skip_on_cran()

  expect_equal(github_locations(available_on_github("This_is_not_a_pkg")), character(0))
  expect_error(github_locations(5), "of class 'available_github'")
})
