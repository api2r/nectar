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
  tidy_fn = resp_body_auto,
  tidy_args = list(),
  call = rlang::caller_env()
)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- tidy_fn:

  (`function`) A function that will be invoked by
  [`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md) to
  tidy the response.

- tidy_args:

  (`list`) A list of additional arguments to pass to `tidy_fn`.

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
[`req_init()`](https://nectar.api2r.org/reference/req_init.md),
[`req_modify()`](https://nectar.api2r.org/reference/req_modify.md),
[`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md),
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md)

## Examples

``` r
req <- httr2::request("https://example.com")
req_tidy_policy(req, httr2::resp_body_json, list(simplifyVector = TRUE))
#> <nectar_request/httr2_request>
#> GET https://example.com
#> Body: empty
#> Policies:
#> * resp_tidy: <list>
```
