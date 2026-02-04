# Error messaging for this package.

Error messaging for this package.

## Usage

``` r
.nectar_abort(
  message,
  error_class,
  ...,
  call = rlang::caller_env(),
  .envir = rlang::caller_env()
)
```

## Arguments

- message:

  It is formatted via a call to
  [`cli_bullets()`](https://cli.r-lib.org/reference/cli_bullets.html).

- error_class:

  (`length-1 character`) A short string to identify the error family.

- ...:

  These dots are for future extensions and must be empty.

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

- .envir:

  Environment to evaluate the glue expressions in.

## Value

An error condition with classes `"nectar-condition"`, `"nectar-error"`,
and `"nectar-error-{error_class}"`.
