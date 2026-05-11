#' Error informatively for unknown response types
#'
#' If you have not defined a parser for a response type, use this function to
#' return useful information to help construct a parser.
#'
#' @inheritParams .shared-params
#'
#' @returns This function always throws an error. The error lists the names of
#'   the response pieces after parsing with [resp_body_auto()].
#' @family opinionated response parsers
#' @export
#'
#' @examples
#' resp <- httr2::response_json(body = list(status = "ok", data = list(id = 1)))
#' try(
#'   resp_tidy_unknown(resp)
#' )
resp_tidy_unknown <- function(resp, call = rlang::caller_env()) {
  results <- resp_body_auto(resp)
  .nectar_abort(
    c(
      "No parser is defined for this response.",
      i = "Response pieces: {names(results)}"
    ),
    subclass = "unknown_response_type",
    call = call
  )
}

#' A policy to error for unknown response bodies
#'
#' Create a reusable tidy policy that applies [resp_tidy_unknown()], signaling
#' an informative error.
#'
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated response parsers
#' @export
#'
#' @examples
#' tidy_policy_unknown()
tidy_policy_unknown <- function() {
  tidy_policy_prepare(resp_tidy_unknown)
}
