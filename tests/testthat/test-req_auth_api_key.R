test_that("req_auth_api_key errors informatively with unused arguments", {
  expect_error(
    {
      req_auth_api_key(
        httr2::request("https://example.com"),
        location = "header",
        api_key = "ok",
        file_path = "bad"
      )
    },
    class = "rlib_error_dots_nonempty"
  )
})

test_that("req_auth_api_key returns req unchanged if api_key is NA or empty (#76)", {
  req <- httr2::request("https://example.com")
  expect_identical(req, req_auth_api_key(req, "parm", api_key = NA_character_))
  expect_identical(req, req_auth_api_key(req, "parm", api_key = ""))
})

test_that("req_auth_api_key removes the key when api_key is NULL (#76)", {
  req <- httr2::request("https://example.com")

  # Header: NULL removes a previously-set header
  req_with_header <- req_auth_api_key(req, "parm", api_key = "my_key")
  req_removed <- req_auth_api_key(req_with_header, "parm", api_key = NULL)
  expect_false("parm" %in% names(req_removed$headers))

  # Query: NULL removes a previously-set query parameter
  req_with_query <- req_auth_api_key(
    req,
    "parm",
    api_key = "my_key",
    location = "query"
  )
  req_removed <- req_auth_api_key(
    req_with_query,
    "parm",
    api_key = NULL,
    location = "query"
  )
  expect_false(grepl("parm", req_removed$url))

  # Cookie: NULL removes a previously-set cookie
  req_with_cookie <- req_auth_api_key(req, "parm", api_key = "my_key", location = "cookie")
  req_removed <- req_auth_api_key(req_with_cookie, "parm", api_key = NULL, location = "cookie")
  expect_false(grepl("parm", req_removed$options$cookie %||% ""))
})

test_that("req_auth_api_key works for header (#8)", {
  test_result <- req_auth_api_key(
    httr2::request("https://example.com"),
    parameter_name = "parm",
    api_key = "my_key"
  )
  expect_in(
    names(test_result$headers),
    "parm"
  )
  expect_type(
    test_result$headers$parm,
    "weakref"
  )

  test_result <- req_auth_api_key(
    httr2::request("https://example.com"),
    parameter_name = "parm",
    api_key = "my_key",
    location = "header"
  )
  expect_in(
    names(test_result$headers),
    "parm"
  )
  expect_type(
    test_result$headers$parm,
    "weakref"
  )
})

test_that("req_auth_api_key works for query (#8)", {
  test_result <- req_auth_api_key(
    httr2::request("https://example.com"),
    parameter_name = "parm",
    api_key = "my_key",
    location = "query"
  )
  # In httr2 <=1.0.7, path can be NULL. in 1.1.0+, path is normalized to at
  # least "/". Normalize to make sure this test passes in both of those
  # versions.
  test_result$url <- stringr::str_replace(
    test_result$url,
    stringr::fixed("example.com?parm"),
    stringr::fixed("example.com/?parm")
  )
  expect_identical(
    test_result$url,
    "https://example.com/?parm=my_key"
  )
})

test_that("req_auth_api_key works for cookies (#30)", {
  test_result <- req_auth_api_key(
    httr2::request("https://example.com"),
    parameter_name = "parm",
    api_key = "my_key",
    location = "cookie"
  )
  expect_in(
    test_result$options,
    list(cookie = "parm=my_key")
  )
})
