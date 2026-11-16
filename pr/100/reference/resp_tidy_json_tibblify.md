# Extract and clean a JSON API response with tibblify

Parse the body of a response with
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md)
and tidy the result with
[`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html).

## Usage

``` r
resp_tidy_json_tibblify(
  resp,
  spec = NULL,
  unspecified = "list",
  subset_path = NULL
)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- spec:

  (`tspec` or `NULL`) A specification used by
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  to parse the extracted body of `resp`. When `spec` is `NULL` (the
  default),
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  will attempt to guess a spec.

- unspecified:

  (`length-1 character`) A string that describes what happens if the
  extracted body of `resp` contains fields that are not specified in
  `spec`. While
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  defaults to `NULL` for this value, we set it to `list` so that the
  body will still parse when `resp` contains extra data without throwing
  errors.

- subset_path:

  (`character`) An optional vector indicating the path to the "real"
  object within the body of `resp`. For example, many APIs return a body
  with information about the status of the response, cache information,
  perhaps pagination information, and then the actual data in a field
  such as `data`. If the desired part of the response body is in
  `data$objects`, the value of this argument should be
  `c("data", "object")`.

## Value

The tibblified response body.

## See also

Other opinionated response parsers:
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md),
[`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md),
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md),
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
resp_tidy_json_tibblify(resp)
#> # A tibble: 2 × 2
#>      id name 
#>   <int> <chr>
#> 1     1 Alice
#> 2     2 Bob  

# Extract a nested subset of the response body
resp_nested <- httr2::response_json(
  body = list(data = list(list(id = 1), list(id = 2)))
)
resp_tidy_json_tibblify(resp_nested, subset_path = "data")
#> # A tibble: 2 × 1
#>      id
#>   <int>
#> 1     1
#> 2     2
```
