#' Extract and clean a JSON API response
#'
#' Parse the body of a response with [httr2::resp_body_json()], extract a named
#' subset of that body, and tidy the result with [tibblify::tibblify()].
#'
#' @inheritParams .shared-params
#' @param spec (`tspec` or `NULL`) A specification used by
#'   [tibblify::tibblify()] to parse the extracted body of `resp`. When `spec`
#'   is `NULL` (the default), [tibblify::tibblify()] will attempt to guess a
#'   spec.
#' @param unspecified (`length-1 character`) A string that describes what
#'   happens if the extracted body of `resp` contains fields that are not
#'   specified in `spec`. While [tibblify::tibblify()] defaults to `NULL` for
#'   this value, we set it to `list` so that the body will still parse when
#'   `resp` contains extra data without throwing errors.
#' @param subset_path (`character`) An optional vector indicating the path to
#'   the "real" object within the body of `resp`. For example, many APIs return
#'   a body with information about the status of the response, cache
#'   information, perhaps pagination information, and then the actual data in a
#'   field such as `data`. If the desired part of the response body is in
#'   `data$objects`, the value of this argument should be `c("data", "object")`.
#'
#' @returns The tibblified response body.
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

#' Prepare a JSON tidy policy independent of a request
#'
#' This helper creates a reusable tidy policy that applies [resp_tidy_json()].
#'
#' @param spec (`tspec` or `NULL`) A specification used by
#'   [tibblify::tibblify()] to parse the extracted body of `resp`. When `spec`
#'   is `NULL` (the default), [tibblify::tibblify()] will attempt to guess a
#'   spec.
#' @param unspecified (`length-1 character`) A string that describes what
#'   happens if the extracted body of `resp` contains fields that are not
#'   specified in `spec`. While [tibblify::tibblify()] defaults to `NULL` for
#'   this value, we set it to `list` so that the body will still parse when
#'   `resp` contains extra data without throwing errors.
#' @param subset_path (`character`) An optional vector indicating the path to
#'   the "real" object within the body of `resp`.
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated request functions
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
