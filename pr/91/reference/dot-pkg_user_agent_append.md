# Append package user agent

Append package user agent

## Usage

``` r
.pkg_user_agent_append(
  existing_user_agent = NULL,
  pkg_name = get_pkg_name(call),
  pkg_url = NULL,
  call = rlang::caller_env()
)
```

## Arguments

- existing_user_agent:

  (`length-1 character`, optional) An existing user agent, such as the
  value of `req$options$useragent` in a
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- pkg_name:

  (`length-1 character`) The name of the calling package. This will
  usually be automatically determined based on the source of the call.

- pkg_url:

  (`length-1 character`) A url for information about the calling package
  (default `NULL`).

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

A string to use as a user agent. Attach the agent to your request with
[`httr2::req_user_agent()`](https://httr2.r-lib.org/reference/req_user_agent.html).
