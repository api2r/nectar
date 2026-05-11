test_that("resp_tidy returns NULL for NULL input (#88)", {
  expect_null(resp_tidy(NULL))
})

test_that("resp_tidy errors for non-response input (#88)", {
  expect_nectar_error_snapshot(
    resp_tidy(1),
    "not_httr2_response"
  )
})

test_that("resp_tidy parses json-containing httr2_response objects (#40, #88)", {
  mock_response <- httr2::response_json(body = 1:3)
  test_result <- resp_tidy(mock_response)
  expect_identical(test_result, as.list(1:3))
})

test_that("resp_tidy parses httr2_response objects with resp_tidy policy (#40, #88)", {
  mock_response <- httr2::response_json(body = 1:3)
  mock_response$request <- list(
    policies = list(
      resp_tidy = list(
        tidy_fn = function(resp) {
          unlist(httr2::resp_body_json(resp))
        }
      )
    )
  )
  test_result <- resp_tidy(mock_response)
  expect_identical(test_result, 1:3)
})

test_that("resp_tidy uses policies$resp_tidy$tidy_args (#40, #88)", {
  mock_response <- httr2::response_json(body = 1:3)
  mock_response$request <- list(
    policies = list(
      resp_tidy = list(
        tidy_fn = function(resp, additional) {
          c(unlist(httr2::resp_body_json(resp)), additional)
        },
        tidy_args = list(additional = 4:6)
      )
    )
  )
  test_result <- resp_tidy(mock_response)
  expect_identical(test_result, 1:6)
})
