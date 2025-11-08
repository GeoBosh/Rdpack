# Parse formal arguments of functions

Parse formal arguments of functions and convert them to f_usage objects.

## Usage

``` r
parse_pairlist(x)

pairlist2f_usage1(x, name, S3class = "", S4sig = "", infix = FALSE,
                  fu = TRUE)
```

## Arguments

- x:

  a pairlist representing the arguments of a function.

- name:

  function name.

- S3class:

  S3 class, see \`Details'

- S4sig:

  S4 signature, see Details.

- infix:

  if `TRUE` the function usage is in infix form, see Details.

- fu:

  if TRUE the object is a function, otherwise it is something else (e.g.
  a variable or a constant like `pi` and `Inf`).

## Details

These functions are mostly internal.

`parse_pairlist` parses the pairlist object, `x`, into a list with two
components. The first component contains the names of the arguments. The
second component is a named list containing the default values,
converted to strings. Only arguments with default values have entries in
the second component (so, it may be of length zero). If `x` is empty or
`NULL`, both components have length zero. An example:

    parse_pairlist(formals(system.file))
    ##: $argnames
    ##: [1] "..."      "package"  "lib.loc"  "mustWork"##: $defaults
    ##:    package    lib.loc   mustWork
    ##: "\"base\""     "NULL"    "FALSE" 

`pairlist2f_usage1()` creates an object of S3 class `"f_usage"`. The
object contains the result of parsing `x` with `parse_pairlist(x)` and a
number of additional components which are copies of the remaining
arguments to the function (without any processing). The components are
listed in section Values. `S3class` is set to an S3 class for for S3
methods, `S4sig` is the signature of an S4 method (as used in Rd macro
`\S4method`). `infix` is `TRUE` for the rare occations when the function
is primarily used in infix form.

Class `"f_usage"` has a method for
[`as.character()`](https://rdrr.io/r/base/character.html) which
generates a text suitable for inclusion in Rd documentation.

    pairlist2f_usage1(formals(summary.lm), "summary", S3class = "lm")
    ##: name      = summary
    ##: S3class   = lm
    ##: S4sig     =
    ##: infix     = FALSE
    ##: fu        = TRUE
    ##: argnames  = object correlation symbolic.cor ...
    ##: defaults  : correlation = FALSE
    ##:             symbolic.cor = FALSE 

## Value

For `parse_pairlist`, a list with the following components:

- argnames:

  the names of all arguments, a character vector

- defaults:

  a named character vector containing the default values, converted to
  character strings. Only arguments with defaults have entries in this
  vector.

For `pairlist2f_usage1`, an object with S3 class `"f_usage"`. This is a
list as for `parse_pairlist` and the following additional components:

- name:

  function name, a character string.

- S3class:

  S3 class, a character string; `""` if not an S3 method.

- S4sig:

  S4 signature; `""` if not an S4 method.

- infix:

  a logical value, `TRUE` for infix operators.

- fu:

  indicates the type of the object, usually `TRUE`, see Details.

## Author

Georgi N. Boshnakov

## See also

[`promptUsage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
accepts `f_usage` objects,
[`get_usage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)

## Examples

``` r
parse_pairlist(formals(lm))
#> $argnames
#>  [1] "formula"     "data"        "subset"      "weights"     "na.action"  
#>  [6] "method"      "model"       "x"           "y"           "qr"         
#> [11] "singular.ok" "contrasts"   "offset"      "..."        
#> 
#> $defaults
#>      method       model           x           y          qr singular.ok 
#>    "\"qr\""      "TRUE"     "FALSE"     "FALSE"      "TRUE"      "TRUE" 
#>   contrasts 
#>      "NULL" 
#> 
parse_pairlist(formals(system.file))
#> $argnames
#> [1] "..."      "package"  "lib.loc"  "mustWork"
#> 
#> $defaults
#>    package    lib.loc   mustWork 
#> "\"base\""     "NULL"    "FALSE" 
#> 
s_lm <- pairlist2f_usage1(formals(summary.lm), "summary", S3class = "lm")
s_lm
#> name      = summary 
#> S3class   = lm 
#> S4sig     =  
#> infix     = FALSE 
#> fu        = TRUE 
#> argnames  = object correlation symbolic.cor ... 
#> defaults  : correlation = FALSE 
#>             symbolic.cor = FALSE 
#> 
as.character(s_lm)
#>                                                                            summary 
#> "\\method{summary}{lm}(object, correlation = FALSE, symbolic.cor = FALSE, \\dots)" 
```
