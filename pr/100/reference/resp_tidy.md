# Extract and clean an API response

API responses generally follow a structured format. Use this function to
extract the relevant portion of a response, and wrangle it into a
desired format. This function is most useful when the response was
fetched with a request that includes a tidying policy defined via
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md).

## Usage

``` r
resp_tidy(resp)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

## Value

The extracted and cleaned response, or `NULL` if `resp` is `NULL`. By
default, the response is processed with
[`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).
If the request includes a `resp_tidy` policy (set via
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md)),
that policy's function and arguments are used instead.

## See also

Other opinionated response parsers:
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md),
[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md),
[`resp_tidy_json_tibblify()`](https://nectar.api2r.org/reference/resp_tidy_json_tibblify.md),
[`resp_tidy_unknown()`](https://nectar.api2r.org/reference/resp_tidy_unknown.md),
[`tidy_policy_body_auto()`](https://nectar.api2r.org/reference/tidy_policy_body_auto.md),
[`tidy_policy_json()`](https://nectar.api2r.org/reference/tidy_policy_json.md),
[`tidy_policy_json_tibblify()`](https://nectar.api2r.org/reference/tidy_policy_json_tibblify.md),
[`tidy_policy_prepare()`](https://nectar.api2r.org/reference/tidy_policy_prepare.md),
[`tidy_policy_unknown()`](https://nectar.api2r.org/reference/tidy_policy_unknown.md)

## Examples

``` r
# Without a tidy policy, resp_tidy() uses resp_body_auto()
resp <- httr2::response_json(body = list(a = 1, b = "hello"))
resp_tidy(resp)
#> $a
#> [1] 1
#> 
#> $b
#> [1] "hello"
#> 

# With a tidy policy, resp_tidy() uses the policy's tidy function.
req <- req_tidy_policy(
  httr2::request("https://example.com"),
  tidy_policy_prepare(httr2::resp_body_json)
)
# In practice, the request is attached automatically when the response is
# fetched with httr2::req_perform() or req_perform_opinionated().
resp$request <- req
resp_tidy(resp)
#> $a
#> [1] 1
#> 
#> $b
#> [1] "hello"
#> 
```
