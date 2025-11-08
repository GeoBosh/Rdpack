# Find elements of Rd objects for which a condition is true

Find elements of Rd objects for which a condition is true.

## Usage

``` r
Rdo_which(rdo, fun)

Rdo_which_tag_eq(rdo, tag)

Rdo_which_tag_in(rdo, tags)
```

## Arguments

- rdo:

  an Rd object.

- fun:

  a function to evaluate with each element of `rdo`.

- tag:

  a character string.

- tags:

  a character vector.

## Details

These functions return the indices of the (top level) elements of `rdo`
which satisfy a condition.

`Rdo_which` finds elements of `rdo` for which the function `fun` gives
TRUE.

`Rdo_which_tag_eq` finds elements with a specific `Rd_tag`.

`Rdo_which_tag_in` finds elements whose `Rd_tag`'s are among the ones
specified by `tags`.

## Value

a vector of positive integers

## Author

Georgi N. Boshnakov

## See also

[`Rdo_locate`](https://geobosh.github.io/Rdpack/reference/Rdo_locate.md)
which searches recursively the Rd object.

## Examples

``` r
## get the help page for topoc seq()
rdo_seq <- tools::Rd_db("base")[["seq.Rd"]]
## find location of aliases in the topic
( ind <- Rdo_which_tag_eq(rdo_seq, "\alias") )
#> integer(0)
## extract the first alias
rdo_seq[[ ind[1] ]]
#> NULL
if (FALSE) { # \dontrun{
## extract all aliases
rdo_seq[ind]
} # }

## db_bibtex <- tools::Rd_db("bibtex")
## names(db_bibtex)
## ## Rdo object for read.bib()
## rdo_read.bib <- db_bibtex[["read.bib.Rd"]]
## Rdo_tags(rdo_read.bib)
## 
## ## which elements of read.bib are aliases?
## Rdo_which_tag_eq(rdo_read.bib, "\alias")
## rdo_read.bib[[3]]
## 
## ## which elements of read.bib contain R code?
## Rdo_which(rdo_read.bib, function(x) any(Rdo_tags(x) == "RCODE") )
## rdo_read.bib[[5]]
## ## which contain prose?
## Rdo_which(rdo_read.bib, function(x) any(Rdo_tags(x) == "TEXT") )
```
