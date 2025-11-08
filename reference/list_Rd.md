# Combine Rd fragments

Combine Rd fragments and strings into one object.

## Usage

``` r
list_Rd(..., Rd_tag = NULL, Rd_class = FALSE)
```

## Arguments

- ...:

  named list of objects to combine, see \`Details'.

- Rd_tag:

  if non-null, a value for the `Rd_tag` of the result.

- Rd_class:

  logical; if TRUE, the result will be of class "Rd".

## Details

The names of named arguments specify tags for the corresponding elements
(not arbitrary tags, ones that are converted to macro names by
prepending backslash to them). This is a convenient way to specify
sections, items, etc, in cases when the arguments have not being tagged
by previous processing. Character string arguments are converted to the
appropriate Rd pieces.

Argument `...` may contain a mixture of character vactors and Rd pieces.

## Value

an Rd object or list with `Rd_tag` attribute, as specified by the
arguments.

## Author

Georgi N. Boshnakov

## See also

[`c_Rd`](https://geobosh.github.io/Rdpack/reference/c_Rd.md)

## Examples

``` r
## see also the examples for c_Rd

dummyfun <- function(x, ...) x

u1 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x)",
              value = "numeric vector",
              author = "A. Author",
              Rd_class=TRUE )
Rdo_show(u1)

# call reprompt to fill the arguments section (and correct the usage)
fn <- tempfile("dummyfun", fileext = "Rd")
reprompt(dummyfun, filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#> Error in reprompt(dummyfun, filename = fn): unsuccessful attempt to create Rd doc. using a 'prompt' function.

# check that the result can be parsed and show it.
Rdo_show(tools::parse_Rd(fn))
#> Warning: cannot open file '/tmp/RtmpYjkkCT/dummyfun1d932b9fea86Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

unlink(fn)
```
