# Insert references cited in packages

Insert references cited in packages.

## Usage

``` r
insert_all_ref(refs, style = "", empty_cited = FALSE)
```

## Arguments

- refs:

  a matrix specifying key-package pairs of the references to insert. Can
  also be a cached environment, see Details.

- style:

  a bibstyle, see Details.

- empty_cited:

  if `TRUE`, empty the list of currently cited items.

## Details

`insert_all_ref` is the workhorse behind several Rd macros for inclusion
of references in Rd documentation.

Argument `refs` is a two-column character matrix. The first column
specifies bibtex keys. To specify more than one key in a single element,
separate them by commas. The second column specifies the package in
which to look for the keys.

A key equal to "\*" requests all keys in the corresponding package.

`insert_all_ref` drops duplicated keys, collects the references, and
converts them to Rd textual representation for inclusion in Rd
documentation files.

`refs` can be a cached environment. This is for internal use and not
documented.

## Value

a character string containing a textual representation of the
references, suitable for inclusion in an Rd file

## References

Currently there are no citations on this help page. Nevetheless, I have
put `\insertAllCited{}` just after this paragraph to show the message
that it prints when there are no citations. This seems better than
printing nothing but it may be argued also that there should be a
warning as well.

There are no references for Rd macro `\insertAllCites` on this help
page.

## Author

Georgi N. Boshnakov

## Examples

``` r
## a reference from package Rdpack
cat(insert_all_ref(matrix(c("Rpack:bibtex", "Rdpack"), ncol = 2)), "\n")
#> Romain Francois (2014).
#> \emph{bibtex: bibtex parser}.
#> R package version 0.4.0. 

## more than one reference from package Rdpack, separate the keys with commas
cat(insert_all_ref(matrix(c("parseRd,Rpack:bibtex", "Rdpack"), ncol = 2)), "\n")
#> Romain Francois (2014).
#> \emph{bibtex: bibtex parser}.
#> R package version 0.4.0.\cr\cr Duncan Murdoch (2010).
#> \dQuote{Parsing Rd files.}
#> \url{https://developer.r-project.org/parseRd.pdf}. 

## all references from package Rdpack
cat(insert_all_ref(matrix(c("*", "Rdpack"), ncol = 2)), "\n")
#> Georgi
#> N. Boshnakov, Chris Putman (2020).
#> \emph{rbibutils: Convert Between Bibliography Formats}.
#> \url{https://CRAN.R-project.org/package=rbibutils}.\cr\cr Juan
#> Esteban Diaz, Manuel López-Ibáñez (2021).
#> \dQuote{Incorporating Decision-Maker's Preferences into the Automatic Configuration of Bi-Objective Optimisation Algorithms.}
#> \emph{European Journal of Operational Research}, \bold{289}(3), 1209--1222.
#> \doi{10.1016/j.ejor.2020.07.059}.\cr\cr Romain Francois (2014).
#> \emph{bibtex: bibtex parser}.
#> R package version 0.4.0.\cr\cr Duncan Murdoch (2010).
#> \dQuote{Parsing Rd files.}
#> \url{https://developer.r-project.org/parseRd.pdf}.\cr\cr Hadley Wickham, Jim Hester, Winston Chang (2018).
#> \emph{devtools: Tools to Make Developing R Packages Easier}.
#> R package version 1.13.5, \url{https://CRAN.R-project.org/package=devtools}.\cr\cr A. ZZZ (2018).
#> \dQuote{A relation between several fundamental constants: \eqn{e^{i\pi}=-1}; Also, a test that slash is fine: Something\ifelse{latex}{\out{\slash }}{/}Something.}
#> \emph{A non-existent journal with the formula \eqn{L_2} in its name & an ampersand which is preceded by a backslash in the bib file.}.
#> This reference does not exist. It is a test/demo that simple formulas in BibTeX files are OK. A formula in field 'note': \eqn{c^2 = a^2 + b^2}. 

## all references from package Rdpack and rbibutils
m <- matrix(c("*", "Rdpack",  "*", "rbibutils"), ncol = 2, byrow = TRUE)
cat(insert_all_ref(m), "\n")
#> Georgi
#> N. Boshnakov (2020).
#> \dQuote{Rdpack: Update and Manipulate Rd Documentation Objects.}
#> \doi{10.5281/zenodo.3925612}, R package version 2.0.0.\cr\cr Georgi
#> N. Boshnakov, Chris Putman (2020).
#> \emph{rbibutils: Convert Between Bibliography Formats}.
#> \url{https://CRAN.R-project.org/package=rbibutils}.\cr\cr Juan
#> Esteban Diaz, Manuel López-Ibáñez (2021).
#> \dQuote{Incorporating Decision-Maker's Preferences into the Automatic Configuration of Bi-Objective Optimisation Algorithms.}
#> \emph{European Journal of Operational Research}, \bold{289}(3), 1209--1222.
#> \doi{10.1016/j.ejor.2020.07.059}.\cr\cr Damiano Fantini (2019).
#> \dQuote{easyPubMed: Search and Retrieve Scientific Publication Records from PubMed.}
#> R package version 2.13, \url{https://CRAN.R-project.org/package=easyPubMed}.\cr\cr Romain Francois (2014).
#> \emph{bibtex: bibtex parser}.
#> R package version 0.4.0.\cr\cr Romain Francois (2014).
#> \emph{bibtex: bibtex parser}.
#> R package version 0.4.0.\cr\cr Mathew
#> William McLean (2017).
#> \dQuote{RefManageR: Import and Manage BibTeX and BibLaTeX References in R.}
#> \emph{The Journal of Open Source Software}.
#> \doi{10.21105/joss.00338}.\cr\cr Duncan Murdoch (2010).
#> \dQuote{Parsing Rd files.}
#> \url{https://developer.r-project.org/parseRd.pdf}.\cr\cr Chris Putnam (2020).
#> \dQuote{Library bibutils, version 6.10.}
#> \url{https://sourceforge.net/projects/bibutils/}.\cr\cr Hadley Wickham, Jim Hester, Winston Chang (2018).
#> \emph{devtools: Tools to Make Developing R Packages Easier}.
#> R package version 1.13.5, \url{https://CRAN.R-project.org/package=devtools}.\cr\cr A. ZZZ (2018).
#> \dQuote{A relation between several fundamental constants: \eqn{e^{i\pi}=-1}; Also, a test that slash is fine: Something\ifelse{latex}{\out{\slash }}{/}Something.}
#> \emph{A non-existent journal with the formula \eqn{L_2} in its name & an ampersand which is preceded by a backslash in the bib file.}.
#> This reference does not exist. It is a test/demo that simple formulas in BibTeX files are OK. A formula in field 'note': \eqn{c^2 = a^2 + b^2}. 
```
