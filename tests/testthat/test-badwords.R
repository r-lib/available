context("Check package name for bad words")

test_that("Catches bad word", {
  expect_error(check_bad_words("hell"))
})

test_that("Passes safe word", {
  expect_error(check_bad_words("happy"))
})
