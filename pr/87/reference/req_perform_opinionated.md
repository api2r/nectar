# Perform a request with opinionated defaults

This function ensures that a request has
[`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html)
applied, and then performs the request, using either
[`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)
(if a `next_req_fn` function is supplied) or
[`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)
(if not).

## Usage

``` r
req_perform_opinionated(
  req,
  ...,
  next_req_fn = choose_pagination_fn(req),
  max_reqs = 2,
  max_tries_per_req = 3
)
```

## Arguments

- req:

  The first [request](https://httr2.r-lib.org/reference/request.html) to
  perform.

- ...:

  These dots are for future extensions and must be empty.

- next_req_fn:

  (`function`) An optional function that takes the previous response
  (`resp`) and request (`req`), and returns a new request. This function
  is passed as `next_req` in a call to
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html).
  This function can usually be generated using one of the iteration
  helpers described in
  [`httr2::iterate_with_offset()`](https://httr2.r-lib.org/reference/iterate_with_offset.html).
  By default,
  [`choose_pagination_fn()`](https://nectar.api2r.org/reference/choose_pagination_fn.md)
  is used to check for a pagination policy (see
  [`req_pagination_policy()`](https://nectar.api2r.org/reference/req_pagination_policy.md)),
  and returns `NULL` if no such policy is defined.

- max_reqs:

  (`length-1 integer`) The maximum number of separate requests to
  perform. Passed to the max_reqs argument of
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)
  when `next_req` is supplied. You will mostly likely want to change the
  default value (`2`) to `Inf` after you validate that the request
  works.

- max_tries_per_req:

  (`length-1 integer`) The maximum number of times to attempt each
  individual request. Passed to the `max_tries` argument of
  [`httr2::req_retry()`](https://httr2.r-lib.org/reference/req_retry.html).

## Value

Always returns a list of
[`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
objects, one for each request performed, to ensure that downstream
operations are the same regardless of the number of responses. The list
has additional class `nectar_responses`.

## Examples

``` r
# Performs a single request and returns a list of responses
req <- httr2::request("https://jsonplaceholder.typicode.com/posts")
resps <- req_perform_opinionated(req)
httr2::resp_status(resps[[1]])
#> [1] 200
resp_parse(resps, response_parser = resp_tidy_json)
#> # A tibble: 100 × 4
#>    userId    id title                                                      body 
#>     <int> <int> <chr>                                                      <chr>
#>  1      1     1 sunt aut facere repellat provident occaecati excepturi op… "qui…
#>  2      1     2 qui est esse                                               "est…
#>  3      1     3 ea molestias quasi exercitationem repellat qui ipsa sit a… "et …
#>  4      1     4 eum et est occaecati                                       "ull…
#>  5      1     5 nesciunt quas odio                                         "rep…
#>  6      1     6 dolorem eum magni eos aperiam quia                         "ut …
#>  7      1     7 magnam facilis autem                                       "dol…
#>  8      1     8 dolorem dolore est ipsam                                   "dig…
#>  9      1     9 nesciunt iure omnis dolorem tempora et accusantium         "con…
#> 10      1    10 optio molestias id quia eum                                "quo…
#> # ℹ 90 more rows
```
