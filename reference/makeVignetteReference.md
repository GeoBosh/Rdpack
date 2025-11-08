# Make bibtex references for vignettes

Make bibtex references for vignettes

## Usage

``` r
makeVignetteReference(package, vig = 1, verbose = TRUE, title, author, 
                      type = "pdf", bibtype = "Article", key = NULL)

vigbib(package, verbose = TRUE, ..., vig = NULL)
```

## Arguments

- package:

  a character string, the name of an installed package.

- vig:

  an integer number or a character string identifying a vignette.

- verbose:

  if `TRUE`, print the references in Bibtex format.

- title:

  a character string, title of the vignette, see Details.

- author:

  a character string, title of the vignette, see Details.

- type:

  a character string, type of the vignette, such as `"pdf"` or `"html"`.
  Currently ignored.

- bibtype:

  a character string, Bibtex type for the reference, defaults to
  `"Article"`.

- key:

  a character string specifying a key for the Bibtex entry. If missing,
  suitable key is generated automatically.

- ...:

  arguments passed by `vigbib()` to `makeVignetteReference()`.

## Details

`vigbib()` generates Bibtex references for all vignettes in a package.
`makeVignetteReference()` produces a Bibtex entry for a particular
vignette.

There seems to be no standard way to cite vignettes in R packages. For
vignettes that are complete journal papers (most notably in the Journal
of Statistical Software), the authors would usually prefer the papers to
be cited, rather than the vignette. In any case, consulting the output
of `citation("a_package")` is the best starting point. If the vignette
has been extended substantially after the paper was published, cite
both.

In many cases it is sufficient to give the command that opens the
vignette, e.g.:

`vignette("Inserting_bibtex_references", package = "Rdpack")`.

`makeVignetteReference()` makes a Bibtex entry for one vignette. It
looks for the available vignettes using `vignette(package=package)`.
Argument `vig` can be a character string identifying the vignette by the
name that would be used in a call to
[`vignette()`](https://rdrr.io/r/utils/vignette.html). It can also be an
integer, identifying the vignette by the index (in the order in which
the vignettes are returned by
[`vignette()`](https://rdrr.io/r/utils/vignette.html)). By default the
first vignette is returned. If `vig` is not suitable, a suitable list of
alternatives is printed.

For `vigbib()` it is sufficient to give the name of a package. It
accepts all arguments of `makeVignetteReference()` except `vig`
(actually, supplying `vig` is equivallent to calling
`makeVignetteReference()` directly).

The remaining arguments can be used to overwrite some automatically
generated entries. For example, the vignette authors may not be the same
as the package authors.

## Value

a bibentry object containing the generated references (the Bibtex
entries are also printed, so that they can be copied to a bib file)

## Author

Georgi N. Boshnakov

## Examples

``` r
## NOTE (2020-01-21): the following examples work fine, but are not
##   rendered correctly by pkgdown::build_site(), so there may be errors
##   on the site produced by it, https://geobosh.github.io/Rdpack/.

vigbib("Rdpack")
#> No vignettes found in package  Rdpack 
#> bibentry()
makeVignetteReference("Rdpack", vig = 1)
#> Error in makeVignetteReference("Rdpack", vig = 1): not ready yet, should return all vigs in the package.
makeVignetteReference("Rdpack", vig = "Inserting_bibtex_references")
#> Error in makeVignetteReference("Rdpack", vig = "Inserting_bibtex_references"): 'vig' must (partially) match one of:
#>  1 
#> 
#>  0 
#> Alternatively, 'vig' can be the index printed in front of the name above.
## the first few characters of the name suffice:
makeVignetteReference("Rdpack", vig = "Inserting_bib")
#> Error in makeVignetteReference("Rdpack", vig = "Inserting_bib"): 'vig' must (partially) match one of:
#>  1 
#> 
#>  0 
#> Alternatively, 'vig' can be the index printed in front of the name above.

## this gives an error but also prints the available vignettes:
## makeVignetteReference("Matrix", vig = "NoSuchVignette")

vigbib("utils")
#> @Article{vigutils:Sweave,
#>   title = {Sweave User Manual},
#>   author = {R Core Team and contributors worldwide},
#>   journal = {URL https://CRAN.R-Project.org. Vignette included in R package utils (Part of R 4.5.2)},
#>   year = {2025},
#>   publisher = {CRAN},
#>   url = {https://CRAN.R-Project.org},
#> }
makeVignetteReference("utils", vig = 1)
#> @Article{vigutils:Sweave,
#>   title = {Sweave User Manual},
#>   author = {R Core Team and contributors worldwide},
#>   journal = {URL https://CRAN.R-Project.org. Vignette included in R package utils (Part of R 4.5.2)},
#>   year = {2025},
#>   publisher = {CRAN},
#>   url = {https://CRAN.R-Project.org},
#> }
#> 
#> Team RC, worldwide c (2025). “Sweave User Manual.” _URL
#> https://CRAN.R-Project.org. Vignette included in R package utils (Part
#> of R 4.5.2)_. <https://CRAN.R-Project.org>.
## commented out since can be slow:
## high <- installed.packages(priority = "high")
## highbib <- lapply(rownames(high), function(x) try(Rdpack:::vigbib(x, verbose = FALSE)))
```
