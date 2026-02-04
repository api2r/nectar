# Ensure an argument is a length-1 character

Calls to APIs often require a string argument. This function ensures
that those arguments are length-1, non-`NA` character vectors, or
length-1, non-`NA` vectors that can be coerced to character vectors.
This is intended to ensure that calls to the API will not fail with
predictable errors, thus avoiding unnecessary internet traffic.

## Usage

``` r
stabilize_string(
  x,
  ...,
  regex = NULL,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
)
```

## Arguments

- x:

  The argument to stabilize.

- ...:

  Arguments passed on to
  [`stbl::stabilize_chr_scalar`](https://stbl.api2r.org/reference/stabilize_chr.html)

  `x_class`

  :   `(length-1 character)` The class name of `x` to use in error
      messages. Use this if you remove a special class from `x` before
      checking its coercion, but want the error message to match the
      original class.

- regex:

  `(character, list, or stringr_pattern)` One or more optional regular
  expressions to test against the values of `x`. This can be a character
  vector, a list of character vectors, or a pattern object from the
  {stringr} package (e.g., `stringr::fixed("a.b")`). The default error
  message for non-matching values will include the pattern itself (see
  [`regex_must_match()`](https://stbl.api2r.org/reference/regex_must_match.html)).
  To provide a custom message, supply a named character vector where the
  value is the regex pattern and the name is the message that should be
  displayed. To check that a pattern is *not* matched, attach a `negate`
  attribute set to `TRUE`. If a complex regex pattern throws an error,
  try installing the stringi package.

- arg:

  An argument name as a string. This argument will be mentioned in error
  messages as the input that is at the origin of a problem.

- call:

  The execution environment of a currently running function, e.g.
  `caller_env()`. The function will be mentioned in error messages as
  the source of the error. See the `call` argument of
  [`abort()`](https://rlang.r-lib.org/reference/abort.html) for more
  information.

## Value

`x` coerced to a length-1 character vector, if possible.

## Examples

``` r
stabilize_string("a")
#> [1] "a"
stabilize_string(1.1)
#> [1] "1.1"
x <- letters
try(stabilize_string(x))
#> Error in eval(expr, envir) : 
#>   `x` must be a single <character>.
#> ✖ `x` has 26 values.
x <- NULL
try(stabilize_string(x))
#> Error in eval(expr, envir) : `x` must not be <NULL>.
x <- character()
try(stabilize_string(x))
#> Error in eval(expr, envir) : 
#>   `x` must be a single <character (non-empty)>.
#> ✖ `x` has no values.
x <- NA
try(stabilize_string(x))
#> Error in eval(expr, envir) : `x` must not contain NA values.
#> • NA locations: 1
```
