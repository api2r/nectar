# Apply policies to a request

This function is based on the unexported `req_policies()` function from
httr2. It is used to apply policies to a request object. I don't
currently export this function, but that may change in the future.

## Usage

``` r
.req_policy(req, ..., call = rlang::caller_env())
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- ...:

  These dots are for future extensions and must be empty.

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
