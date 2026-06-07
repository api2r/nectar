#' Extract and clean a JSON API response with tibblify
#'
#' Parse the body of a response with [resp_tidy_json()] and tidy the result with
#' [tibblify::tibblify()].
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
#' resp_tidy_json_tibblify(resp)
#'
#' # Extract a nested subset of the response body
#' resp_nested <- httr2::response_json(
#'   body = list(data = list(list(id = 1), list(id = 2)))
#' )
#' resp_tidy_json_tibblify(resp_nested, subset_path = "data")
resp_tidy_json_tibblify <- function(
  resp,
  spec = NULL,
  unspecified = "list",
  subset_path = NULL
) {
  rlang::check_installed(
    "tibblify",
    "to tidy the JSON response body."
  )
  result <- resp_tidy_json(
    resp = resp,
    subset_path = subset_path,
    simplifyVector = FALSE
  )
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
#' Create a reusable tidy policy that applies [resp_tidy_json_tibblify()].
#'
#' @inheritParams .shared-params
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated response parsers
#' @export
#'
#' @examplesIf rlang::is_installed("tibblify")
#' tidy_policy_json_tibblify(subset_path = "data")
tidy_policy_json_tibblify <- function(
  spec = NULL,
  unspecified = "list",
  subset_path = NULL
) {
  tidy_policy_prepare(
    resp_tidy_json_tibblify,
    spec = spec,
    unspecified = unspecified,
    subset_path = subset_path
  )
}
