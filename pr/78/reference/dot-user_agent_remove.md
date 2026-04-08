# Remove package and version from user agent

Remove package and version from user agent

## Usage

``` r
.user_agent_remove(
  existing_user_agent,
  name,
  url = NULL,
  call = rlang::caller_env()
)
```

## Arguments

- existing_user_agent:

  (`length-1 character`, optional) An existing user agent, such as the
  value of `req$options$useragent` in a
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- name:

  (`length-1 character`) The name of a package or other thing to add to
  or remove from the user agent string.

- url:

  (`length-1 character`) An optional url associated with `name`.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

A modified user agent string, minus `name`, any associated version, and
the `url`.
