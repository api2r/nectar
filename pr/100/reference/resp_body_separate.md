# Extract response body into list

Wrap the parsed response body in a
[`list()`](https://rdrr.io/r/base/list.html). Unlike
[`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md),
this function prevents individual response bodies from being
concatenated when combining multiple responses, which is useful for raw
or otherwise non-concatenatable types.

## Usage

``` r
resp_body_separate(resp, resp_body_fn = resp_body_auto)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- resp_body_fn:

  (`function`) A function to extract the body of the response. Default:
  [`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).

## Value

The parsed response body wrapped in a
[`list()`](https://rdrr.io/r/base/list.html). This is useful for things
like raw vectors that you wish to parse with
[`httr2::resps_data()`](https://httr2.r-lib.org/reference/resps_successes.html).

## Examples

``` r
resp <- httr2::response_json(body = list(a = 1, b = "hello"))
resp_body_separate(resp)
#> [[1]]
#> [[1]]$a
#> [1] 1
#> 
#> [[1]]$b
#> [1] "hello"
#> 
#> 
```
