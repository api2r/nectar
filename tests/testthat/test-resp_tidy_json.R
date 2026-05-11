test_that("resp_tidy_json fails gracefully with a bad subset_path (#40)", {
  stbl::expect_pkg_error_classes(
    resp_tidy_json(subset_path = list(a = 1:10, b = mean), resp = NULL),
    package = "stbl",
    "coerce",
    "character"
  )
})

test_that("resp_tidy_json returns NULL for an empty body (#40)", {
  mock_response <- httr2::response_json(body = list())
  expect_null(resp_tidy_json(mock_response))
})

test_that("resp_tidy_json tidies a response (#40)", {
  target_tibble <- tibble::tibble(
    a = letters,
    b = LETTERS,
    c = 1:26
  )
  mock_response <- httr2::response_json(
    body = target_tibble
  )
  expect_identical(
    resp_tidy_json(mock_response),
    target_tibble
  )
})

test_that("resp_tidy_json subsets a response (#40)", {
  target_tibble <- tibble::tibble(
    a = letters,
    b = LETTERS,
    c = 1:26
  )
  mock_response <- httr2::response_json(
    body = list(
      ok = TRUE,
      data = list(
        target_tibble = target_tibble
      )
    )
  )
  expect_identical(
    resp_tidy_json(mock_response, subset_path = c("data", "target_tibble")),
    target_tibble
  )
})

test_that("resp_tidy_json tidies a response with a spec (#40)", {
  source_tibble <- tibble::tibble(
    a = letters,
    b = LETTERS,
    c = 1:26
  )
  target_tibble <- tibble::tibble(
    lc = letters,
    uc = LETTERS,
    n = 1:26
  )
  mock_response <- httr2::response_json(
    body = source_tibble
  )
  spec <- tibblify::tspec_df(
    lc = tibblify::tib_chr("a"),
    uc = tibblify::tib_chr("b"),
    n = tibblify::tib_int("c"),
  )
  expect_identical(
    resp_tidy_json(mock_response, spec = spec),
    target_tibble
  )
})

test_that("tidy_policy_json() prepares resp_tidy_json for resp_tidy() (#40, #86)", {
  source_tibble <- tibble::tibble(
    a = letters,
    b = LETTERS,
    c = 1:26
  )
  target_tibble <- tibble::tibble(
    lc = letters,
    uc = LETTERS,
    n = 1:26
  )
  mock_response <- httr2::response_json(
    body = source_tibble
  )
  mock_response$request <- list(
    policies = list(
      resp_tidy = tidy_policy_json(
        spec = tibblify::tspec_df(
          lc = tibblify::tib_chr("a"),
          uc = tibblify::tib_chr("b"),
          n = tibblify::tib_int("c"),
        )
      )
    )
  )
  expect_identical(
    resp_tidy(mock_response),
    target_tibble
  )
})
