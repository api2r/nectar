# nectar

An opinionated framework for use within api-wrapping R packages.

## Installation

You can install the development version of nectar from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("api2r/nectar")
```

## Usage

nectar provides an opinionated framework for building R packages that
wrap web APIs. The three core functions compose into a natural pipeline:

1.  Prepare a request (attach auth, pagination, and tidy functions)

``` r
req <- req_prepare(
  "https://api.crossref.org/works",
  query = list(
    rows = 10, cursor = "*", select = c("publisher", "DOI"), .multi = "comma"
  ),
  tidy_policy = tidy_policy_json(subset_path = c("message", "items")),
  pagination_fn = iterate_with_json_cursor(
    param_name = "cursor",
    next_cursor_path = c("message", "next-cursor")
  )
)
```

2.  Perform the request (handles pagination and retries automatically)

``` r
resps <- req_perform_opinionated(req, max_reqs = 2)
```

3.  Parse all responses into a single tibble

``` r
result <- resp_parse(resps)
result
```

See [`vignette("nectar")`](https://nectar.api2r.org/articles/nectar.md)
for a full walk-through.

## Code of Conduct

Please note that the nectar project is released with a [Contributor Code
of Conduct](https://nectar.api2r.org/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
