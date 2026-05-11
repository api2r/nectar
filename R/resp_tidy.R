#' Extract and clean an API response
#'
#' API responses generally follow a structured format. Use this function to
#' extract the relevant portion of a response, and wrangle it into a desired
#' format. This function is most useful when the response was fetched with a
#' request that includes a tidying policy defined via [req_tidy_policy()].
#'
#' @inheritParams .shared-params
#'
#' @returns The extracted and cleaned response, or `NULL` if `resp` is `NULL`.
#'   By default, the response is processed with [resp_body_auto()]. If the
#'   request includes a `resp_tidy` policy (set via [req_tidy_policy()]), that
#'   policy's function and arguments are used instead.
#'
#' @family opinionated response parsers
#' @export
#'
#' @examples
#' # Without a tidy policy, resp_tidy() uses resp_body_auto()
#' resp <- httr2::response_json(body = list(a = 1, b = "hello"))
#' resp_tidy(resp)
#'
#' # With a tidy policy, resp_tidy() uses the policy's tidy function.
#' req <- req_tidy_policy(
#'   httr2::request("https://example.com"),
#'   tidy_policy_prepare(httr2::resp_body_json)
#' )
#' # In practice, the request is attached automatically when the response is
#' # fetched with httr2::req_perform() or req_perform_opinionated().
#' resp$request <- req
#' resp_tidy(resp)
resp_tidy <- function(resp) {
  if (is.null(resp)) return(NULL)
  check_httr2_response(resp)
  req <- httr2::resp_request(resp)
  if (length(req$policies$resp_tidy)) {
    return(
      rlang::exec(
        req$policies$resp_tidy$tidy_fn,
        resp,
        !!!req$policies$resp_tidy$tidy_args
      )
    )
  }
  resp_body_auto(resp)
}
