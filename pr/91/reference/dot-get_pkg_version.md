# Get package numeric version

Get package numeric version

## Usage

``` r
.get_pkg_version(pkg_name = get_pkg_name(call), call = rlang::caller_env())
```

## Arguments

- pkg_name:

  (`length-1 character`) The name of the calling package. This will
  usually be automatically determined based on the source of the call.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

The numeric version of the package.
