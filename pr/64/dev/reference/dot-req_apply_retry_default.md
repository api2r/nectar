# Add a retry policy if none is defined

Add a retry policy if none is defined

## Usage

``` r
.req_apply_retry_default(req, max_tries_per_req)
```

## Arguments

- req:

  The first [request](https://httr2.r-lib.org/reference/request.html) to
  perform.

- max_tries_per_req:

  (`length-1 integer`) The maximum number of times to attempt each
  individual request. Passed to the `max_tries` argument of
  [`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html).

## Value

A list of
[`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
objects, one for each request performed. The list has additional class
`nectar_responses`.
