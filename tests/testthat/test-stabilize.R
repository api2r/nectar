test_that("stabilize_string() checks strings", {
  expect_error(stabilize_string(letters), class = "stbl-error-non_scalar")
  expect_error(stabilize_string(NULL), class = "stbl-error-bad_null")
  expect_error(stabilize_string(character()), class = "stbl-error-bad_empty")
  expect_error(stabilize_string(NA), class = "stbl-error-bad_na")
  expect_identical(
    stabilize_string("a"),
    "a"
  )
})
