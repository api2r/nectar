# Get calling package name

Get calling package name

## Usage

``` r
get_pkg_name(call = rlang::caller_env())
```

## Arguments

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

The package name, or `NULL` (invisibly). This function is intended to be
used in other nectar functions to automatically detect the calling
package name.
