# Discard empty elements

Discard empty elements in nested lists.

## Usage

``` r
compact_nested_list(lst)
```

## Arguments

- lst:

  A (nested) list to filter.

## Value

The list, minus empty elements and branches.

## Examples

``` r
x <- list(
  a = list(
    b = letters,
    c = NULL,
    d = 1:5
  ),
  e = NULL,
  f = 1:3
)
compact_nested_list(x)
#> $a
#> $a$b
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"
#> 
#> $a$d
#> [1] 1 2 3 4 5
#> 
#> 
#> $f
#> [1] 1 2 3
#> 
```
