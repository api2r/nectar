# Use a function if args are provided

Use a function if args are provided

## Usage

``` r
.do_if_args_defined(x, fn = NULL, ..., call = rlang::caller_env())
```

## Arguments

- x:

  (multiple types) The object to update.

- fn:

  A function to apply to `x`. If `fn` is `NULL`, `x` is returned
  unchanged.

- ...:

  These dots are for future extensions and must be empty.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

## Value

The object, potentially modified.
