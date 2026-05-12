test_that("req_prepare() applies user agent (#10, #29)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    additional_user_agent = "foo"
  )
  this_version <- utils::packageVersion("nectar")
  expect_identical(
    test_result$options$useragent,
    unclass(glue::glue(
      "foo nectar/{this_version} (https://nectar.api2r.org)"
    ))
  )
})

test_that("req_prepare() deals with paths (#10)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    path = "foo/bar"
  )
  expect_identical(
    test_result$url,
    "https://example.com/foo/bar"
  )

  test_result <- req_prepare(
    base_url = "https://example.com",
    path = list(
      "foo/{bar}",
      bar = "baz"
    )
  )
  expect_identical(
    test_result$url,
    "https://example.com/foo/baz"
  )
})

test_that("req_prepare() uses query parameters (#5, #10, #11, #19)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    query = list(
      foo = "bar",
      baz = "qux"
    )
  )
  expect_identical(
    url_normalize(test_result$url),
    "https://example.com/?foo=bar&baz=qux"
  )
})

test_that("req_prepare() uses the .multi arg (#5, #11, #19)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    query = list(
      foo = "bar",
      baz = c("qux", "quux"),
      .multi = "comma"
    )
  )
  expect_identical(
    url_normalize(test_result$url),
    "https://example.com/?foo=bar&baz=qux%2Cquux"
  )
})

test_that("req_prepare() removes empty query parameters (#5, #11, #19)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    query = list(
      foo = NULL,
      bar = "baz"
    )
  )
  expect_identical(
    url_normalize(test_result$url),
    "https://example.com/?bar=baz"
  )
})

test_that("req_prepare() uses body parameters (#10)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    body = list(
      foo = "bar",
      baz = "qux"
    )
  )
  expect_identical(
    test_result$body$data,
    list(foo = "bar", baz = "qux")
  )
})

test_that("bodies with paths are handled properly (#6)", {
  expect_snapshot({
    test_result <- req_prepare(
      base_url = "https://example.com",
      body = list(
        foo = "bar",
        baz = fs::path(test_path("fixtures", "img-test.png"))
      )
    )
    test_result$body
  })
  expect_identical(test_result$body$type, "multipart")
})

test_that("req_prepare() applies methods (#5, #10, #11, #19)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    method = "PATCH"
  )
  expect_identical(
    test_result$method,
    "PATCH"
  )
  test_result <- req_prepare(
    base_url = "https://example.com"
  )
  expect_null(test_result$method)
  test_result <- req_prepare(
    base_url = "https://example.com",
    body = list(a = 1)
  )
  expect_null(test_result$method)
})

test_that("req_prepare() applies pagination", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    pagination_fn = httr2::iterate_with_offset("page")
  )
  expect_identical(
    test_result$policies$pagination$pagination_fn,
    httr2::iterate_with_offset("page")
  )
})

test_that("req_prepare() applies prepared tidying (#86)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    tidy_policy = tidy_policy_prepare(
      httr2::resp_body_json,
      simplifyVector = TRUE
    )
  )
  expect_s3_class(test_result$policies$resp_tidy, "nectar_tidy_policy")
  expect_identical(
    test_result$policies$resp_tidy,
    tidy_policy_prepare(
      httr2::resp_body_json,
      simplifyVector = TRUE
    )
  )
})

test_that("req_prepare() errors for unsupported tidy policy objects (#86)", {
  expect_error(
    req_prepare(
      base_url = "https://example.com",
      tidy_policy = "not_tidy_policy"
    ),
    class = "nectar-error-unsupported_tidy_policy_class"
  )
})

test_that("req_prepare() applies prepared auth (#81)", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    auth = auth_prepare(req_auth_api_key, "parm", api_key = "my_key")
  )
  expect_in(
    "parm",
    names(test_result$headers)
  )
})

test_that("req_prepare() applies headers", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    header = list(
      `X-Custom-Header` = "value1",
      `X-Another-Header` = "value2"
    )
  )
  expect_in("X-Custom-Header", names(test_result$headers))
  expect_in("X-Another-Header", names(test_result$headers))
  expect_identical(test_result$headers[["X-Custom-Header"]], "value1")
  expect_identical(test_result$headers[["X-Another-Header"]], "value2")
})

test_that("req_prepare() removes NULL headers", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    header = list(
      `X-Custom-Header` = "value1",
      `X-Null-Header` = NULL
    )
  )
  expect_in("X-Custom-Header", names(test_result$headers))
  expect_false("X-Null-Header" %in% names(test_result$headers))
})

test_that("req_prepare() applies cookies", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    cookie = list(
      session_id = "abc123",
      user_pref = "dark_mode"
    )
  )
  expect_true(grepl("session_id=abc123", test_result$options$cookie))
  expect_true(grepl("user_pref=dark_mode", test_result$options$cookie))
})

test_that("req_prepare() removes NULL cookies", {
  test_result <- req_prepare(
    base_url = "https://example.com",
    cookie = list(
      session_id = "abc123",
      empty_cookie = NULL
    )
  )
  expect_true(grepl("session_id=abc123", test_result$options$cookie))
  expect_false(grepl("empty_cookie", test_result$options$cookie))
})

test_that("req_prepare() errors for unsupported auth objects (#81)", {
  expect_error(
    req_prepare(
      base_url = "https://example.com",
      auth = "not_auth"
    ),
    class = "nectar-error-unsupported_auth_class"
  )
})

test_that(".as_nectar_request() fails gracefully for non-reqs", {
  test_obj <- 1
  expect_nectar_error_snapshot(
    .as_nectar_request(test_obj),
    "unsupported_request_class"
  )
})
