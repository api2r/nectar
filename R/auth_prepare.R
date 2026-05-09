#' Prepare authentication independent of a request
#'
#' This constructor stores an authentication function and arguments so the same
#' authentication strategy can be reused across requests.
#'
#' @inheritParams .shared-params
#' @inheritParams rlang::args_dots_empty
#' @param auth_fn (`function`) A function to use to authenticate a request.
#' @returns A list with class `"nectar_auth"` and elements `auth_fn` and
#'   `auth_args`.
#' @family opinionated request functions
#' @export
#'
#' @examples
#' auth_prepare(req_auth_api_key, "X-API-Key", api_key = "my-api-key")
auth_prepare <- function(auth_fn, ..., call = rlang::caller_env()) {
  auth_fn <- rlang::as_function(auth_fn, call = call)
  structure(
    list(auth_fn = auth_fn, auth_args = rlang::list2(...)),
    class = "nectar_auth"
  )
}

.as_nectar_auth <- function(auth, call = rlang::caller_env()) {
  if (is.null(auth)) {
    return(list(auth_fn = NULL, auth_args = list()))
  }
  if (inherits(auth, "nectar_auth")) {
    return(auth)
  }
  .nectar_abort(
    c(
      "{.arg {auth}} must be `NULL` or a {.cls nectar_auth}.",
      x = "{.arg {auth}} is {.obj_type_friendly {auth}}."
    ),
    subclass = "unsupported_auth_class",
    call = call
  )
}
