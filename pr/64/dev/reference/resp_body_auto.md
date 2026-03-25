# Automatically choose a body parser

Use the `Content-Type` header (extracted using
[`httr2::resp_content_type()`](https://httr2.r-lib.org/reference/resp_content_type.html))
of a response to automatically choose and apply a body parser, such as
[`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`resp_body_csv()`](https://nectar.api2r.org/dev/reference/resp_body_csv.md).

## Usage

``` r
resp_body_auto(resp)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

## Value

The parsed response body.
