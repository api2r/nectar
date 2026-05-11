# Define a tidy policy for a request

API responses generally follow a structured format. Use this function to
define a policy that will be used by
[`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md) to
extract the relevant portion of a response and wrangle it into a desired
format.

## Usage

``` r
req_tidy_policy(
  req,
  tidy_policy = tidy_policy_body_auto(),
  call = rlang::caller_env()
)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- tidy_policy:

  (`nectar_tidy_policy` or `NULL`) A tidying policy prepared with
  [`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md).
  By default,
  [`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md)
  is used to automatically apply
  [`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md)
  to responses.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

A [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
object with additional class `nectar_request`.

## See also

Other opinionated request functions:
[`req_auth_api_key()`](https://nectar.api2r.org/reference/req_auth_api_key.md),
[`req_init()`](https://nectar.api2r.org/reference/req_init.md),
[`req_modify()`](https://nectar.api2r.org/reference/req_modify.md),
[`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md),
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md)

Other opinionated response parsers:
[`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md),
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md),
[`resp_tidy_unknown()`](https://nectar.api2r.org/reference/resp_tidy_unknown.md),
[`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md),
[`tidy_policy_json()`](https://nectar.api2r.org/reference/tidy_policy_json.md),
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
req <- httr2::request("https://example.com")
req_tidy_policy(
  req,
  tidy_policy_json()
)
#> <nectar_request/httr2_request>
#> GET https://example.com
#> Body: empty
#> Policies:
#> * resp_tidy: <nectar_tidy_policy>
```
