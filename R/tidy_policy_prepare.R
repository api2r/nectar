#' Prepare tidying independent of a request
#'
#' This constructor stores a response tidying function and arguments so the same
#' tidying strategy can be reused across requests.
#'
#' @param tidy_fn (`function`) A function that will be invoked by [resp_tidy()]
#'   to tidy a response.
#' @param ... (`any`) Arguments to pass to `tidy_fn`.
#' @returns A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
#'   `tidy_args`.
#' @family opinionated response parsers
#' @export
#'
#' @examples
#' tidy_policy_prepare(httr2::resp_body_json, simplifyVector = TRUE)
tidy_policy_prepare <- function(tidy_fn, ...) {
  tidy_fn <- rlang::as_function(tidy_fn, call = rlang::caller_env())
  .as_nectar_tidy_policy(
    list(tidy_fn = tidy_fn, tidy_args = rlang::list2(...))
  )
}

.as_nectar_tidy_policy <- function(tidy_policy, call = rlang::caller_env()) {
  UseMethod(".as_nectar_tidy_policy")
}

#' @export
.as_nectar_tidy_policy.nectar_tidy_policy <- function(
  tidy_policy,
  call = rlang::caller_env()
) {
  return(tidy_policy)
}

#' @export
.as_nectar_tidy_policy.NULL <- function(
  tidy_policy,
  call = rlang::caller_env()
) {
  return(NULL)
}

#' @export
.as_nectar_tidy_policy.function <- function(
  tidy_policy,
  call = rlang::caller_env()
) {
  .as_nectar_tidy_policy(list(tidy_fn = tidy_policy), call = call)
}

#' @export
.as_nectar_tidy_policy.list <- function(
  tidy_policy,
  call = rlang::caller_env()
) {
  if (!("tidy_fn" %in% names(tidy_policy))) {
    return(NextMethod())
  }
  tidy_args <- stbl::to_lst(tidy_policy$tidy_args) %||% list()
  structure(
    list(
      tidy_fn = tidy_policy$tidy_fn,
      tidy_args = c(
        tidy_args,
        tidy_policy[setdiff(names(tidy_policy), c("tidy_fn", "tidy_args"))]
      )
    ),
    class = "nectar_tidy_policy"
  )
}

#' @export
.as_nectar_tidy_policy.default <- function(
  tidy_policy,
  call = rlang::caller_env()
) {
  .nectar_abort(
    c(
      "{.arg {tidy_policy}} must be `NULL` or a {.cls nectar_tidy_policy}.",
      x = "{.arg {tidy_policy}} is {.obj_type_friendly {tidy_policy}}."
    ),
    subclass = "unsupported_tidy_policy_class",
    call = call
  )
}
