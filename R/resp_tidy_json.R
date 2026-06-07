#' Extract and optionally subset a JSON API response
#'
#' Parse the body of a response with [httr2::resp_body_json()] and optionally
#' extract a named subset of that body.
#'
#' @inheritParams .shared-params
#' @inheritParams httr2::resp_body_json
#'
#' @returns The parsed response body, or `NULL` for an empty result.
#' @family opinionated response parsers
#' @export
#'
#' @examples
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
resp_tidy_json <- function(resp, subset_path = NULL, simplifyVector = FALSE) {
  # Let httr2 validate its own inputs, but check ours.
  subset_path <- stbl::to_chr(subset_path)
  result <- httr2::resp_body_json(resp, simplifyVector = simplifyVector)
  result <- purrr::pluck(result, !!!subset_path)
  if (length(result)) {
    return(result)
  }
  return(NULL)
}

#' A policy to parse a response body as JSON
#'
#' Create a reusable tidy policy that applies [resp_tidy_json()].
#'
#' @inheritParams .shared-params
#' @inheritParams httr2::resp_body_json
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated response parsers
#' @export
#'
#' @examples
#' tidy_policy_json(subset_path = "data")
tidy_policy_json <- function(subset_path = NULL, simplifyVector = FALSE) {
  tidy_policy_prepare(
    resp_tidy_json,
    subset_path = subset_path,
    simplifyVector = simplifyVector
  )
}
