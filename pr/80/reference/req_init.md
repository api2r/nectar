# Setup a basic API request

For a given API, the `base_url` and user agent will generally be the
same for every call to that API. Use this function to prepare that piece
of the request once for easy reuse.

## Usage

``` r
req_init(
  base_url,
  ...,
  additional_user_agent = NULL,
  call = rlang::caller_env()
)
```

## Arguments

- base_url:

  (`length-1 character`) The part of the url that is shared by all calls
  to the API. In some cases there may be a family of base URLs, from
  which you will need to choose one.

- ...:

  These dots are for future extensions and must be empty.

- additional_user_agent:

  (`length-1 character`) A string to identify where a request is coming
  from. We automatically include information about your package and
  nectar, but use this to provide additional details. Default `NULL`.

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
[`req_modify()`](https://nectar.api2r.org/reference/req_modify.md),
[`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md),
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md),
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md)

## Examples

``` r
req_init("https://example.com")
#> <nectar_request/httr2_request>
#> GET https://example.com
#> Body: empty
#> Options:
#> * useragent: "httr2/1.2.2 r-curl/7.1.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org)"
req_init(
  "https://example.com",
  additional_user_agent = "my_api_client (https://my.api.client)"
)
#> <nectar_request/httr2_request>
#> GET https://example.com
#> Body: empty
#> Options:
#> * useragent: "my_api_client (https://my.api.client) nectar/0.0.0.9007 (https://nectar.api2r.org)"
```
