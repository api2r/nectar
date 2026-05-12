# Prepare API key authentication independent of a request

This helper creates a reusable authentication object that can be passed
to [`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md)
via `auth`.

## Usage

``` r
auth_api_key(
  parameter_name,
  ...,
  api_key = NULL,
  location = c("header", "query", "cookie"),
  call = rlang::caller_env()
)
```

## Arguments

- parameter_name:

  (`length-1 character`) The name of the parameter to use in the header,
  query, or cookie.

- ...:

  These dots are for future extensions and must be empty.

- api_key:

  (`length-1 character` or `NULL`) The API key to use. If this value is
  `NULL`, the key will be removed from the request. If this value is
  `NA` or an empty string, the request is returned unchanged when the
  prepared auth is applied.

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

A list with class `"nectar_auth"` and elements `auth_fn` and
`auth_args`.

## See also

Other opinionated auth functions:
[`auth_prepare()`](https://nectar.api2r.org/reference/auth_prepare.md),
[`req_auth_api_key()`](https://nectar.api2r.org/reference/req_auth_api_key.md)

## Examples

``` r
auth_api_key("X-API-Key", api_key = "my-api-key")
#> $auth_fn
#> function (req, parameter_name, ..., api_key = NULL, location = c("header", 
#>     "query", "cookie"), call = rlang::caller_env()) 
#> {
#>     rlang::check_dots_empty(call = call)
#>     parameter_name <- stbl::stabilize_chr_scalar(parameter_name, 
#>         allow_na = FALSE, call = call)
#>     api_key <- stbl::to_chr_scalar(api_key, allow_null = TRUE, 
#>         call = call)
#>     if (length(api_key) && (is.na(api_key) || !nzchar(api_key))) {
#>         return(req)
#>     }
#>     location <- rlang::arg_match(location, error_call = call)
#>     req_api_key_set <- switch(location, header = httr2::req_headers_redacted, 
#>         query = httr2::req_url_query, cookie = httr2::req_cookies_set)
#>     req <- rlang::exec(req_api_key_set, req, `:=`(!!parameter_name, 
#>         api_key))
#>     return(req)
#> }
#> <bytecode: 0x5600a32acca0>
#> <environment: namespace:nectar>
#> 
#> $auth_args
#> $auth_args$parameter_name
#> [1] "X-API-Key"
#> 
#> $auth_args$api_key
#> [1] "my-api-key"
#> 
#> $auth_args$location
#> [1] "header"
#> 
#> 
#> attr(,"class")
#> [1] "nectar_auth"
```
