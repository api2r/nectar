# Add non-empty header elements to a request

Add non-empty header elements to a request

## Usage

``` r
.req_headers_flatten(req, header)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- header:

  (`list` or `NULL`) An optional list of headers to add to the request
  using
  [`httr2::req_headers()`](https://httr2.r-lib.org/reference/req_headers.html).
  `NULL` elements are removed.

## Value

A [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
object with additional class `nectar_request`.
