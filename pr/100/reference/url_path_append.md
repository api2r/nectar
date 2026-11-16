# Add path elements to a URL

Append zero or more path elements to a URL without duplicating "/"
characters. Based on
[`httr2::req_url_path_append()`](https://httr2.r-lib.org/reference/req_url.html).

## Usage

``` r
url_path_append(url, ...)
```

## Arguments

- url:

  A URL to modify.

- ...:

  Path elements to append, as strings.

## Value

A modified URL.

## Examples

``` r
url_path_append("https://example.com", "api", "v1", "users")
#> [1] "https://example.com/api/v1/users"
url_path_append("https://example.com/", "/api", "/v1", "/users")
#> [1] "https://example.com/api/v1/users"
url_path_append("https://example.com/", "/api/v1/users")
#> [1] "https://example.com/api/v1/users"
```
