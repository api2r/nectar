#' Extract and clean a JSON API response
#'
#' Parse the body of a response with [httr2::resp_body_json()], extract a named
#' subset of that body, and tidy the result with [tibblify::tibblify()].
#'
#' @inheritParams .shared-params
#'
#' @returns The tibblified response body.
#' @family opinionated response parsers
#' @export
#'
#' @examplesIf rlang::is_installed("tibblify")
#' resp <- httr2::response_json(
#'   body = list(list(id = 1, name = "Alice"), list(id = 2, name = "Bob"))
#' )
#' resp_tidy_json(resp)
#'
#' # Extract a nested subset of the response body
#' resp_nested <- httr2::response_json(
#'   body = list(data = list(list(id = 1), list(id = 2)))
#' )
#' resp_tidy_json(resp_nested, subset_path = "data")
resp_tidy_json <- function(
  resp,
  spec = NULL,
  unspecified = "list",
  subset_path = NULL
) {
  rlang::check_installed(
    "tibblify",
    "to tidy the JSON response body."
  )
  # Let httr2 and tibblify validate their respective inputs, but check ours.
  subset_path <- stbl::to_chr(subset_path)
  result <- httr2::resp_body_json(resp)
  result <- purrr::pluck(result, !!!subset_path)
  if (length(result)) {
    return(
      tibblify::tibblify(
        result,
        spec = spec,
        unspecified = unspecified
      )
    )
  }
  return(NULL)
}

#' A policy to parse a response body as JSON
#'
#' Create a reusable tidy policy that applies [resp_tidy_json()].
#'
#' @inheritParams .shared-params
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated response parsers
#' @export
#'
#' @examplesIf rlang::is_installed("tibblify")
#' tidy_policy_json(subset_path = "data")
tidy_policy_json <- function(
  spec = NULL,
  unspecified = "list",
  subset_path = NULL
) {
  tidy_policy_prepare(
    resp_tidy_json,
    spec = spec,
    unspecified = unspecified,
    subset_path = subset_path
  )
}
