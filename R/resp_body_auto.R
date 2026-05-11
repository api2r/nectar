#' Automatically choose a body parser
#'
#' Use the `Content-Type` header (extracted using [httr2::resp_content_type()])
#' of a response to automatically choose and apply a body parser, such as
#' [httr2::resp_body_json()] or [resp_body_csv()].
#'
#' @inheritParams .shared-params
#'
#' @returns The parsed response body.
#' @export
#'
#' @examples
#' resp_json <- httr2::response_json(body = list(a = 1, b = "hello"))
#' resp_body_auto(resp_json)
#'
#' resp_csv <- httr2::response(
#'   headers = list("Content-Type" = "text/csv"),
#'   body = charToRaw("a,b\n1,2\n3,4")
#' )
#' resp_body_auto(resp_csv)
resp_body_auto <- function(resp) {
  content_type <- httr2::resp_content_type(resp)
  switch(
    content_type,
    "application/json" = httr2::resp_body_json(resp),
    "application/xml" = httr2::resp_body_xml(resp),
    "text/xml" = httr2::resp_body_xml(resp),
    "application/xhtml+xml" = httr2::resp_body_html(resp),
    "text/html" = httr2::resp_body_html(resp),
    "text/csv" = resp_body_csv(resp),
    "text/tab-separated-values" = resp_body_tsv(resp),
    "image/svg+xml" = httr2::resp_body_string(resp),
    .resp_body_auto_other(resp)
  )
}

#' Prepare an automatic body tidy policy independent of a request
#'
#' This helper creates a reusable tidy policy that applies [resp_body_auto()].
#'
#' @inheritParams .shared-params
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated request functions
#' @export
#'
#' @examples
#' tidy_policy_body_auto()
tidy_policy_body_auto <- function(call = rlang::caller_env()) {
  tidy_policy_prepare(resp_body_auto)
}

#' Automatically choose more body parsers
#'
#' This helper function exists to find somewhat variable content types and
#' attempt to send them to the proper body parser.
#'
#' @inheritParams .shared-params
#' @inherit resp_body_auto return
#' @keywords internal
.resp_body_auto_other <- function(resp) {
  content_type <- httr2::resp_content_type(resp)
  if (grepl("application/(.*)\\+json", content_type)) {
    return(httr2::resp_body_json(resp))
  }
  if (grepl("text/(.*)", content_type)) {
    return(httr2::resp_body_string(resp))
  }
  return(httr2::resp_body_raw(resp))
}
