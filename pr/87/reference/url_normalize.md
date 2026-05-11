# Normalize a URL

This function normalizes a URL by adding a trailing slash to the base if
it is missing. It is mainly for testing and other comparisons.

## Usage

``` r
url_normalize(url)
```

## Arguments

- url:

  A URL to normalize.

## Value

A normalized URL

## Examples

``` r
identical(
  url_normalize("https://example.com"),
  url_normalize("https://example.com/")
)
#> [1] TRUE
identical(
  url_normalize("https://example.com?param=value"),
  url_normalize("https://example.com/?param=value")
)
#> [1] TRUE
```
