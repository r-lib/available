context("Check package name for indigenous tribe names")

test_that("Catches indigenous tribe names", {
  expect_identical("snoqualmie", get_tribe_names("snoqualmie")[[1L]])
  expect_identical("ute", get_tribe_names("ute")[[1L]])
})

test_that("Passes non-indigenous tribe names", {
  expect_true(length(get_tribe_names("happy")) == 0)
  expect_true(length(get_tribe_names("peerage")) == 0)
  # we don't want to match with 'ute' in the middle of a word, how to do this?
  # expect_true(length(get_tribe_names("dispute")) == 0)
})
