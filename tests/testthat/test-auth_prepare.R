test_that("auth_prepare() constructs nectar_auth objects (#81)", {
  test_result <- auth_prepare(req_auth_api_key, "parm", api_key = "my_key")
  expect_s3_class(test_result, "nectar_auth")
  expect_identical(test_result$auth_fn, req_auth_api_key)
  expect_identical(
    test_result$auth_args,
    list("parm", api_key = "my_key")
  )
})

test_that(".as_nectar_auth() returns nectar_auth objects unchanged (#81)", {
  test_input <- auth_prepare(
    auth_fn = req_auth_api_key,
    auth_args = list(parameter_name = "parm")
  )
  test_result <- .as_nectar_auth(test_input)
  expect_identical(test_result, test_input)
})

test_that(".as_nectar_auth() returns NULL auth_fn and empty auth_args for NULL input (#81)", {
  test_result <- .as_nectar_auth(NULL)
  expect_identical(test_result$auth_fn, NULL)
  expect_identical(test_result$auth_args, list())
})

test_that(".as_nectar_auth() errors for list without auth_fn (#81)", {
  stbl::expect_pkg_error_classes(
    .as_nectar_auth(list(auth_args = list(parameter_name = "parm"))),
    "nectar",
    class = "unsupported_auth_class"
  )
})

test_that(".as_nectar_auth() converts function input to nectar_auth (#81)", {
  test_result <- .as_nectar_auth(req_auth_api_key)
  expect_s3_class(test_result, "nectar_auth")
  expect_identical(test_result$auth_fn, req_auth_api_key)
  expect_identical(test_result$auth_args, list())
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

test_that(".as_nectar_auth() errors for non-listable auth_args (#81)", {
  stbl::expect_pkg_error_classes(
    .as_nectar_auth(list(auth_fn = req_auth_api_key, auth_args = mean)),
    "stbl",
    class = "bad_function"
  )
})
