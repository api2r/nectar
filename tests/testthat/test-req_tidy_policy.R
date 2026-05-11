test_that("req_tidy_policy applies resp_body_auto by default (#44, #86)", {
  req <- req_tidy_policy(httr2::request("https://example.com"))
  expect_s3_class(req$policies$resp_tidy, "nectar_tidy_policy")
  expect_identical(
    req$policies$resp_tidy,
    tidy_policy_body_auto()
  )
})

test_that("req_tidy_policy applies the specified policy (#44, #86)", {
  req <- req_tidy_policy(
    httr2::request("https://example.com"),
    tidy_policy = tidy_policy_prepare(
      httr2::resp_body_json,
      simplifyVector = TRUE
    )
  )
  expect_s3_class(req$policies$resp_tidy, "nectar_tidy_policy")
  expect_identical(
    req$policies$resp_tidy,
    tidy_policy_prepare(
      httr2::resp_body_json,
      simplifyVector = TRUE
    )
  )
})
