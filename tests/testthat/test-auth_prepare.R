test_that("auth_prepare() constructs nectar_auth objects (#81)", {
  test_result <- auth_prepare(req_auth_api_key, "parm", api_key = "my_key")
  expect_s3_class(test_result, "nectar_auth")
  expect_identical(test_result$auth_fn, req_auth_api_key)
  expect_identical(
    test_result$auth_args,
    list("parm", api_key = "my_key")
  )
})

test_that(".as_nectar_auth() merges auth_args with additional auth fields (#81)", {
  test_result <- .as_nectar_auth(list(
    auth_fn = req_auth_api_key,
    auth_args = list(parameter_name = "parm"),
    api_key = "my_key",
    location = "query"
  ))
  expect_s3_class(test_result, "nectar_auth")
  expect_identical(
    test_result$auth_args,
    list(parameter_name = "parm", api_key = "my_key", location = "query")
  )
})

test_that(".as_nectar_auth() errors for non-list auth_args (#81)", {
  expect_error(
    .as_nectar_auth(list(auth_fn = req_auth_api_key, auth_args = "not-a-list")),
    class = "nectar-error-bad_auth_args"
  )
})
