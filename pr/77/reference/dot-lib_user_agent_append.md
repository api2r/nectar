# Add a library and version to a user agent

Add a library and version to a user agent

## Usage

``` r
.lib_user_agent_append(
  existing_user_agent,
  name,
  version,
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

- version:

  (`length-1 character`) The version of `name`.

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

A modified user agent string for the library.
