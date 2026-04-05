# Extract and clean a JSON API response

Parse the body of a response with
[`httr2::resp_body_json()`](https://httr2.r-lib.org/reference/resp_body_raw.html),
extract a named subset of that body, and tidy the result with
[`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html).

## Usage

``` r
resp_tidy_json(resp, spec = NULL, unspecified = "list", subset_path = NULL)
```

## Arguments

- resp:

  (`httr2_response`) A single
  [`httr2::response()`](https://httr2.r-lib.org/reference/response.html)
  object (as returned by
  [`httr2::req_perform()`](https://httr2.r-lib.org/reference/req_perform.html)).

- spec:

  (`tspec` or `NULL`) A specification used by
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  to parse the extracted body of `resp`. When `spec` is `NULL` (the
  default),
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  will attempt to guess a spec.

- unspecified:

  (`length-1 character`) A string that describes what happens if the
  extracted body of `resp` contains fields that are not specified in
  `spec`. While
  [`tibblify::tibblify()`](https://tibblify.wrangle.zone/reference/tibblify.html)
  defaults to `NULL` for this value, we set it to `list` so that the
  body will still parse when `resp` contains extra data without throwing
  errors.

- subset_path:

  (`character`) An optional vector indicating the path to the "real"
  object within the body of `resp`. For example, many APIs return a body
  with information about the status of the response, cache information,
  perhaps pagination information, and then the actual data in a field
  such as `data`. If the desired part of the response body is in
  `data$objects`, the value of this argument should be
  `c("data", "object")`.

## Value

The tibblified response body.
