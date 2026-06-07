test_that("resp_tidy_json_tibblify fails gracefully with a bad subset_path (#95)", {
  stbl::expect_pkg_error_classes(
    resp_tidy_json_tibblify(
      subset_path = list(a = 1:10, b = mean),
      resp = NULL
    ),
    package = "stbl",
    "coerce",
    "character"
  )
})

test_that("resp_tidy_json_tibblify returns NULL for an empty body (#95)", {
  mock_response <- httr2::response_json(body = list())
  expect_null(resp_tidy_json_tibblify(mock_response))
})

test_that("resp_tidy_json_tibblify tidies a response (#95)", {
  target_tibble <- tibble::tibble(
    a = letters,
    b = LETTERS,
    c = 1:26
  )
  mock_response <- httr2::response_json(
    body = target_tibble
  )
  expect_identical(
    resp_tidy_json_tibblify(mock_response),
    target_tibble
  )
})

test_that("resp_tidy_json_tibblify subsets a response (#95)", {
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
    resp_tidy_json_tibblify(
      mock_response,
      subset_path = c("data", "target_tibble")
    ),
    target_tibble
  )
})

test_that("resp_tidy_json_tibblify tidies a response with a spec (#95)", {
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
    resp_tidy_json_tibblify(mock_response, spec = spec),
    target_tibble
  )
})

test_that("resp_tidy_json_tibblify calls resp_tidy_json with simplifyVector = FALSE (#95)", {
  mock_response <- httr2::response_json(body = list(list(a = 1)))
  local_mocked_bindings(
    resp_tidy_json = function(resp, subset_path, simplifyVector) {
      expect_identical(resp, mock_response)
      expect_null(subset_path)
      expect_false(simplifyVector)
      list(list(a = 1))
    }
  )
  expect_identical(
    resp_tidy_json_tibblify(mock_response),
    tibble::tibble(a = 1)
  )
})

test_that("tidy_policy_json_tibblify() prepares parser for resp_tidy() (#95)", {
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
      resp_tidy = tidy_policy_json_tibblify(
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
