# Send a request to an API

**\[questioning\]**

This function implements an opinionated framework for making API calls.
It is intended to be used inside an API client package. It serves as a
wrapper around the `req_` family of functions, such as
[`httr2::request()`](https://httr2.r-lib.org/reference/request.html), as
well as
[`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)
and
[`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html),
and, by default,
[`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html).

## Usage

``` r
call_api(
  base_url,
  ...,
  path = NULL,
  query = NULL,
  body = NULL,
  mime_type = NULL,
  method = NULL,
  auth_fn = NULL,
  auth_args = list(),
  response_parser = resp_tidy,
  response_parser_args = list(),
  next_req_fn = NULL,
  max_reqs = Inf,
  max_tries_per_req = 3,
  additional_user_agent = NULL
)
```

## Arguments

- base_url:

  (`length-1 character`) The part of the url that is shared by all calls
  to the API. In some cases there may be a family of base URLs, from
  which you will need to choose one.

- ...:

  These dots are for future extensions and must be empty.

- path:

  (`character` or `list`) The route to an API endpoint. Optionally, a
  list or character vector with the path as one or more unnamed
  arguments (which will be concatenated with "/") plus named arguments
  to [`glue::glue()`](https://glue.tidyverse.org/reference/glue.html)
  into the path.

- query:

  (`character` or `list`) An optional list or character vector of
  parameters to pass in the query portion of the request. Can also
  include a `.multi` argument to pass to
  [`httr2::req_url_query()`](https://httr2.r-lib.org/reference/req_url.html)
  to control how elements containing multiple values are handled.

- body:

  (multiple types) An object to use as the body of the request. If any
  component of the body is a path, pass it through
  [`fs::path()`](https://fs.r-lib.org/reference/path.html) or otherwise
  give it the class "fs_path" to indicate that it is a path.

- mime_type:

  (`length-1 character`) The mime type of any files present in the body.
  Some APIs allow you to leave this as NULL for them to guess.

- method:

  (`length-1 character`, optional) If the method is something other than
  `GET` or `POST`, supply it. Case is ignored.

- auth_fn:

  (`function`) A function to use to authenticate the request. By default
  (`NULL`), no authentication is performed.

- auth_args:

  (`list`) An optional list of arguments to the `auth_fn` function.

- response_parser:

  (`function`) A function to parse the server response (`resp`).
  Defaults to
  [`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html),
  since JSON responses are common. Set this to `NULL` to return the raw
  response from
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html).

- response_parser_args:

  (`list`) Additional arguments to pass to the `response_parser`.

- next_req_fn:

  (`function`) An optional function that takes the previous response
  (`resp`) and request (`req`), and returns a new request. This function
  is passed as `next_req` in a call to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).
  This function can usually be generated using one of the iteration
  helpers described in
  [`httr2::iterate_with_offset()`](https://httr2.r-lib.org/reference/iterate_with_offset.html).
  By default,
  [`choose_pagination_fn()`](https://nectar.api2r.org/reference/choose_pagination_fn.md)
  is used to check for a pagination policy (see
  [`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md)),
  and returns `NULL` if no such policy is defined.

- max_reqs:

  (`length-1 integer`) The maximum number of separate requests to
  perform. Passed to the max_reqs argument of
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)
  when `next_req` is supplied. You will mostly likely want to change the
  default value (`2`) to `Inf` after you validate that the request
  works.

- max_tries_per_req:

  (`length-1 integer`) The maximum number of times to attempt each
  individual request. Passed to the `max_tries` argument of
  [`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html).

- additional_user_agent:

  (`length-1 character`) A string to identify where a request is coming
  from. We automatically include information about your package and
  nectar, but use this to provide additional details. Default `NULL`.

## Value

The response from the API, parsed by the `response_parser`.

## See also

[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md),
[`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md),
and [`resp_parse()`](https://nectar.api2r.org/reference/resp_parse.md)
for finer control of the process.
