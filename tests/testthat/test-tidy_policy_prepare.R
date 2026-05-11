test_that("tidy_policy_prepare() constructs nectar_tidy_policy objects (#86)", {
  test_result <- tidy_policy_prepare(
    httr2::resp_body_json,
    simplifyVector = TRUE
  )
  expect_s3_class(test_result, "nectar_tidy_policy")
  expect_identical(test_result$tidy_fn, httr2::resp_body_json)
  expect_identical(
    test_result$tidy_args,
    list(simplifyVector = TRUE)
  )
})

test_that(".as_nectar_tidy_policy() returns nectar_tidy_policy objects unchanged (#86)", {
  test_input <- tidy_policy_prepare(
    httr2::resp_body_json,
    simplifyVector = TRUE
  )
  test_result <- .as_nectar_tidy_policy(test_input)
  expect_identical(test_result, test_input)
})

test_that(".as_nectar_tidy_policy() returns NULL for NULL input (#86)", {
  test_result <- .as_nectar_tidy_policy(NULL)
  expect_null(test_result)
})

test_that(".as_nectar_tidy_policy() errors for list without tidy_fn (#86)", {
  stbl::expect_pkg_error_classes(
    .as_nectar_tidy_policy(list(tidy_args = list(simplifyVector = TRUE))),
    "nectar",
    class = "unsupported_tidy_policy_class"
  )
})

test_that(".as_nectar_tidy_policy() converts function input to nectar_tidy_policy (#86)", {
  test_result <- .as_nectar_tidy_policy(httr2::resp_body_json)
  expect_s3_class(test_result, "nectar_tidy_policy")
  expect_identical(test_result$tidy_fn, httr2::resp_body_json)
  expect_identical(test_result$tidy_args, list())
})

test_that(".as_nectar_tidy_policy() merges tidy_args with additional tidy policy fields (#86)", {
  test_result <- .as_nectar_tidy_policy(list(
    tidy_fn = httr2::resp_body_json,
    tidy_args = list(simplifyVector = TRUE),
    simplifyDataFrame = FALSE
  ))
  expect_s3_class(test_result, "nectar_tidy_policy")
  expect_identical(
    test_result$tidy_args,
    list(simplifyVector = TRUE, simplifyDataFrame = FALSE)
  )
})

test_that(".as_nectar_tidy_policy() errors for non-listable tidy_args (#86)", {
  stbl::expect_pkg_error_classes(
    .as_nectar_tidy_policy(list(
      tidy_fn = httr2::resp_body_json,
      tidy_args = mean
    )),
    "stbl",
    class = "bad_function"
  )
})
