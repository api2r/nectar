# Define a pagination policy for a request

APIs generally have a specified method for requesting multiple pages of
results (or sometimes two or three methods). The methods are sometimes
documented within a given endpoint, and sometimes documented at the
"top" of the documentation. Use this function to attach a pagination
policy to a request, so that
[`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md)
can automatically handle pagination.

## Usage

``` r
req_pagination_policy(req, pagination_fn, call = rlang::caller_env())
```

## Arguments

- req:

  (`httr2_request`) A
  [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
  object.

- pagination_fn:

  (`function`) A function that takes the previous response (`resp`) to
  generate the next request in a call to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).
  This function can usually be generated using one of the iteration
  helpers described in
  [`httr2::iterate_with_offset()`](https://httr2.r-lib.org/reference/iterate_with_offset.html).
  This function will be extracted from the request by
  [`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md)
  and passed on as `next_req` to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

A [`httr2::request()`](https://httr2.r-lib.org/reference/request.html)
object with additional class `nectar_request`.

## See also

Other opinionated request functions:
[`req_init()`](https://nectar.api2r.org/reference/req_init.md),
[`req_modify()`](https://nectar.api2r.org/reference/req_modify.md),
[`req_prepare()`](https://nectar.api2r.org/reference/req_prepare.md),
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md)

## Examples

``` r
req <- httr2::request("https://example.com")
req_pagination_policy(req, httr2::iterate_with_offset("page"))
#> <nectar_request/httr2_request>
#> GET https://example.com
#> Body: empty
#> Policies:
#> * pagination: <list>
```
