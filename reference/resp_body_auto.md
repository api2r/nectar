# Automatically choose a body parser

Use the `Content-Type` header (extracted using
[`httr2::resp_content_type()`](https://httr2.r-lib.org/reference/resp_content_type.html))
of a response to automatically choose and apply a body parser, such as
[`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
or
[`resp_body_csv()`](https://nectar.api2r.org/reference/resp_body_csv.md).

## Usage

``` r
resp_body_auto(resp)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

## Value

The parsed response body.

## Examples

``` r
resp_json <- httr2::response_json(body = list(a = 1, b = "hello"))
resp_body_auto(resp_json)
#> $a
#> [1] 1
#> 
#> $b
#> [1] "hello"
#> 

resp_csv <- httr2::response(
  headers = list("Content-Type" = "text/csv"),
  body = charToRaw("a,b\n1,2\n3,4")
)
resp_body_auto(resp_csv)
#>   a b
#> 1 1 2
#> 2 3 4
```
