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

## Examples

``` r
# Create a cursor iterator for the Slack API response structure
iterate_with_json_cursor("cursor", c("response_metadata", "next_cursor"))
#> function (resp, req) 
#> {
#>     value <- resp_param_value(resp)
#>     if (!is.null(value)) {
#>         req_url_query(req, `:=`(!!param_name, value))
#>     }
#> }
#> <bytecode: 0x5607535727e0>
#> <environment: 0x56075356fc10>

# Create a cursor iterator for the Crossref API
iterate_xref <- iterate_with_json_cursor("cursor", c("message", "next-cursor"))

if (FALSE) { # \dontrun{
# Use the iterator to paginate through Crossref API results. The cursor must
# be set to "*" for the initial request to trigger the api to return the next
# cursor.
req <- httr2::request("https://api.crossref.org/works") |>
  httr2::req_url_query(rows = 5, cursor = "*", select = "DOI")

resps <- req_perform_opinionated(
  req, next_req_fn = iterate_xref, max_reqs = 2
)
resps
} # }
```
