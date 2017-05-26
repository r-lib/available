context("Check package name for bad words")

test_that("Catches bad word", {
  expect_true(length(get_bad_words("hell"))>0)
})

test_that("Passes safe word", {
  expect_true(length(get_bad_words("happy"))==0)
})
