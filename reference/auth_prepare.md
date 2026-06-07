# Prepare authentication independent of a request

This constructor stores an authentication function and arguments so the
same authentication strategy can be reused across requests.

## Usage

``` r
auth_prepare(auth_fn, ..., call = rlang::caller_env())
```

## Arguments

- auth_fn:

  (`function`) A function to use to authenticate a request.

- ...:

  (`any`) Arguments to pass to `auth_fn`.

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
[`auth_api_key()`](https://nectar.api2r.org/reference/auth_api_key.md),
[`req_auth_api_key()`](https://nectar.api2r.org/reference/req_auth_api_key.md)

## Examples

``` r
auth_prepare(req_auth_api_key, "X-API-Key", api_key = "my-api-key")
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
#> <bytecode: 0x55e26e330d10>
#> <environment: namespace:nectar>
#> 
#> $auth_args
#> $auth_args[[1]]
#> [1] "X-API-Key"
#> 
#> $auth_args$api_key
#> [1] "my-api-key"
#> 
#> 
#> attr(,"class")
#> [1] "nectar_auth"
```
