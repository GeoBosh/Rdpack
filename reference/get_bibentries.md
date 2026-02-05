# Get all references from a Bibtex file

Get all references from a Bibtex file.

## Usage

``` r
get_bibentries(..., package = NULL, bibfile = "REFERENCES.bib", 
               url_only = FALSE, stop_on_error = TRUE)
```

## Arguments

- ...:

  arguments to be passed on to the file getting functions, character
  strings, see \`Details'.

- package:

  name of a package, a character string or NULL.

- bibfile:

  name of a Bibtex file, a character string.

- url_only:

  if TRUE, restrict percent escaping to BibTeX field `"URL"`.

- stop_on_error:

  if `TRUE` stop on error, otherwise issue a warning and return an empty
  `bibentryRd` object.

## Details

`get_bibentries` parses the specified file. and sets its `names`
attribute to the keys of the bib elements (`read.bib()` does this since
version version 0.4.0 of bibtex, as well). Here is what `get_bibentries`
does on top of `read.bib` (the details are further below):

- `get_bibentries` deals with percent signs in URL's.

- if the current working directory is in the development directory of
  `package`, `get_bibentries` will first search for the bib file under
  that directory.

`bibfile` should normally be the base name of the Bibtex file. Calling
`get_bibentries` without any `"\dots"` arguments results in looking for
the Bibtex file in the current directory if package is NULL or missing,
and in the installation directory of the specified package, otherwise.
Argument "..." may be used to specify directories. If `package` is
missing or NULL, the complete path is obtained with
`file.path(..., bibfile)`. Otherwise `package` must be a package name
and the file is taken from the installation directory of the package.
Again, argument "..." can specify subdirectory as in `system.file`.

If the current working directory is in the development directory of
`package`, the bib file is first sought there before resorting to the
installation directory.

Although the base R packages do not have files REFERENCES.bib, argument
`package` can be set to one of them, e.g. `"base"`. This works since
package bibtex provides bib files for the core packages.

By default, `get_bibentries` escapes unescaped percent signs in all
fields of bibtex objects. To restrict this only to field "url", set
argument `url_only` to `FALSE`.

`get_bibentries` returns an object from class `"bibentryRd"`, which
inherits from bibentry. The printing method for `"bibentryRd"` unescapes
percent signs in URLs for some styles where the escapes are undesirable.

## Value

a bibentryRd object inheriting from bibentry

## References

There are no references for Rd macro `\insertAllCites` on this help
page.

## Author

Georgi N. Boshnakov

## Examples

``` r
r <- get_bibentries(package = "Rdpack")
r
#> Francois R (2014). _bibtex: bibtex parser_. R package version 0.4.0.
#> 
#> Boshnakov GN, Putman C (2020). _rbibutils: Convert Between Bibliography
#> Formats_. <https://CRAN.R-project.org/package=rbibutils>.
#> 
#> Murdoch D (2010). “Parsing Rd files.”
#> <https://developer.r-project.org/parseRd.pdf>.
#> 
#> Wickham H, Hester J, Chang W (2018). _devtools: Tools to Make
#> Developing R Packages Easier_. R package version 1.13.5,
#> <https://CRAN.R-project.org/package=devtools>.
#> 
#> ZZZ A (2018). “A non-existent paper with a relation between several
#> fundamental constants: $e^i\pi=-1$ in the title and showing that
#> a\slash b converts to a\slash b.” _A non-existent journal with the
#> formula $L_2$ in its name and \# \$ & \_ \^ \~ an ampersand and other
#> special characters preceded by a backslash in the bib file_. This
#> reference demonstrates that formulas in BibTeX files are OK. A formula
#> in field 'note': $c^2 = a^2 + b^2$. If you need to, even display math
#> is possible: $$ E = mc^2 ,$$ a famous formula.
#> 
#> Diaz JE, López-Ibáñez M (2021). “Incorporating Decision-Maker's
#> Preferences into the Automatic Configuration of Bi-Objective
#> Optimisation Algorithms.” _European Journal of Operational Research_,
#> *289*(3), 1209-1222. doi:10.1016/j.ejor.2020.07.059
#> <https://doi.org/10.1016/j.ejor.2020.07.059>,
#> <https://doi.org/10.1016/j.ejor.2020.07.059>.
print(r, style = "html")
#> <p>Francois R (2014).
#> <em>bibtex: bibtex parser</em>.
#> R package version 0.4.0. 
#> </p>
#> 
#> <p>Boshnakov GN, Putman C (2020).
#> <em>rbibutils: Convert Between Bibliography Formats</em>.
#> <a href="https://CRAN.R-project.org/package=rbibutils">https://CRAN.R-project.org/package=rbibutils</a>. 
#> </p>
#> 
#> <p>Murdoch D (2010).
#> &ldquo;Parsing Rd files.&rdquo;
#> <a href="https://developer.r-project.org/parseRd.pdf">https://developer.r-project.org/parseRd.pdf</a>. 
#> </p>
#> 
#> <p>Wickham H, Hester J, Chang W (2018).
#> <em>devtools: Tools to Make Developing R Packages Easier</em>.
#> R package version 1.13.5, <a href="https://CRAN.R-project.org/package=devtools">https://CRAN.R-project.org/package=devtools</a>. 
#> </p>
#> 
#> <p>ZZZ A (2018).
#> &ldquo;A non-existent paper with a relation between several fundamental constants: $e^i\pi=-1$ in the title and showing that <code style="white-space: pre;">&#8288;a\slash b&#8288;</code> converts to  a\slash b.&rdquo;
#> <em>A non-existent journal with the formula $L_2$ in its name and \# \$ &amp; \_ \^ \~ an ampersand and other special characters preceded by a backslash in the bib file</em>.
#> This reference demonstrates that formulas in BibTeX files are OK. A formula in field 'note': $c^2 = a^2 + b^2$. If you need to, even display math is possible: $$ E = mc^2 ,$$ a famous formula. 
#> </p>
#> 
#> <p>Diaz JE, López-Ibáñez M (2021).
#> &ldquo;Incorporating Decision-Maker's Preferences into the Automatic Configuration of Bi-Objective Optimisation Algorithms.&rdquo;
#> <em>European Journal of Operational Research</em>, <b>289</b>(3), 1209&ndash;1222.
#> <a href="https://doi.org/10.1016/j.ejor.2020.07.059">doi:10.1016/j.ejor.2020.07.059</a>, <a href="https://doi.org/10.1016/j.ejor.2020.07.059">https://doi.org/10.1016/j.ejor.2020.07.059</a>. 
#> </p>

