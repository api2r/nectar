#' Raise a package-scoped error
#'
#' @inheritParams .shared-params
#' @inheritParams stbl::pkg_abort
#' @returns An error condition with classes `"nectar-condition"`,
#'   `"nectar-error"`, and `"nectar-error-{subclass}"`.
#' @keywords internal
.nectar_abort <- function(
  message,
  subclass,
  call = caller_env(),
  message_env = caller_env(),
  ...
) {
  stbl::pkg_abort(
    "nectar",
    message,
    subclass,
    call = call,
    message_env = message_env,
    ...
  )
}
