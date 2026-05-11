# nectar

``` r
library(nectar)
```

nectar is a framework for building R packages that wrap web APIs. It
provides a set of opinionated functions that handle the most common
patterns in API wrappers: authentication, request preparation,
pagination, response parsing, and tidying. This vignette demonstrates
how to use nectar’s core functions together, using the [Crossref Unified
Resource API](https://api.crossref.org/swagger-ui/index.html) as a
real-world example.

## Preparing a request with `req_prepare()`

The main entry point in nectar is
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md). It
wraps
[`httr2::request()`](https://httr2.r-lib.org/reference/request.html) and
a collection of `req_*` functions into a single, composable call. You
provide the base URL and any options you need, such as authentication,
pagination, and response tidying, and
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md)
stores those settings directly on the request object so that downstream
functions can use them automatically.

Here we prepare a request to the Crossref `/works` endpoint. We ask for
ten results per page (`rows = 10`), select only the “publisher” and
“DOI” fields, tell [httr2](https://httr2.r-lib.org) to concatenate the
`select` parameter with commas (`.multi`), and set the `cursor`
parameter to `"*"` to trigger cursor-based pagination:

## Authentication with `auth_api_key()`

Many APIs accept an optional key (or, as in Crossref’s case, an email
address) to identify your application and gain access to a higher rate
limit. nectar provides
[`auth_api_key()`](https://nectar.api2r.org/reference/auth_api_key.md)
to prepare this authentication and pass it through
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md) via
the `auth` argument:

``` r
req <- req_prepare(
  "https://api.crossref.org/works",
  query = list(
    rows = 10, cursor = "*", select = c("publisher", "DOI"), .multi = "comma"
  ),
  auth = auth_api_key("mailto", api_key = "your@email.com", location = "query")
)
```

If you need to remove the key (for example, to fall back to anonymous
access), pass `api_key = NULL`:

``` r
req <- req_auth_api_key(
  req, # From above, with "your@email.com" attached as the key.
  parameter_name = "mailto",
  api_key = NULL,
  location = "query"
)
```

## Response tidying with `resp_tidy_json()`

The Crossref API returns JSON. nectar’s
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md)
function parses the JSON response body and converts the result to a
tibble using
[`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html).
You can extract a nested path from the response at the same time with
the `subset_path` argument.

For Crossref, the actual work items live at `message$items` in the
response body. To have
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md)
automatically tidy each response when you call
[`resp_parse()`](https://nectar.api2r.org/reference/resp_parse.md)
later, supply a prepared tidying policy object via the `tidy_policy`
argument, such as
`tidy_policy_json(subset_path = c("message", "items"))`:

``` r
req <- req_prepare(
  "https://api.crossref.org/works",
  query = list(
    rows = 10, cursor = "*", select = c("publisher", "DOI"), .multi = "comma"
  ),
  tidy_policy = tidy_policy_json(subset_path = c("message", "items"))
)
```

## Pagination with `iterate_with_json_cursor()`

Crossref uses cursor-based pagination: each response contains a
`message$next-cursor` field that should be sent as the `cursor` query
parameter in the next request. nectar’s
[`iterate_with_json_cursor()`](https://nectar.api2r.org/reference/iterate_with_json_cursor.md)
generates the iterator function for this pattern, given the parameter
name and the path to the cursor value in the response body:

``` r
iterate_xref <- iterate_with_json_cursor(
  param_name = "cursor",
  next_cursor_path = c("message", "next-cursor")
)
```

You can attach this iterator to the request via the `pagination_fn`
argument in
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md):

``` r
req <- req_prepare(
  "https://api.crossref.org/works",
  query = list(
    rows = 10, cursor = "*", select = c("publisher", "DOI"), .multi = "comma"
  ),
  tidy_policy = tidy_policy_json(subset_path = c("message", "items")),
  pagination_fn = iterate_xref
)
```

## Performing the request with `req_perform_opinionated()`

[`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md)
performs the request. If a pagination function is attached to the
request (as above), it automatically uses
[`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)
to fetch multiple pages; otherwise it falls back to a single
[`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)
call. It also applies a retry policy to handle transient errors.

The `max_reqs` argument controls how many pages to fetch (default: `2`).
During development, keep it small. Set it to `Inf` once you are
confident the request works:

``` r
resps <- req_perform_opinionated(req, max_reqs = 2)
```

The result is always a list of `httr2_response` objects with additional
class `nectar_responses`, so downstream handling is consistent
regardless of whether one or many pages were fetched.

## Parsing the response with `resp_parse()`

[`resp_parse()`](https://nectar.api2r.org/reference/resp_parse.md)
converts the raw responses into a usable R object. Because the request
was prepared with `tidy_policy = tidy_policy_json(...)`,
[`resp_parse()`](https://nectar.api2r.org/reference/resp_parse.md) will
find that function automatically and apply it to each response, then
combine the results:

``` r
result <- resp_parse(resps)
result
```

## Putting it all together

The three core functions compose naturally into a pipeline. Here is the
full workflow in one expression:

``` r
result <- req_prepare(
  "https://api.crossref.org/works",
  query = list(
    rows = 10, cursor = "*", select = c("publisher", "DOI"), .multi = "comma"
  ),
  tidy_policy = tidy_policy_json(subset_path = c("message", "items")),
  pagination_fn = iterate_with_json_cursor(
    param_name = "cursor",
    next_cursor_path = c("message", "next-cursor")
  )
) |>
  req_perform_opinionated(max_reqs = 3) |>
  resp_parse()

result

#> # A tibble: 30 × 2
#>    publisher                         DOI                               
#>    <chr>                             <chr>                             
#>  1 Springer Fachmedien Wiesbaden     10.1007/978-3-658-17671-6_18-1    
#>  2 Springer International Publishing 10.1007/978-3-031-23161-2_300726  
#>  3 Elsevier                          10.1016/b978-0-08-102696-0.00020-8
#>  4 Springer International Publishing 10.1007/978-3-031-28170-9_6       
#>  5 Springer Nature Singapore         10.1007/978-981-16-8679-5_306     
#>  6 Springer Singapore                10.1007/978-981-15-1636-8_42      
#>  7 Springer Berlin Heidelberg        10.1007/978-3-642-33832-8_41      
#>  8 Springer Nature Switzerland       10.1007/978-3-031-72371-1_11      
#>  9 Springer International Publishing 10.1007/978-3-319-18938-3         
#> 10 Springer International Publishing 10.1007/978-3-319-19932-0_5       
#> # i 20 more rows
#> # i Use `print(n = ...)` to see more rows
```

The resulting tibble contains the DOIs from the first two pages of
Crossref works. Once you are ready to fetch all pages, replace
`max_reqs = 2` with `max_reqs = Inf`.

## Building an API package with nectar

In practice, you would wrap these calls inside exported functions in
your own package. For example, a `crossref` package might provide:

``` r
# R/works.R  (inside a hypothetical "crossref" package)
works <- function(
  rows = 20,
  select = NULL,
  mailto = NULL
) {
  req_prepare(
    "https://api.crossref.org/works",
    query = list(rows = rows, cursor = "*", select = select),
    auth = auth_api_key("mailto", api_key = mailto, location = "query"),
    tidy_policy = tidy_policy_json(subset_path = c("message", "items")),
    pagination_fn = iterate_with_json_cursor(
      param_name = "cursor",
      next_cursor_path = c("message", "next-cursor")
    )
  ) |>
    req_perform_opinionated() |>
    resp_parse()
}
```

Users of the package never need to know about cursors, retry logic, or
JSON parsing; nectar handles it all.
