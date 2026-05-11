#' Define a tidy policy for a request
#'
#' API responses generally follow a structured format. Use this function to
#' define a policy that will be used by [resp_tidy()] to extract the relevant
#' portion of a response and wrangle it into a desired format.
#'
#' @inheritParams .shared-params
#' @inherit .shared-request return
#' @family opinionated request functions
#' @export
#'
#' @examples
#' req <- httr2::request("https://example.com")
#' req_tidy_policy(
#'   req,
#'   tidy_policy_prepare(httr2::resp_body_json, simplifyVector = TRUE)
#' )
req_tidy_policy <- function(
  req,
  tidy_policy = tidy_policy_body_auto(),
  call = rlang::caller_env()
) {
  tidy_policy <- .as_nectar_tidy_policy(tidy_policy, call = call)
  .req_policy(
    req,
    resp_tidy = tidy_policy,
    call = call
  )
}
