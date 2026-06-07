# A policy to parse a response body as JSON

Create a reusable tidy policy that applies
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md).

## Usage

``` r
tidy_policy_json(subset_path = NULL, simplifyVector = FALSE)
```

## Arguments

- subset_path:

  (`character`) An optional vector indicating the path to the "real"
  object within the body of `resp`. For example, many APIs return a body
  with information about the status of the response, cache information,
  perhaps pagination information, and then the actual data in a field
  such as `data`. If the desired part of the response body is in
  `data$objects`, the value of this argument should be
  `c("data", "object")`.

- simplifyVector:

  (`length-1 logical`) Should JSON arrays containing only primitives and
  records be simplified to atomic vectors and data frames?

## Value

A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
`tidy_args`.

## See also

Other opinionated response parsers:
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md),
[`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md),
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md),
[`resp_tidy_json_tibblify()`](https://nectar.api2r.org/reference/resp_tidy_json_tibblify.md),
[`resp_tidy_unknown()`](https://nectar.api2r.org/reference/resp_tidy_unknown.md),
[`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md),
[`tidy_policy_json_tibblify()`](https://nectar.api2r.org/reference/tidy_policy_json_tibblify.md),
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
tidy_policy_json(subset_path = "data")
#> $tidy_fn
#> function (resp, subset_path = NULL, simplifyVector = FALSE) 
#> {
#>     subset_path <- stbl::to_chr(subset_path)
#>     result <- httr2::resp_body_json(resp, simplifyVector = simplifyVector)
#>     result <- purrr::pluck(result, !!!subset_path)
#>     if (length(result)) {
#>         return(result)
#>     }
#>     return(NULL)
#> }
#> <bytecode: 0x5603c344c6b8>
#> <environment: namespace:nectar>
#> 
#> $tidy_args
#> $tidy_args$subset_path
#> [1] "data"
#> 
#> $tidy_args$simplifyVector
#> [1] FALSE
#> 
#> 
#> attr(,"class")
#> [1] "nectar_tidy_policy"
```
