# Parse one or more responses

**\[questioning\]**

If you have implemented the full `nectar` framework, use
[`resp_tidy()`](https://nectar.api2r.org/dev/reference/resp_tidy.md)
directly to parse your responses. We may continue to support
`resp_parse()`, but it is most useful as a bridge to the full framework.

`httr2` provides two methods for performing requests:
[`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html),
which returns a single
[`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
object, and
[`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html),
which returns a list of
[`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
objects. This function automatically determines whether a single
response or multiple responses have been returned, and parses the
responses appropriately.

## Usage

``` r
resp_parse(resps, ...)

# Default S3 method
resp_parse(
  resps,
  ...,
  arg = rlang::caller_arg(resps),
  call = rlang::caller_env()
)

# S3 method for class 'httr2_response'
resp_parse(resps, ..., response_parser = resp_tidy)
```

## Arguments

- resps:

  (`httr2_response`, `nectar_responses`, or `list`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html))
  or a list of such objects (as returned by
  [`req_perform_opinionated()`](https://nectar.api2r.org/dev/reference/req_perform_opinionated.md)
  or
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)).

- ...:

  Additional arguments passed on to the `response_parser` function (in
  addition to `resps`).

- arg:

  (`length-1 character`) An argument name as a string. This argument
  will be mentioned in error messages as the input that is at the origin
  of a problem.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

- response_parser:

  (`function`) A function to parse the server response (`resp`).
  Defaults to
  [`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html),
  since JSON responses are common. Set this to `NULL` to return the raw
  response from
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html).

## Value

The response parsed by the `response_parser`. If `resps` was a list, the
parsed responses are concatenated when possible. Unlike
[httr2::resps_data](https://httr2.r-lib.org/reference/resps_successes.html),
this function does not concatenate raw vector responses.
