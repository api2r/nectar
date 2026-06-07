# Extract and optionally subset a JSON API response

Parse the body of a response with
[`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
and optionally extract a named subset of that body.

## Usage

``` r
resp_tidy_json(resp, subset_path = NULL, simplifyVector = FALSE)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- subset_path:

  (`character`) An optional vector indicating the path to the "real"
  object within the body of `resp`. For example, many APIs return a body
  with information about the status of the response, cache information,
  perhaps pagination information, and then the actual data in a field
  such as `data`. If the desired part of the response body is in
  `data$objects`, the value of this argument should be
  `c("data", "object")`.

- simplifyVector:

  Should JSON arrays containing only primitives (i.e. booleans, numbers,
  and strings) be caused to atomic vectors?

## Value

The parsed response body, or `NULL` for an empty result.

## See also

Other opinionated response parsers:
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md),
[`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md),
[`resp_tidy_json_tibblify()`](https://nectar.api2r.org/reference/resp_tidy_json_tibblify.md),
[`resp_tidy_unknown()`](https://nectar.api2r.org/reference/resp_tidy_unknown.md),
[`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md),
[`tidy_policy_json()`](https://nectar.api2r.org/reference/tidy_policy_json.md),
[`tidy_policy_json_tibblify()`](https://nectar.api2r.org/reference/tidy_policy_json_tibblify.md),
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
resp <- httr2::response_json(
  body = list(list(id = 1, name = "Alice"), list(id = 2, name = "Bob"))
)
resp_tidy_json(resp)
#> [[1]]
#> [[1]]$id
#> [1] 1
#> 
#> [[1]]$name
#> [1] "Alice"
#> 
#> 
#> [[2]]
#> [[2]]$id
#> [1] 2
#> 
#> [[2]]$name
#> [1] "Bob"
#> 
#> 

# Extract a nested subset of the response body
resp_nested <- httr2::response_json(
  body = list(data = list(list(id = 1), list(id = 2)))
)
resp_tidy_json(resp_nested, subset_path = "data")
#> [[1]]
#> [[1]]$id
#> [1] 1
#> 
#> 
#> [[2]]
#> [[2]]$id
#> [1] 2
#> 
#> 
```
