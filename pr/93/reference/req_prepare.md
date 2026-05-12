# Prepare a request for an API

This function implements an opinionated framework for preparing an API
request. It is intended to be used inside an API client package. It
serves as a wrapper around the `req_` family of functions, such as
[`httr2::request()`](https://httr2.r-lib.org/reference/request.html).

## Usage

``` r
req_prepare(
  base_url,
  ...,
  path = NULL,
  query = NULL,
  body = NULL,
  mime_type = NULL,
  method = NULL,
  header = NULL,
  cookie = NULL,
  additional_user_agent = NULL,
  auth = NULL,
  tidy_policy = tidy_policy_body_auto(),
  pagination_fn = NULL,
  call = rlang::caller_env()
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

- header:

  (`list` or `NULL`) An optional list of headers to add to the request
  using
  [`httr2::req_headers()`](https://httr2.r-lib.org/reference/req_headers.html).
  `NULL` elements are removed.

- cookie:

  (`list` or `NULL`) An optional list of cookies to set on the request
  using
  [`httr2::req_cookies_set()`](https://httr2.r-lib.org/reference/req_cookie_preserve.html).
  `NULL` elements are removed.

- additional_user_agent:

  (`length-1 character`) A string to identify where a request is coming
  from. We automatically include information about your package and
  nectar, but use this to provide additional details. Default `NULL`.

- auth:

  (`nectar_auth` or `NULL`) Authentication prepared with
  [`auth_prepare()`](https://nectar.api2r.org/reference/auth_prepare.md).
  By default (`NULL`), no authentication is performed.

- tidy_policy:

  (`nectar_tidy_policy` or `NULL`) A tidying policy prepared with
  [`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md).
  By default,
  [`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md)
  is used to automatically apply
  [`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md)
  to responses.

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

## See also

Other opinionated request functions:
[`req_auth_api_key()`](https://nectar.api2r.org/reference/req_auth_api_key.md),
[`req_init()`](https://nectar.api2r.org/reference/req_init.md),
[`req_modify()`](https://nectar.api2r.org/reference/req_modify.md),
[`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md),
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md)

## Examples

``` r
req_prepare("https://example.com")
#> <nectar_request/httr2_request>
#> GET https://example.com/
#> Body: empty
#> Options:
#> * useragent: "httr2/1.2.2 r-curl/7.1.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org)"
#> Policies:
#> * resp_tidy: <nectar_tidy_policy>
req_prepare(
  "https://example.com",
  path = c("users/{user_id}", user_id = "42"),
  query = list(format = "json")
)
#> <nectar_request/httr2_request>
#> GET https://example.com/users/42?format=json
#> Body: empty
#> Options:
#> * useragent: "httr2/1.2.2 r-curl/7.1.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org)"
#> Policies:
#> * resp_tidy: <nectar_tidy_policy>
```
