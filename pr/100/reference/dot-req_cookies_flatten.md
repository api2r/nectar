# Add non-empty cookie elements to a request

Add non-empty cookie elements to a request

## Usage

``` r
.req_cookies_flatten(req, cookie)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- cookie:

  (`list` or `NULL`) An optional list of cookies to set on the request
  using
  [`httr2::req_cookies_set()`](https://httr2.r-lib.org/reference/req_cookie_preserve.html).
  `NULL` elements are removed.

## Value

A [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
object with additional class `nectar_request`.
