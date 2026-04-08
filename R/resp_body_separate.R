#' Extract response body into list
#'
#' Wrap the parsed response body in a [list()]. Unlike [resp_body_auto()], this
#' function prevents individual response bodies from being concatenated when
#' combining multiple responses, which is useful for raw or otherwise
#' non-concatenatable types.
#'
#' @inheritParams .shared-params
#'
#' @returns The parsed response body wrapped in a [list()]. This is useful for
#'   things like raw vectors that you wish to parse with [httr2::resps_data()].
#' @export
#'
#' @examples
#' resp <- httr2::response_json(body = list(a = 1, b = "hello"))
#' resp_body_separate(resp)
resp_body_separate <- function(resp, resp_body_fn = resp_body_auto) {
  list(resp_body_fn(resp))
}
