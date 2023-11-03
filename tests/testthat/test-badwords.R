test_that("Catches bad word", {
  skip_on_cran()

  expect_identical("hell", get_bad_words("hell")[[1L]])
})

test_that("Passes safe word", {
  skip_on_cran()

  expect_true(length(get_bad_words("happy")) == 0)
})
