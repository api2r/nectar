# Cursor finder factory

Cursor finder factory

## Usage

``` r
.next_cursor_finder(next_cursor_path, resp_body_fn = resp_body_auto)
```

## Arguments

- next_cursor_path:

  (`character`) A vector indicating the path to the `next_cursor`
  element in the body of the response. For example, for the [Slack
  API](https://api.slack.com/apis/pagination), this value is
  `c("response_metadata", "next_cursor")`, while for the [Crossref
  Unified Resource API](https://api.crossref.org/swagger-ui/index.html),
  this value is `"next-cursor"`.

- resp_body_fn:

  (`function`) A function to extract the body of the response. Default:
  [`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).

## Value

A function that returns the next cursor, or `NULL` if the next cursor is
`NULL` (or otherwise length-0) or `""`.
