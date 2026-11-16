# Add non-empty query elements to a request

Add non-empty query elements to a request

## Usage

``` r
.req_query_flatten(req, query)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- query:

  (`character` or `list`) An optional list or character vector of
  parameters to pass in the query portion of the request. Can also
  include a `.multi` argument to pass to
  [`httr2::req_url_query()`](https://httr2.r-lib.org/reference/req_url.html)
  to control how elements containing multiple values are handled.

## Value

A [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
object with additional class `nectar_request`.
