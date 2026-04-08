# Authenticate with an API key

Many APIs provide API keys that can be used to authenticate requests
(or, often, provide other information about the user). This function
helps to apply those keys to requests.

## Usage

``` r
req_auth_api_key(
  req,
  parameter_name,
  ...,
  api_key = NULL,
  location = c("header", "query", "cookie"),
  call = rlang::caller_env()
)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- parameter_name:

  (`length-1 character`) The name of the parameter to use in the header,
  query, or cookie.

- ...:

  These dots are for future extensions and must be empty.

- api_key:

  (`length-1 character` or `NULL`) The API key to use. If this value is
  `NULL`, `req` is returned unchanged.

- location:

  (`length-1 character`) Where the API key should be passed. One of
  `"header"` (default), `"query"`, or `"cookie"`.

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

## Examples

``` r
req <- httr2::request("https://example.com")

# Add an API key named `"X-API-Key"` as a header (default)
req_auth_api_key(req, "X-API-Key", api_key = "my-api-key")
#> <httr2_request>
#> GET https://example.com
#> Headers:
#> * X-API-Key: <REDACTED>
#> Body: empty

# Add an API key named `"api_key"` as a query parameter
req_auth_api_key(req, "api_key", api_key = "my-api-key", location = "query")
#> <httr2_request>
#> GET https://example.com/?api_key=my-api-key
#> Body: empty

# If `api_key` is NULL, the request is returned unchanged
req_auth_api_key(req, "X-API-Key", api_key = NULL)
#> <httr2_request>
#> GET https://example.com
#> Body: empty
```
