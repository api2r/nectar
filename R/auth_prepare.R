#' Prepare authentication independent of a request
#'
#' This constructor stores an authentication function and arguments so the same
#' authentication strategy can be reused across requests.
#'
#' @inheritParams .shared-params
#' @param auth_fn (`function`) A function to use to authenticate a request.
#' @param ... (`any`) Arguments to pass to `auth_fn`.
#' @returns A list with class `"nectar_auth"` and elements `auth_fn` and
#'   `auth_args`.
#' @family opinionated auth functions
#' @export
#'
#' @examples
#' auth_prepare(req_auth_api_key, "X-API-Key", api_key = "my-api-key")
auth_prepare <- function(auth_fn, ..., call = rlang::caller_env()) {
  auth_fn <- rlang::as_function(auth_fn, call = call)
  .as_nectar_auth(
    list(auth_fn = auth_fn, auth_args = rlang::list2(...)),
    call = call
  )
}

.as_nectar_auth <- function(auth, call = rlang::caller_env()) {
  UseMethod(".as_nectar_auth")
}

#' @export
.as_nectar_auth.nectar_auth <- function(auth, call = rlang::caller_env()) {
  return(auth)
}

#' @export
.as_nectar_auth.NULL <- function(auth, call = rlang::caller_env()) {
  return(list(auth_fn = NULL, auth_args = list()))
}

#' @export
.as_nectar_auth.list <- function(auth, call = rlang::caller_env()) {
  if (!("auth_fn" %in% names(auth))) {
    return(NextMethod())
  }
  auth_args <- auth$auth_args %||% list()
  if (!is.list(auth_args)) {
    .nectar_abort(
      c(
        "{.arg auth$auth_args} must be a list.",
        x = "{.arg auth$auth_args} is {.obj_type_friendly {auth_args}}."
      ),
      subclass = "bad_auth_args",
      call = call
    )
  }
  if (setequal(names(auth), c("auth_fn", "auth_args"))) {
    auth$auth_args <- auth_args
    class(auth) <- "nectar_auth"
    return(auth)
  }
  structure(
    list(
      auth_fn = auth$auth_fn,
      auth_args = c(auth_args, auth[setdiff(names(auth), c("auth_fn", "auth_args"))])
    ),
    class = "nectar_auth"
  )
}

#' @export
.as_nectar_auth.default <- function(auth, call = rlang::caller_env()) {
  .nectar_abort(
    c(
      "{.arg {auth}} must be `NULL` or a {.cls nectar_auth}.",
      x = "{.arg {auth}} is {.obj_type_friendly {auth}}."
    ),
    subclass = "unsupported_auth_class",
    call = call
  )
}
