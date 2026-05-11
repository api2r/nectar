# Prepare tidying independent of a request

This constructor stores a response tidying function and arguments so the
same tidying strategy can be reused across requests.

## Usage

``` r
tidy_policy_prepare(tidy_fn, ...)
```

## Arguments

- tidy_fn:

  (`function`) A function that will be invoked by
  [`resp_tidy()`](https://nectar.api2r.org/reference/resp_tidy.md) to
  tidy a response.

- ...:

  (`any`) Arguments to pass to `tidy_fn`.

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
[`tidy_policy_json()`](https://nectar.api2r.org/reference/tidy_policy_json.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
tidy_policy_prepare(httr2::resp_body_json, simplifyVector = TRUE)
#> $tidy_fn
#> function (resp, check_type = TRUE, simplifyVector = FALSE, ...) 
#> {
#>     check_response(resp)
#>     check_installed("jsonlite")
#>     key <- body_cache_key("json", simplifyVector = simplifyVector, 
#>         ...)
#>     if (env_has(resp$cache, key)) {
#>         return(resp$cache[[key]])
#>     }
#>     resp_check_content_type(resp, valid_types = "application/json", 
#>         valid_suffix = "json", check_type = check_type)
#>     text <- resp_body_string(resp, "UTF-8")
#>     resp$cache[[key]] <- jsonlite::fromJSON(text, simplifyVector = simplifyVector, 
#>         ...)
#>     resp$cache[[key]]
#> }
#> <bytecode: 0x558c559840b0>
#> <environment: namespace:httr2>
#> 
#> $tidy_args
#> $tidy_args$simplifyVector
#> [1] TRUE
#> 
#> 
#> attr(,"class")
#> [1] "nectar_tidy_policy"
```
