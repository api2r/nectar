# Raise a package-scoped error

Raise a package-scoped error

## Usage

``` r
.nectar_abort(
  message,
  subclass,
  call = caller_env(),
  message_env = caller_env(),
  ...
)
```

## Arguments

- message:

  (`character`) The message for the new error. Messages will be
  formatted with
  [`cli::cli_bullets()`](https://cli.r-lib.org/reference/cli_bullets.html).

- subclass:

  (`character`) Class(es) to assign to the error. Will be prefixed by
  "{package}-error-".

- call:

  (`environment`) The environment from which a function was called, e.g.
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)
  (the default). The environment will be mentioned in error messages as
  the source of the error. This argument is particularly useful for
  functions that are intended to be called as utilities inside other
  functions.

- message_env:

  (`environment`) The execution environment to use to evaluate variables
  in error messages.

- ...:

  These dots are for future extensions and must be empty.

## Value

An error condition with classes `"nectar-condition"`, `"nectar-error"`,
and `"nectar-error-{subclass}"`.
