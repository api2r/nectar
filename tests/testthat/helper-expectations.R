expect_nectar_error_snapshot <- function(
  ...,
  call = rlang::caller_env()
) {
  stbl::expect_pkg_error_snapshot(
    package = "nectar",
    env = call,
    ...
  )
}
