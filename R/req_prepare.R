#' Prepare a request for an API
#'
#' This function implements an opinionated framework for preparing an API
#' request. It is intended to be used inside an API client package. It serves as
#' a wrapper around the `req_` family of functions, such as [httr2::request()].
#'
#' @inheritParams rlang::args_dots_empty
#' @inheritParams .shared-params
#' @inherit .shared-request return
#' @family opinionated request functions
#' @export
#'
#' @examples
#' req_prepare("https://example.com")
#' req_prepare(
#'   "https://example.com",
#'   path = c("users/{user_id}", user_id = "42"),
#'   query = list(format = "json")
#' )
req_prepare <- function(
  base_url,
  ...,
  path = NULL,
  query = NULL,
  body = NULL,
  mime_type = NULL,
  method = NULL,
  additional_user_agent = NULL,
  auth = NULL,
  tidy_policy = tidy_policy_body_auto,
  pagination_fn = NULL,
  call = rlang::caller_env()
) {
  rlang::check_dots_empty()
  req <- req_init(
    base_url,
    additional_user_agent = additional_user_agent,
    call = call
  )
  req <- req_modify(
    req,
    path = path,
    query = query,
    body = body,
    mime_type = mime_type,
    method = method,
    call = call
  )
  auth <- .as_nectar_auth(auth, call = call)
  req <- do_if_fn_defined(req, auth$auth_fn, !!!auth$auth_args, call = call)
  if (length(pagination_fn)) {
    req <- req_pagination_policy(req, pagination_fn, call = call)
  }
  if (length(tidy_policy)) {
    req <- req_tidy_policy(req, tidy_policy = tidy_policy, call = call)
  }
  return(.as_nectar_request(req))
}

.as_nectar_request <- function(req, ...) {
  UseMethod(".as_nectar_request")
}

#' @export
.as_nectar_request.nectar_request <- function(req, ...) {
  return(req)
}

#' @export
.as_nectar_request.httr2_request <- function(req, ...) {
  class(req) <- c("nectar_request", class(req))
  return(req)
}

#' @export
.as_nectar_request.default <- function(req, ..., call = rlang::caller_env()) {
  .nectar_abort(
    c(
      "{.arg {req}} must be a {.cls httr2_request}.",
      x = "{.arg {req}} is {.obj_type_friendly {req}}."
    ),
    subclass = "unsupported_request_class",
    call = call
  )
}
