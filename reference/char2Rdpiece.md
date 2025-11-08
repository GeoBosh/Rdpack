# Convert a character vector to Rd piece

Convert a character vector to Rd piece.

## Usage

``` r
char2Rdpiece(content, name, force.sec = FALSE)
```

## Arguments

- content:

  a character vector.

- name:

  name of an Rd macro, a string.

- force.sec:

  TRUE or FALSE, see \`Details'.

## Details

Argument `content` is converted to an Rd piece using `name` to determine
the format of the result.

The `Rd tag` of `content` is set as appropriate for `name`. More
specifically, if `name` is the name of a macro (without the leading
\``\`') whose content has a known "Rdtag", that tag is used. Otherwise
the tag is set to "TEXT".

If `force.sec` is TRUE, `name` is treated as the name of a top level
section of an Rd object. A top level section is exported as one argument
macro if it is a standard section (detected with
[`is_Rdsecname`](https://geobosh.github.io/Rdpack/reference/Rdo_piecetag.md))
and as the two argument macro "`\section`" otherwise.

If `force.sec` is FALSE, the content is exported as one argument macro
without further checks.

## Author

Georgi N. Boshnakov

## Note

This function does not attempt to escape special symbols like \`%'.

## Examples

``` r
## add a keyword section
a1 <- char2Rdpiece("graphics", "keyword")
a1
#> [[1]]
#> [1] "graphics"
#> attr(,"Rd_tag")
#> [1] "TEXT"
#> 
#> attr(,"Rd_tag")
#> [1] "\\keyword"
## "keyword" is a standard Rd top level section, so 'force.sec' is irrelevant
a2 <- char2Rdpiece("graphics", "keyword", force.sec = TRUE)
identical(a1, a2)
#> [1] TRUE

## an element suitable to be put in a "usage" section
char2Rdpiece("log(x, base = exp(1))", "usage")
#> [[1]]
#> [1] "log(x, base = exp(1))"
#> attr(,"Rd_tag")
#> [1] "RCODE"
#> 
#> attr(,"Rd_tag")
#> [1] "\\usage"

## a user defined section "Todo"
char2Rdpiece("Give more examples for this function.", "Todo", force.sec = TRUE)
#> [[1]]
#> [[1]][[1]]
#> [1] "Todo"
#> attr(,"Rd_tag")
#> [1] "TEXT"
#> 
#> 
#> [[2]]
#> [[2]][[1]]
#> [1] "Give more examples for this function."
#> attr(,"Rd_tag")
#> [1] "TEXT"
#> 
#> 
#> attr(,"Rd_tag")
#> [1] "\\section"
```
