# Create a nectar user agent string

Create or modify a user agent string to identify that a request used the
nectar package.

## Usage

``` r
.nectar_user_agent_append(
  existing_user_agent = NULL,
  call = rlang::caller_env()
)
```

## Arguments

- existing_user_agent:

  (`length-1 character`, optional) An existing user agent, such as the
  value of `req$options$useragent` in a
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

A string to use as a user agent, with the nectar user agent prepended
exactly once.