## Bib from base R packages are disabled in Rdpack v2 (notify the
## maintainer of Rdpack or raise an issue on github if you wish this back).
##
## b <- get_bibentries(package = "stats")
## print(b[[1]], style = "R")
## print(b[[1]], style = "citation")

## here the url field contains percent encoding
fn_url <- system.file("examples", "url_with_percents.bib", package = "Rdpack") 
u <- get_bibentries(bibfile = fn_url)

## the links produced by all of the following are valid
## and can be put in a browser
print(u, style = "html")
#> <p>Boshnakov GN (2018).
#> &ldquo;Dummy example of URL with percents.&rdquo;
#> <em>Example bibtex file</em>, <b>51</b>, 1&ndash;1.
#> <a href="https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib">https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib</a>. 
#> </p>
print(u, style = "bibtex")
#> @Article{urlWithPercents,
#>   author = {Georgi N. Boshnakov},
#>   title = {Dummy example of {URL} with percents},
#>   volume = {51},
#>   url = {https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib},
#>   journal = {Example bibtex file},
#>   year = {2018},
#>   pages = {1--1},
#> }
print(u, style = "R")
#> bibentry(bibtype = "Article",
#>          key = "urlWithPercents",
#>          author = person(given = c("Georgi", "N."),
#>                          family = "Boshnakov"),
#>          title = "Dummy example of {URL} with percents",
#>          volume = "51",
#>          url = "https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib",
#>          journal = "Example bibtex file",
#>          year = "2018",
#>          pages = "1--1")
print(u, style = "text")
#> Boshnakov GN (2018). “Dummy example of URL with percents.” _Example
#> bibtex file_, *51*, 1-1.
#> <https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib>.
print(u, style = "citation")
#> 
#> 
#> Boshnakov GN (2018). “Dummy example of URL with percents.” _Example
#> bibtex file_, *51*, 1-1.
#> <https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{urlWithPercents,
#>     author = {Georgi N. Boshnakov},
#>     title = {Dummy example of {URL} with percents},
#>     volume = {51},
#>     url = {https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib},
#>     journal = {Example bibtex file},
#>     year = {2018},
#>     pages = {1--1},
#>     truebibtype = {Article},
#>   }
#> 
#> 

## The link here contains escapes but when put in a LaTeX document
## which uses the JSS style it generates correct clickable link,
## (see Details section) 
print(u, style = "latex")
#> Boshnakov GN (2018).
#> ``Dummy example of URL with percents.''
#> \emph{Example bibtex file}, \bold{51}, 1--1.
#> \url{https://github.com/GeoBosh/zzfiles/blob/master/url\%20with\%20percents.bib}.

## here the journal field contains percent encoding
fn_other <- system.file("examples", "journal_with_percents.bib", package = "Rdpack") 
j <- get_bibentries(bibfile = fn_url)
print(j, style = "html")
#> <p>Boshnakov GN (2018).
#> &ldquo;Dummy example of URL with percents.&rdquo;
#> <em>Example bibtex file</em>, <b>51</b>, 1&ndash;1.
#> <a href="https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib">https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib</a>. 
#> </p>
print(j, style = "bibtex")
#> @Article{urlWithPercents,
#>   author = {Georgi N. Boshnakov},
#>   title = {Dummy example of {URL} with percents},
#>   volume = {51},
#>   url = {https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib},
#>   journal = {Example bibtex file},
#>   year = {2018},
#>   pages = {1--1},
#> }
print(j, style = "R")
#> bibentry(bibtype = "Article",
#>          key = "urlWithPercents",
#>          author = person(given = c("Georgi", "N."),
#>                          family = "Boshnakov"),
#>          title = "Dummy example of {URL} with percents",
#>          volume = "51",
#>          url = "https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib",
#>          journal = "Example bibtex file",
#>          year = "2018",
#>          pages = "1--1")
print(j, style = "text")
#> Boshnakov GN (2018). “Dummy example of URL with percents.” _Example
#> bibtex file_, *51*, 1-1.
#> <https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib>.
print(j, style = "citation")
#> 
#> 
#> Boshnakov GN (2018). “Dummy example of URL with percents.” _Example
#> bibtex file_, *51*, 1-1.
#> <https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Misc{urlWithPercents,
#>     author = {Georgi N. Boshnakov},
#>     title = {Dummy example of {URL} with percents},
#>     volume = {51},
#>     url = {https://github.com/GeoBosh/zzfiles/blob/master/url%20with%20percents.bib},
#>     journal = {Example bibtex file},
#>     year = {2018},
#>     pages = {1--1},
#>     truebibtype = {Article},
#>   }
#> 
#> 
      
print(j, style = "latex")
#> Boshnakov GN (2018).
#> ``Dummy example of URL with percents.''
#> \emph{Example bibtex file}, \bold{51}, 1--1.
#> \url{https://github.com/GeoBosh/zzfiles/blob/master/url\%20with\%20percents.bib}.
```
