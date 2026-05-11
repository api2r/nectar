test_that("resp_tidy_unknown fails gracefully with object information", {
  target_tibble <- tibble::tibble(
    a = letters,
    b = LETTERS,
    c = 1:26
  )
  mock_response <- httr2::response_json(
    body = list(
      structured = target_tibble,
      other = 1:5,
      status = "ok"
    )
  )

  expect_nectar_error_snapshot(
    resp_tidy_unknown(mock_response),
    "unknown_response_type"
  )
})

test_that("tidy_policy_unknown() prepares resp_tidy_unknown for resp_tidy() (#86)", {
  mock_response <- httr2::response_json(
    body = list(status = "ok", data = list(id = 1))
  )
  mock_response$request <- list(
    policies = list(
      resp_tidy = tidy_policy_unknown()
    )
  )

  expect_nectar_error_snapshot(
    resp_tidy(mock_response),
    "unknown_response_type"
  )
})
