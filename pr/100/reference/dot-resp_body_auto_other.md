# Automatically choose more body parsers

This helper function exists to find somewhat variable content types and
attempt to send them to the proper body parser.

## Usage

``` r
.resp_body_auto_other(resp)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

## Value

The parsed response body.
