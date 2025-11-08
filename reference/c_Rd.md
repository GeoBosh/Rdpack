# Concatenate Rd objects or pieces

Concatenates Rd objects or pieces

## Usage

``` r
c_Rd(...)
```

## Arguments

- ...:

  objects to be concatenated, Rd objects or character strings, see
  \`Details'.

## Details

The arguments may be a mixture of lists and character strings. The lists
are typically "Rd" objects or pieces. The character strings may also be
elements of "Rd" objects carrying "Rd_tag" attributes. The "Rd_tag"
attribute of character strings for which it is missing is set to "TEXT".
Finally, each character element of `"\dots"` is enclosed in `list`.

Eventually all arguments become lists and they are concatenated using
[`c()`](https://rdrr.io/r/base/c.html). If any of the arguments is of
class "Rd", the class of the result is set to "Rd". Otherwise, the
"Rd_tag" of the result is set to the first (if any) non-null "Rd_tag" in
the arguments.

The structure of "Rd" objects is described by Murdoch (2010) .

## Value

An Rd object or a list whose attribute "Rd_tag" is set as descibed in
\`Details'

## Author

Georgi N. Boshnakov

## See also

[`list_Rd`](https://geobosh.github.io/Rdpack/reference/list_Rd.md)

## References

Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.

## Examples

``` r
a1 <- char2Rdpiece("Dummyname", "name")
a2 <- char2Rdpiece("Dummyallias1", "alias")
a3 <- char2Rdpiece("Dummy title", "title")
a4 <- char2Rdpiece("Dummy description", "description")

## The following are equivalent
## (gbRd::Rdo_empty() creates an empty list of class 'Rd')
if(requireNamespace("gbRd")){
b1 <- c_Rd(gbRd::Rdo_empty(), list(a1), list(a2), list(a3), list(a4))
c1 <- c_Rd(gbRd::Rdo_empty(), list(a1, a2, a3, a4))
d1 <- c_Rd(gbRd::Rdo_empty(), list(a1, a2), list(a3, a4))
identical(c1, b1)
identical(c1, d1)
Rdo_show(b1)

## insert a newline
d1n <- c_Rd(gbRd::Rdo_empty(), list(a1, a2), Rdo_newline(), list(a3, a4))
str(d1n)
}
#> Loading required namespace: gbRd
#> List of 5
#>  $ :List of 1
#>   ..$ : chr "Dummyname"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   ..- attr(*, "Rd_tag")= chr "\\name"
#>  $ :List of 1
#>   ..$ : chr "Dummyallias1"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   ..- attr(*, "Rd_tag")= chr "\\alias"
#>  $ : chr "\n"
#>   ..- attr(*, "Rd_tag")= chr "TEXT"
#>  $ :List of 1
#>   ..$ : chr "Dummy title"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   ..- attr(*, "Rd_tag")= chr "\\title"
#>  $ :List of 1
#>   ..$ : chr "Dummy description"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   ..- attr(*, "Rd_tag")= chr "\\description"
#>  - attr(*, "class")= chr "Rd"

## When most of the arguments are character strings
## the function 'list_Rd' may be more convenient.
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class = TRUE )
Rdo_show(u1)
```
