test_that("auth_prepare() constructs nectar_auth objects (#81)", {
  test_result <- auth_prepare(req_auth_api_key, "parm", api_key = "my_key")
  expect_s3_class(test_result, "nectar_auth")
  expect_identical(test_result$auth_fn, req_auth_api_key)
  expect_identical(
    test_result$auth_args,
    list("parm", api_key = "my_key")
  )
})
