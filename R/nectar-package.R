#' @keywords internal
"_PACKAGE"

# All of these really need to be imported, either so the package is a hard
# dependency for underlying usage, or to make mocking easier in tests.

## usethis namespace: start
#' @importFrom fs path
#' @importFrom httr2 req_perform
#' @importFrom httr2 req_perform_iterative
#' @importFrom lifecycle deprecated
#' @importFrom rlang %||%
#' @importFrom rlang :=
#' @importFrom rlang caller_env
## usethis namespace: end
NULL
