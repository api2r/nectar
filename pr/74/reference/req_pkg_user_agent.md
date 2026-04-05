# Append package information to user agent

Add information about nectar and the calling package (if called from a
package) to the user agent string.

## Usage

``` r
req_pkg_user_agent(
  req,
  pkg_name = get_pkg_name(call),
  pkg_url = NULL,
  call = rlang::caller_env()
)
```

## Arguments

- req:

  (`httr2_request`) A
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

A [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
object with additional class `nectar_request`.

## Examples

``` r
req <- httr2::request("https://example.com")
req$options$useragent
#> NULL
req_pkg_user_agent(req)$options$useragent
#> httr2/1.2.2 r-curl/7.0.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org)
req_pkg_user_agent(req, "stbl")$options$useragent
#> httr2/1.2.2 r-curl/7.0.0 libcurl/8.5.0 nectar/0.0.0.9007 (https://nectar.api2r.org) stbl/0.3.0
```
