# Error informatively for unknown response types

If you have not defined a parser for a response type, use this function
to return useful information to help construct a parser.

## Usage

``` r
resp_tidy_unknown(resp, call = rlang::caller_env())
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

This function always throws an error. The error lists the names of the
response pieces after parsing with
[`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).
