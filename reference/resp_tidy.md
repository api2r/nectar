# Extract and clean an API response

API responses generally follow a structured format. Use this function to
extract the relevant portion of a response, and wrangle it into a
desired format. This function is most useful when the response was
fetched with a request that includes a tidying policy defined via
[`req_tidy_policy()`](https://nectar.api2r.org/reference/req_tidy_policy.md).

## Usage

``` r
resp_tidy(resps)
```

## Arguments

- resps:

  (`httr2_response`, `nectar_responses`, or `list`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html))
  or a list of such objects (as returned by
  [`req_perform_opinionated()`](https://nectar.api2r.org/reference/req_perform_opinionated.md)
  or
  [`httr2::req_perform_iterative()`](https://httr2.r-lib.org/reference/req_perform_iterative.html)).

## Value

The extracted and cleaned response, or, for a list of responses, those
responses cleaned then concatenated via
[`httr2::resps_data()`](https://httr2.r-lib.org/reference/resps_successes.html).
By default, the response is processed with
[`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md).

## See also

[`resp_tidy_json()`](https://nectar.api2r.org/reference/resp_tidy_json.md)
for an opinionated response parser for JSON responses,
[`resp_body_auto()`](https://nectar.api2r.org/reference/resp_body_auto.md)
(etc) for a family of response parsers that attempts to automatically
select the appropriate parser based on the response content type,
[`httr2::resp_body_raw()`](https://httr2.r-lib.org/reference/resp_body_raw.html)
(etc) for the underlying httr2 response parsers, and
[`resp_parse()`](https://nectar.api2r.org/reference/resp_parse.md) for
an alternative approach to dealing with responses (particularly useful
if the request does not include a `resp_tidy` policy).

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
  httr2::resp_body_json
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
