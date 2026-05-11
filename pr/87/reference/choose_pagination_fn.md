# Extract a pagination policy from a request

If a request has a pagination policy defined by
[`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md),
extract the `pagination_fn` from that policy. Otherwise return `NULL`.

## Usage

``` r
choose_pagination_fn(req)
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

## Value

The pagination function, or `NULL`.

## Examples

``` r
req <- httr2::request("https://example.com")
req <- req_pagination_policy(req, httr2::iterate_with_offset("page"))
choose_pagination_fn(req)
#> function (resp, req) 
#> {
#>     if (!is.null(resp_pages) && !known_total) {
#>         n <- resp_pages(resp)
#>         if (!is.null(n)) {
#>             known_total <<- TRUE
#>             signal_total_pages(n)
#>         }
#>     }
#>     if (!isTRUE(resp_complete(resp))) {
#>         i <<- i + offset
#>         req_url_query(req, `:=`(!!param_name, i))
#>     }
#> }
#> <bytecode: 0x559ac3efd0b0>
#> <environment: 0x559ac3ef5888>
```
