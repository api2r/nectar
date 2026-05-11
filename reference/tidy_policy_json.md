# A policy to parse a response body as JSON

Create a reusable tidy policy that applies
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md).

## Usage

``` r
tidy_policy_json(spec = NULL, unspecified = "list", subset_path = NULL)
```

## Arguments

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

A list with class `"nectar_tidy_policy"` and elements `tidy_fn` and
`tidy_args`.

## See also

Other opinionated response parsers:
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md),
[`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md),
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md),
[`resp_tidy_unknown()`](https://nectar.api2r.org/reference/resp_tidy_unknown.md),
[`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md),
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
tidy_policy_json(subset_path = "data")
#> $tidy_fn
#> function (resp, spec = NULL, unspecified = "list", subset_path = NULL) 
#> {
#>     rlang::check_installed("tibblify", "to tidy the JSON response body.")
#>     subset_path <- stbl::to_chr(subset_path)
#>     result <- httr2::resp_body_json(resp)
#>     result <- purrr::pluck(result, !!!subset_path)
#>     if (length(result)) {
#>         return(tibblify::tibblify(result, spec = spec, unspecified = unspecified))
#>     }
#>     return(NULL)
#> }
#> <bytecode: 0x55919d510990>
#> <environment: namespace:nectar>
#> 
#> $tidy_args
#> $tidy_args$spec
#> NULL
#> 
#> $tidy_args$unspecified
#> [1] "list"
#> 
#> $tidy_args$subset_path
#> [1] "data"
#> 
#> 
#> attr(,"class")
#> [1] "nectar_tidy_policy"
```
