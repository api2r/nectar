# Iteration helper for json cursors

This function is intended as a replacement for
[`httr2::iterate_with_cursor()`](https://httr2.r-lib.org/reference/iterate_with_offset.html)
for the common situation where the response body is json, and the cursor
can be "empty" in various ways. Even within a single API, some endpoints
might return a `NULL` `next_cursor` to indicate that there are no more
pages of results, while other endpoints might return `""`. This function
normalizes all such results to `NULL`.

## Usage

``` r
iterate_with_json_cursor(param_name = "cursor", next_cursor_path)
```

## Arguments

- param_name:

  (`length-1 character`) The name of the `cursor` parameter in the
  request.

- next_cursor_path:

  (`character`) A vector indicating the path to the `next_cursor`
  element in the body of the response. For example, for the [Slack
  API](https://api.slack.com/apis/pagination), this value is
  `c("response_metadata", "next_cursor")`, while for the [Crossref
  Unified Resource API](https://api.crossref.org/swagger-ui/index.html),
  this value is `"next-cursor"`.

## Value

A function that takes the response and the previous request, and returns
the next request if there are more results.
