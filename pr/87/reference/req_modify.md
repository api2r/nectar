# Modify an API request for a particular endpoint

Modify the basic request for an API by adding a path and any other
path-specific properties.

## Usage

``` r
req_modify(
  req,
  ...,
  path = NULL,
  query = NULL,
  body = NULL,
  mime_type = NULL,
  method = NULL,
  call = rlang::caller_env()
)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

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
[`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md),
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md),
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md)

## Examples

``` r
req_base <- req_init("https://example.com")
req_modify(req_base, path = c("specific/{path}", path = "endpoint"))
#> <nectar_request/httr2_request>
#> GET https://example.com/specific/endpoint
#> Body: empty
#> Options:
#> * useragent: "httr2/1.2.2 r-curl/7.1.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org)"
req_modify(req_base, query = c("param1" = "value1", "param2" = "value2"))
#> <nectar_request/httr2_request>
#> GET https://example.com/?param1=value1&param2=value2
#> Body: empty
#> Options:
#> * useragent: "httr2/1.2.2 r-curl/7.1.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org)"
```
