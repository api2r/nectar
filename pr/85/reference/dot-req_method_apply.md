# Add a method if it is supplied

[`httr2::req_method()`](https://httr2.r-lib.org/reference/req_method.html)
errors if `method` is `NULL`, rather than using the default rules. This
function deals with that.

## Usage

``` r
.req_method_apply(req, method, call = rlang::caller_env())
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- method:

  (`length-1 character`, optional) If the method is something other than
  `GET` or `POST`, supply it. Case is ignored.

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
