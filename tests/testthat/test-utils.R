# .check_httr2_response --------------------------------------------------------

test_that(".check_httr2_response returns input for valid httr2_response (#noissue)", {
  mock_response <- httr2::response_json(body = list(a = 1))
  expect_identical(.check_httr2_response(mock_response), mock_response)
})

test_that(".check_httr2_response errors with not_httr2_response for non-response (#noissue)", {
  expect_nectar_error_snapshot(
    .check_httr2_response(1),
    "not_httr2_response"
  )
})

# compact_nested_list ----------------------------------------------------------

test_that("compact_nested_list removes NULLs recursively (#noissue)", {
  x <- list(
    a = list(b = 1, c = NULL),
    d = NULL,
    e = 2
  )
  expect_identical(
    compact_nested_list(x),
    list(a = list(b = 1), e = 2)
  )
})

test_that(".compact_nested_list_impl skips recursion at depth 20 (#noissue)", {
  result <- .compact_nested_list_impl(list(a = 1, b = NULL), depth = 20L)
  expect_identical(result, list(a = 1))
})

# url_path_append / url_normalize ----------------------------------------------

test_that("Can build clean urls (#noissue)", {
  expected_result <- "https://example.com/api/v1/users"
  expect_identical(
    url_path_append("https://example.com", "api", "v1", "users"),
    expected_result
  )
  expect_identical(
    url_path_append("https://example.com/", "/api", "/v1", "/users"),
    expected_result
  )
  expect_identical(
    url_path_append("https://example.com/", "/api/v1/users"),
    expected_result
  )
})

test_that("url_normalize produces the same URL with or without a trailing slash (#noissue)", {
  expect_identical(
    url_normalize("https://example.com"),
    url_normalize("https://example.com/")
  )
})

# do_if_fn_defined -------------------------------------------------------------

test_that("do_if_fn_defined returns x unchanged when fn is NULL (#noissue)", {
  expect_identical(do_if_fn_defined(42L), 42L)
})

test_that("do_if_fn_defined applies fn to x when fn is provided (#noissue)", {
  expect_identical(do_if_fn_defined(5, \(x) x * 2), 10)
  expect_identical(do_if_fn_defined(5, \(x, y) x + y, 3), 8)
})

# .do_if_args_defined ----------------------------------------------------------

test_that(".do_if_args_defined returns x unchanged when all args are NULL (#noissue)", {
  expect_identical(.do_if_args_defined(42L, sum, a = NULL), 42L)
})

test_that(".do_if_args_defined applies fn when non-NULL args are provided (#noissue)", {
  expect_identical(.do_if_args_defined(5, \(x, y) x + y, y = 3), 8)
})

# get_pkg_name -----------------------------------------------------------------

test_that("get_pkg_name returns NULL when called outside a package (#noissue)", {
  expect_null(get_pkg_name(globalenv()))
})

test_that("get_pkg_name returns the package name when called from a package namespace (#noissue)", {
  expect_identical(
    get_pkg_name(rlang::ns_env("rlang")),
    "rlang"
  )
})

# .get_pkg_version -------------------------------------------------------------

test_that(".get_pkg_version returns a character version for an installed package (#noissue)", {
  expect_identical(
    .get_pkg_version("base"),
    paste(R.Version()$major, R.Version()$minor, sep = ".")
  )
})

test_that(".get_pkg_version errors for a non-string pkg_name (#noissue)", {
  stbl::expect_pkg_error_classes(
    .get_pkg_version(mean),
    "stbl",
    "coerce",
    "character"
  )
})

test_that(".get_pkg_version errors for an uninstalled package (#noissue)", {
  expect_error(
    .get_pkg_version("nonexistent_package_xyz_abc"),
    "required to find the package version"
  )
})
