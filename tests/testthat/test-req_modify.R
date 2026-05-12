# req_modify() -----------------------------------------------------------------

test_that("req_modify() returns an unmodified request when no args are given", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(req_base)
  expect_s3_class(test_result, "nectar_request")
  expect_identical(test_result$url, "https://example.com/")
})

test_that("req_modify() errors for unexpected dots", {
  req_base <- req_init("https://example.com")
  expect_error(req_modify(req_base, unexpected = "arg"))
})

test_that("req_modify() deals with paths", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(req_base, path = "foo/bar")
  expect_identical(test_result$url, "https://example.com/foo/bar")

  test_result <- req_modify(
    req_base,
    path = list("foo/{bar}", bar = "baz")
  )
  expect_identical(test_result$url, "https://example.com/foo/baz")
})

test_that("req_modify() uses query parameters", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
    query = list(foo = "bar", baz = "qux")
  )
  expect_identical(
    url_normalize(test_result$url),
    "https://example.com/?foo=bar&baz=qux"
  )
})

test_that("req_modify() uses the .multi arg", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
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

test_that("req_modify() removes empty query parameters", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
    query = list(foo = NULL, bar = "baz")
  )
  expect_identical(
    url_normalize(test_result$url),
    "https://example.com/?bar=baz"
  )
})

test_that("req_modify() uses body parameters", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
    body = list(foo = "bar", baz = "qux")
  )
  expect_identical(
    test_result$body$data,
    list(foo = "bar", baz = "qux")
  )
})

test_that("req_modify() handles bodies with paths", {
  req_base <- req_init("https://example.com")
  expect_snapshot({
    test_result <- req_modify(
      req_base,
      body = list(
        foo = "bar",
        baz = fs::path(test_path("fixtures", "img-test.png"))
      )
    )
    test_result$body
  })
  expect_identical(test_result$body$type, "multipart")
})

test_that("req_modify() applies methods", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(req_base, method = "PATCH")
  expect_identical(test_result$method, "PATCH")

  test_result <- req_modify(req_base)
  expect_null(test_result$method)

  test_result <- req_modify(req_base, body = list(a = 1))
  expect_null(test_result$method)
})

test_that("req_modify() applies headers", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
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

test_that("req_modify() uses NULL headers to remove previously-set headers", {
  req_base <- httr2::req_headers(
    req_init("https://example.com"),
    `X-Remove-Me` = "old-value"
  )
  test_result <- req_modify(
    req_base,
    header = list(
      `X-Custom-Header` = "value1",
      `X-Remove-Me` = NULL
    )
  )
  expect_in("X-Custom-Header", names(test_result$headers))
  expect_false("X-Remove-Me" %in% names(test_result$headers))
})

test_that("req_modify() applies cookies", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
    cookie = list(session_id = "abc123", user_pref = "dark_mode")
  )
  expect_true(grepl("session_id=abc123", test_result$options$cookie))
  expect_true(grepl("user_pref=dark_mode", test_result$options$cookie))
})

test_that("req_modify() removes NULL cookies", {
  req_base <- req_init("https://example.com")
  test_result <- req_modify(
    req_base,
    cookie = list(session_id = "abc123", empty_cookie = NULL)
  )
  expect_true(grepl("session_id=abc123", test_result$options$cookie))
  expect_false(grepl("empty_cookie", test_result$options$cookie))
})

# .prepare_body() --------------------------------------------------------------

test_that(".prepare_body() returns empty list for NULL body", {
  result <- .prepare_body(NULL)
  expect_length(result, 0)
})

test_that(".prepare_body() assigns json class for non-path body", {
  result <- .prepare_body(list(foo = "bar"))
  expect_s3_class(result, "json")
})

test_that(".prepare_body() assigns multipart class when body contains fs_path", {
  result <- .prepare_body(
    list(
      foo = "bar",
      baz = fs::path(test_path("fixtures", "img-test.png"))
    )
  )
  expect_s3_class(result, "multipart")
})

# .prepare_body_part() ---------------------------------------------------------

test_that(".prepare_body_part() wraps fs_path as form_file", {
  path <- fs::path(test_path("fixtures", "img-test.png"))
  result <- .prepare_body_part(path)
  expect_s3_class(result, "form_file")
})

test_that(".prepare_body_part() wraps non-path as form_data", {
  result <- .prepare_body_part(list(x = 1))
  expect_s3_class(result, "form_data")
})
