# Convert f_usage objects to text appropriate for usage sections in Rd files

Converts f_usage objects to text appropriate for usage sections in Rd
files. Handles S3 methods.

## Usage

``` r
deparse_usage(x)
deparse_usage1(x, width = 72)
# S3 method for class 'f_usage'
as.character(x, ... )
```

## Arguments

- x:

  an object from class `"f_usage"`. For `deparse_usage`, `x` can also be
  a list of `"f_usage"` objects.

- width:

  maximal width of text on a line.

- ...:

  ignored.

## Details

Both, `deparse_usage1` and the `as.character` method for class
`"f_usage"`, convert an `"f_usage"` object to a character string
suitable for Rd documentation. The `as.character` method is the user
level function (it just calls `deparse_usage1`), `deparse_usage1` is
internal function for programming. In the example below the first
command creates an `"f_usage"` object, then the second converts it to
character string.

    (a <- pairlist2f_usage1(formals(cor), "cor"))
    ##: name      = cor
    ##: S3class   =
    ##: S4sig     =
    ##: infix     = FALSE
    ##: fu        = TRUE
    ##: argnames  = x y use method
    ##: defaults  : y = NULL
    ##:             use = "everything"
    ##:             method = c("pearson", "kendall", "spearman") cat(as.character(a))
    ##: cor(x, y = NULL, use = "everything",
    ##:     method = c("pearson", "kendall", "spearman"))

Each usage entriy is formatted and, if necessary, split over several
lines. The width (number of characters) on a line can be changed with
argument `width`.

`deparse_usage` can be used when `x` is a list of `"f_usage"` objects.
It calls `deparse_usage1` with each of them and returns a character
vector with one element for each component of `x`. When `x` is an object
from class `"f_usage"`, `deparse_usage` is equivalent to
`deparse_usage1`.

## Value

For `deparse_usage1` and `as.character.f_usage`, a named character
vector of length one (the name is the function name).

For `deparse_usage`, a named character vector with one entry for the
usage text for each function.

## Author

Georgi N. Boshnakov

## See also

[`pairlist2f_usage1`](https://geobosh.github.io/Rdpack/reference/parse_pairlist.md)

## Examples

``` r
cur_wd <- getwd()
tmpdir <- tempdir()
setwd(tmpdir)

## prepare a list of "f_usage" objects
fnseq <- reprompt(seq)            # get and save the help page of "seq"
#> Rd source not supplied, looking for installed documentation.
#> Installed documentation found, processing it...
#>  The Rd content was written to file  seq.Rd 
rdoseq <- tools::parse_Rd(fnseq)  # parse the Rd file
ut <- get_usage_text(rdoseq)      # get the contents of the usage section
cat(ut, "\n")                     #     of seq() (a character string)
#> 
#> seq(\dots)
#> 
#> \method{seq}{default}(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
#>     length.out = NULL, along.with = NULL, \dots)
#> 
#> seq.int(from, to, by, length.out, along.with, \dots)
#> 
#> seq_along(along.with)
#> seq_len(length.out) 
utp <- parse_usage_text(ut)       # parse to a list of "f_usage" objects

## deparse the "f_usage" list - each statement gets a separate string
cat(deparse_usage(utp), sep = "\n")
#> seq(\dots)
#> \method{seq}{default}(from = 1, to = 1, by = ((to - from)/(length.out - 1)), 
#>     length.out = NULL, along.with = NULL, \dots)
#> seq.int(from, to, by, length.out, along.with, \dots)
#> seq_along(along.with)
#> seq_len(length.out)

## explore some of the usage entries individually;
## the generic seq() has a boring signature
utp[[1]]
#> name      = seq 
#> S3class   =  
#> S4sig     =  
#> infix     = FALSE 
#> fu        = TRUE 
#> argnames  = ... 
#> 
as.character(utp[[1]])
#>           seq 
#> "seq(\\dots)" 
deparse_usage1(utp[[1]])  # same
#>           seq 
#> "seq(\\dots)" 

## the default S3 method is more interesting
utp[[2]]
#> name      = seq 
#> S3class   = default 
#> S4sig     =  
#> infix     = FALSE 
#> fu        = TRUE 
#> argnames  = from to by length.out along.with ... 
#> defaults  : from = 1 
#>             to = 1 
#>             by = ((to - from)/(length.out - 1)) 
#>             length.out = NULL 
#>             along.with = NULL 
#> 
cat(deparse_usage1(utp[[2]]))
#> \method{seq}{default}(from = 1, to = 1, by = ((to - from)/(length.out - 1)), 
#>     length.out = NULL, along.with = NULL, \dots)
cat(as.character(utp[[2]]))   # same
#> \method{seq}{default}(from = 1, to = 1, by = ((to - from)/(length.out - 1)), 
#>     length.out = NULL, along.with = NULL, \dots)

unlink(fnseq)
setwd(cur_wd)
unlink(tmpdir)
```
