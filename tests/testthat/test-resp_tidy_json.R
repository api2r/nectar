test_that("resp_tidy_json fails gracefully with a bad subset_path (#95)", {
  stbl::expect_pkg_error_classes(
    resp_tidy_json(subset_path = list(a = 1:10, b = mean), resp = NULL),
    package = "stbl",
    "coerce",
    "character"
  )
})

test_that("resp_tidy_json returns NULL for an empty body (#95)", {
  mock_response <- httr2::response_json(body = list())
  expect_null(resp_tidy_json(mock_response))
})

test_that("resp_tidy_json returns parsed JSON directly (#95)", {
  target <- list(
    list(a = "x", b = 1L),
    list(a = "y", b = 2L)
  )
  mock_response <- httr2::response_json(body = target)
  expect_identical(resp_tidy_json(mock_response), target)
})

test_that("resp_tidy_json subsets a response (#95)", {
  target <- list(list(a = "x"), list(a = "y"))
  mock_response <- httr2::response_json(
    body = list(ok = TRUE, data = list(target = target))
  )
  expect_identical(
    resp_tidy_json(mock_response, subset_path = c("data", "target")),
    target
  )
})

test_that("resp_tidy_json passes simplifyVector to httr2::resp_body_json (#95)", {
  target <- data.frame(a = c("x", "y"), b = c(1, 2))
  mock_response <- httr2::response_json(
    body = list(list(a = "x", b = 1), list(a = "y", b = 2))
  )
  expect_equal(resp_tidy_json(mock_response, simplifyVector = TRUE), target)
})

test_that("tidy_policy_json() prepares parser for resp_tidy() (#95)", {
  target <- list(list(a = "x"), list(a = "y"))
  mock_response <- httr2::response_json(body = list(data = target))
  mock_response$request <- list(
    policies = list(
      resp_tidy = tidy_policy_json(subset_path = "data")
    )
  )
  expect_identical(resp_tidy(mock_response), target)
})
