#' Authenticate with an API key
#'
#' Many APIs provide API keys that can be used to authenticate requests (or,
#' often, provide other information about the user). This function helps to
#' apply those keys to requests.
#'
#' @inheritParams .shared-params
#' @inheritParams rlang::args_dots_empty
#'
#' @inherit .shared-request return
#' @family opinionated auth functions
#' @export
#'
#' @examples
#' req <- httr2::request("https://example.com")
#'
#' # Add an API key named `"X-API-Key"` as a header (default)
#' req_auth_api_key(req, "X-API-Key", api_key = "my-api-key")
#'
#' # Add an API key named `"api_key"` as a query parameter
#' req_auth_api_key(req, "api_key", api_key = "my-api-key", location = "query")
#'
#' # If `api_key` is NULL, the key is removed from the request
#' req_auth_api_key(req, "X-API-Key", api_key = NULL)
req_auth_api_key <- function(
  req,
  parameter_name,
  ...,
  api_key = NULL,
  location = c("header", "query", "cookie"),
  call = rlang::caller_env()
) {
  rlang::check_dots_empty(call = call)
  parameter_name <- stbl::stabilize_chr_scalar(
    parameter_name,
    allow_na = FALSE,
    call = call
  )
  api_key <- stbl::to_chr_scalar(api_key, allow_null = TRUE, call = call)
  # Return without failing if api_key is NA or empty. This makes it easier to
  # set up APIs that change behavior when an API key is set, without failing
  # when the key is empty or missing. Note: NULL is passed through to httr2,
  # which will *remove* the api key from the request.
  if (length(api_key) && (is.na(api_key) || !nzchar(api_key))) {
    return(req)
  }
  location <- rlang::arg_match(location, error_call = call)
  req_api_key_set <- switch(
    location,
    header = httr2::req_headers_redacted,
    query = httr2::req_url_query,
    cookie = httr2::req_cookies_set
  )
  req <- rlang::exec(req_api_key_set, req, !!parameter_name := api_key)
  return(req)
}

#' Prepare API key authentication independent of a request
#'
#' This helper creates a reusable authentication object that can be passed to
#' [req_prepare()] via `auth`.
#'
#' @inheritParams .shared-params
#' @inheritParams rlang::args_dots_empty
#' @returns A list with class `"nectar_auth"` and elements `auth_fn` and
#'   `auth_args`.
#' @family opinionated auth functions
#' @export
#'
#' @examples
#' auth_api_key("X-API-Key", api_key = "my-api-key")
auth_api_key <- function(
  parameter_name,
  ...,
  api_key = NULL,
  location = c("header", "query", "cookie"),
  call = rlang::caller_env()
) {
  rlang::check_dots_empty(call = call)
  location <- rlang::arg_match(location, error_call = call)
  auth_prepare(
    req_auth_api_key,
    parameter_name = parameter_name,
    api_key = api_key,
    location = location,
    call = call
  )
}
