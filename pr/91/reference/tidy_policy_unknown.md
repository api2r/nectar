# A policy to error for unknown response bodies

Create a reusable tidy policy that applies
[`resp_tidy_unknown()`](https://nectar.api2r.org/reference/resp_tidy_unknown.md),
signaling an informative error.

## Usage

``` r
tidy_policy_unknown()
```

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
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md)

## Examples

``` r
tidy_policy_unknown()
#> $tidy_fn
#> function (resp, call = rlang::caller_env()) 
#> {
#>     results <- resp_body_auto(resp)
#>     .nectar_abort(c("No parser is defined for this response.", 
#>         i = "Response pieces: {names(results)}"), subclass = "unknown_response_type", 
#>         call = call)
#> }
#> <bytecode: 0x55b972cdbab0>
#> <environment: namespace:nectar>
#> 
#> $tidy_args
#> list()
#> 
#> attr(,"class")
#> [1] "nectar_tidy_policy"
```
