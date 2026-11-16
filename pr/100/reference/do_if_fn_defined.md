# Use a provided function

When constructing API calls programmatically, you may encounter
situations where an upstream task should indicate which function to
apply. For example, one endpoint might use a special auth function that
isn't used by other endpoints. This function exists to make coding such
situations easier.

## Usage

``` r
do_if_fn_defined(x, fn = NULL, ..., call = rlang::caller_env())
```

## Arguments

- x:

  An object to potentially modify, such as a
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- fn:

  A function to apply to `x`. If `fn` is `NULL`, `x` is returned
  unchanged.

- ...:

  Additional arguments to pass to `fn`.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

The object, potentially modified.

## Examples

``` r
build_api_req <- function(endpoint, auth_fn = NULL, ...) {
  req <- httr2::request("https://example.com")
  req <- httr2::req_url_path_append(req, endpoint)
  do_if_fn_defined(req, auth_fn, ...)
}

# Most endpoints of this API do not require authentication.
unsecure_req <- build_api_req("unsecure_endpoint")
unsecure_req$headers
#> list()

# But one endpoint requires authentication.
secure_req <- build_api_req(
  "secure_endpoint", httr2::req_auth_bearer_token, "secret-token"
)
secure_req$headers$Authorization
#> <weak reference>
```
