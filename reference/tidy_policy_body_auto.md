# A policy to automatically parse a response body

Create a reusable tidy policy that applies
[`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).

## Usage

``` r
tidy_policy_body_auto()
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
[`tidy_policy_json()`](https://nectar.api2r.org/reference/tidy_policy_json.md),
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
tidy_policy_body_auto()
#> $tidy_fn
#> function (resp) 
#> {
#>     content_type <- httr2::resp_content_type(resp)
#>     switch(content_type, `application/json` = httr2::resp_body_json(resp), 
#>         `application/xml` = httr2::resp_body_xml(resp), `text/xml` = httr2::resp_body_xml(resp), 
#>         `application/xhtml+xml` = httr2::resp_body_html(resp), 
#>         `text/html` = httr2::resp_body_html(resp), `text/csv` = resp_body_csv(resp), 
#>         `text/tab-separated-values` = resp_body_tsv(resp), `image/svg+xml` = httr2::resp_body_string(resp), 
#>         .resp_body_auto_other(resp))
#> }
#> <bytecode: 0x55d53fce2fe0>
#> <environment: namespace:nectar>
#> 
#> $tidy_args
#> list()
#> 
#> attr(,"class")
#> [1] "nectar_tidy_policy"
```
