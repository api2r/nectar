# Parameters used in multiple functions

Reused parameter definitions are gathered here for easier editing.

## Arguments

- additional_user_agent:

  (`length-1 character`) A string to identify where a request is coming
  from. We automatically include information about your package and
  nectar, but use this to provide additional details. Default `NULL`.

- api_key:

  (`length-1 character` or `NULL`) The API key to use. If this value is
  `NULL`, the key will be removed from the request. If this value is
  `NA` or an empty string, the request is returned unchanged when the
  prepared auth is applied.

- arg:

  (`length-1 character`) An argument name as a string. This argument
  will be mentioned in error messages as the input that is at the origin
  of a problem.

- auth:

  (`nectar_auth` or `NULL`) Authentication prepared with
  [`auth_prepare()`](https://nectar.api2r.org/reference/auth_prepare.md).
  By default (`NULL`), no authentication is performed.

- base_url:

  (`length-1 character`) The part of the url that is shared by all calls
  to the API. In some cases there may be a family of base URLs, from
  which you will need to choose one.

- body:

  (multiple types) An object to use as the body of the request. If any
  component of the body is a path, pass it through
  [`fs::path()`](https://fs.r-lib.org/reference/path.html) or otherwise
  give it the class "fs_path" to indicate that it is a path.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

- check_type:

  (`length-1 logical`) Whether to check that the response has the
  expected content type. Set to `FALSE` if the response is not
  specifically tagged as the proper type.

- existing_user_agent:

  (`length-1 character`, optional) An existing user agent, such as the
  value of `req$options$useragent` in a
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- method:

  (`length-1 character`, optional) If the method is something other than
  `GET` or `POST`, supply it. Case is ignored.

- mime_type:

  (`length-1 character`) The mime type of any files present in the body.
  Some APIs allow you to leave this as NULL for them to guess.

- location:

  (`length-1 character`) Where the API key should be passed. One of
  `"header"` (default), `"query"`, or `"cookie"`.

- name:

  (`length-1 character`) The name of a package or other thing to add to
  or remove from the user agent string.

- pagination_fn:

  (`function`) A function that takes the previous response (`resp`) to
  generate the next request in a call to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).
  This function can usually be generated using one of the iteration
  helpers described in
  [`httr2::iterate_with_offset()`](https://httr2.r-lib.org/reference/iterate_with_offset.html).
  This function will be extracted from the request by
  [`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md)
  and passed on as `next_req` to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).

- parameter_name:

  (`length-1 character`) The name of the parameter to use in the header,
  query, or cookie.

- path:

  (`character` or `list`) The route to an API endpoint. Optionally, a
  list or character vector with the path as one or more unnamed
  arguments (which will be concatenated with "/") plus named arguments
  to [`glue::glue()`](https://glue.tidyverse.org/reference/glue.html)
  into the path.

- pkg_name:

  (`length-1 character`) The name of the calling package. This will
  usually be automatically determined based on the source of the call.

- pkg_url:

  (`length-1 character`) A url for information about the calling package
  (default `NULL`).

- query:

  (`character` or `list`) An optional list or character vector of
  parameters to pass in the query portion of the request. Can also
  include a `.multi` argument to pass to
  [`httr2::req_url_query()`](https://httr2.r-lib.org/reference/req_url.html)
  to control how elements containing multiple values are handled.

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- resps:

  (`httr2_response`, `nectar_responses`, or `list`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html))
  or a list of such objects (as returned by
  [`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md)
  or
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)).

- resp_body_fn:

  (`function`) A function to extract the body of the response. Default:
  [`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).

- response_parser:

  (`function`) A function to parse the server response (`resp`).
  Defaults to
  [`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html),
  since JSON responses are common. Set this to `NULL` to return the raw
  response from
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html).

- response_parser_args:

  (`list`) An optional list of arguments to pass to the
  `response_parser` function (in addition to `resp`).

- tidy_policy:

  (`nectar_tidy_policy` or `NULL`) A tidying policy prepared with
  [`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md).
  By default (`NULL`), no tidying policy is added to the request.

- spec:

  (`tspec` or `NULL`) A specification used by
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  to parse the extracted body of `resp`. When `spec` is `NULL` (the
  default),
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  will attempt to guess a spec.

- unspecified:

  (`length-1 character`) A string that describes what happens if the
  extracted body of `resp` contains fields that are not specified in
  `spec`. While
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  defaults to `NULL` for this value, we set it to `list` so that the
  body will still parse when `resp` contains extra data without throwing
  errors.

- subset_path:

  (`character`) An optional vector indicating the path to the "real"
  object within the body of `resp`. For example, many APIs return a body
  with information about the status of the response, cache information,
  perhaps pagination information, and then the actual data in a field
  such as `data`. If the desired part of the response body is in
  `data$objects`, the value of this argument should be
  `c("data", "object")`.

- url:

  (`length-1 character`) An optional url associated with `name`.

- version:

  (`length-1 character`) The version of `name`.

- x:

  (multiple types) The object to update.

- ...:

  These dots are for future extensions and must be empty.
