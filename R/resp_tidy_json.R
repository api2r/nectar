#' Extract and optionally subset a JSON API response
#'
#' Parse the body of a response with [httr2::resp_body_json()] and optionally
#' extract a named subset of that body.
#'
#' @param resp (`httr2_response`) A single [httr2::response()] object (as
#'   returned by [httr2::req_perform()]).
#' @param subset_path (`character`) An optional vector indicating the path to
#'   the "real" object within the body of `resp`. For example, many APIs return
#'   a body with information about the status of the response, cache
#'   information, perhaps pagination information, and then the actual data in a
#'   field such as `data`. If the desired part of the response body is in
#'   `data$objects`, the value of this argument should be `c("data", "object")`.
#' @param simplifyVector (`length-1 logical`) Should JSON arrays containing only
#'   primitives and records be simplified to atomic vectors and data frames?
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
#' @param subset_path (`character`) An optional vector indicating the path to
#'   the "real" object within the body of `resp`. For example, many APIs return
#'   a body with information about the status of the response, cache
#'   information, perhaps pagination information, and then the actual data in a
#'   field such as `data`. If the desired part of the response body is in
#'   `data$objects`, the value of this argument should be `c("data", "object")`.
#' @param simplifyVector (`length-1 logical`) Should JSON arrays containing only
#'   primitives and records be simplified to atomic vectors and data frames?
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
