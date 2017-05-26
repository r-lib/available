context("Check package name for bad words")

test_that("Catches bad word", {
  expect_error(get_bad_words("hell"))
})

test_that("Passes safe word", {
  expect_true(get_bad_words("happy"))
})
