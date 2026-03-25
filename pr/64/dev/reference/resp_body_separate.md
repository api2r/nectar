# Extract response body into list

Extract response body into list

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
  [`resp_body_auto()`](https://nectar.api2r.org/dev/reference/resp_body_auto.md).

## Value

The parsed response body wrapped in a
[`list()`](https://rdrr.io/r/base/list.html). This is useful for things
like raw vectors that you wish to parse with
[`httr2::resps_data()`](https://httr2.r-lib.org/reference/resps_successes.html).
