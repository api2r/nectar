# Extract tabular data from response body

Extract tabular data in comma-separated or tab-separated format from a
response body.

## Usage

``` r
resp_body_csv(resp, check_type = TRUE)

resp_body_tsv(resp, check_type = TRUE)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- check_type:

  (`length-1 logical`) Whether to check that the response has the
  expected content type. Set to `FALSE` if the response is not
  specifically tagged as the proper type.

## Value

The parsed response body as a data frame.

## Examples

``` r
resp_csv <- httr2::response(
  headers = list("Content-Type" = "text/csv"),
  body = charToRaw("a,b\n1,2\n3,4")
)
resp_body_csv(resp_csv)
#>   a b
#> 1 1 2
#> 2 3 4
resp_tsv <- httr2::response(
  headers = list("Content-Type" = "text/tab-separated-values"),
  body = charToRaw("a\tb\n1\t2\n3\t4")
)
resp_body_tsv(resp_tsv)
#>   a b
#> 1 1 2
#> 2 3 4
```
