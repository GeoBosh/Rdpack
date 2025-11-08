# Find leaves of an Rd object using a predicate

Apply a function to the character leaves of an Rd object and return the
indices of those for which the result is TRUE.

## Usage

``` r
Rdo_locate_leaves(object, f = function(x) TRUE)
```

## Arguments

- object:

  the object to be examined, usually a list.

- f:

  a function (predicate) returning TRUE for elements with the desired
  property.

## Details

`object` can be any list whose elements are character strings or lists.
The structure is examined recursively. If `object` is a character
vector, it is enclosed in a list.

This function provides a convenient way to locate leaves of an Rd object
with a particular content. The function is not limited to Rd objects but
it assumes that the elements of `object` are either lists or charater
vectors and currently does not check if this is the case.

**todo:** describe the case of
[`list()`](https://rdrr.io/r/base/list.html) (`Rd_tag`'ed.)

## Value

a list of the positions of the leaves for which the predicate gives
`TRUE`. Each position is an integer vector suitable for the `"[["`
operator.

## Author

Georgi N. Boshnakov

## Examples

``` r
dummyfun <- function(x) x

fn <- tempfile("dummyfun", fileext = "Rd")
reprompt(dummyfun, filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#> Error in reprompt(dummyfun, filename = fn): unsuccessful attempt to create Rd doc. using a 'prompt' function.
rdo <- tools::parse_Rd(fn)
#> Warning: cannot open file '/tmp/RtmpYjkkCT/dummyfun1d9326affd6Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

f <-  function(x) Rdo_is_newline(x)

nl <- Rdo_locate_leaves(rdo, f )
#> Error: object 'rdo' not found

length(nl)  # there are quite a few newline leaves!
#> Error: object 'nl' not found

unlink(fn)
```
