# Insert bibtex references in Rd and roxygen2 documentation

Package Rdpack provides Rd macros for inserting references and citations
from bibtex files into R documentation. Function `insert_ref()` is the
workhorse behind this mechanism. The description given on this page
should be sufficient, for more details see the vignette.

## Usage

``` r
insert_ref(key, package = NULL, ..., cached_env = NULL)
```

## Arguments

- key:

  the bibtex key of the reference, a character string.

- package:

  the package in which to look for the bibtex file.

- ...:

  further arguments to pass on to
  [`get_bibentries()`](https://geobosh.github.io/Rdpack/reference/get_bibentries.md).
  The only one of interest to users is `bibfile`, whose default is
  "REFERENCES.bib", see
  [`get_bibentries`](https://geobosh.github.io/Rdpack/reference/get_bibentries.md).

- cached_env:

  environment, used to avoid repeatedly passing the bib file from
  scratch, mainly used by the Rd macros.

## Details

`insert_ref` extracts a bibliograhic reference from a bibtex file,
converts it to Rd format and returns a single string with embedded
newline characters. It is the workhorse in the provided mechanism but
most users do not even need to know about `insert_ref`.

Package Rdpack provides several Rd macros for inserting references and
citations in the documentation of a package. All macros work in both,
manually written Rd files and in roxygen2 documentation chunks. The
macros look for references in file `"REFERENCES.bib"` in the root of the
installation directory of the package. When a package is in development
mode under devtools, `"inst/REFERENCES.bib"` in the development
directory of the package is checked first. See also
[`get_bibentries`](https://geobosh.github.io/Rdpack/reference/get_bibentries.md)
but note that while direct calls to `insert_ref()` can specify a
different file, the filename and the places where it is looked for are
fixed for the Rd macros.

The description below assumes that Rdpack has been added to file
DESCRIPTION, as described in
[`Rdpack-package`](https://geobosh.github.io/Rdpack/reference/Rdpack-package.md)
and vignette `"Inserting_bibtex_references"`. The Rd macros are put in
the text of documentation sources (‘Rd’ files or ‘roxygen2’ chunks).

### Rd macro insertRef

`\insertRef{key}{package}` inserts the reference with bibtex key `key`
from file `"REFERENCES.bib"` in package `package`. Argument ‘package’
can be any installed R package, not necessarily the one of the
documentation object, as long as it contains file `"REFERENCES.bib"` in
the root of its installation directory. The references are partially
processed when the package is built.

References inserted with `\insertRef` appear in the place where the
macro is put, usually in a dedicated references section (`\references`
in Rd files, `@references` in roxygen chunks).

For example, section ‘References’ of this help page shows (among other
things)) the rendered results of the following lines in the Rd source
file:

            \insertRef{Rpackage:rbibutils}{Rdpack}

            \insertRef{parseRd}{Rdpack}

            \insertRef{bibutils6.10}{rbibutils}
        

A roxygen2 documentation chunk might look like this:

            #' @references
            #' \insertRef{Rpackage:rbibutils}{Rdpack}
            #'
            #' \insertRef{parseRd}{Rdpack}
            #'
            #' \insertRef{bibutils6.10}{rbibutils}
        

The first reference has label `Rpackage:rbibutils` and is taken from
file `"REFERENCES.bib"` in package Rdpack. The third reference is from
the file `"REFERENCES.bib"` in package rbibutils.

For more details see vignette `"Inserting_bibtex_references"`.

### Rd macro insertCite

`\insertCite{key}{package}` cites the key and records it for use by
`\insertAllCited`, see below. `key` can contain more keys separated by
commas.

|                                                   |                                           |
|---------------------------------------------------|-------------------------------------------|
| `\insertCite{parseRd,Rpackage:rbibutils}{Rdpack}` | (Murdoch 2010; Boshnakov and Putman 2020) |
| `\insertCite{Rpackage:rbibutils}{Rdpack}`         | (Boshnakov and Putman 2020)               |
| `\insertCite{bibutils6.10}{rbibutils}`            | (Putnam 2020)                             |

By default the citations are parenthesised (Murdoch 2010) . To get
textual citations, like Murdoch (2010) , put the string `;textual` at
the end of the key. The references in the last two sentences were
produced with `\insertCite{parseRd}{Rdpack}` and
`\insertCite{parseRd;textual}{Rdpack}`, respectively. This also works
with several citations, e.g.  
`\insertCite{parseRd,Rpackage:rbibutils;textual}{Rdpack}` produces:
Murdoch (2010); Boshnakov and Putman (2020) .

To mix the citations with other text, such as ‘see also’ and ‘chapter
3’, write the list of keys as free text, starting it with the symbol `@`
and prefixing each key with it. The `@` symbol will not appear in the
output. For example, the following code

            \insertCite{@see also @parseRd and @Rpackage:rbibutils}{Rdpack},

            \insertCite{@see also @parseRd; @Rpackage:rbibutils}{Rdpack},

            \insertCite{@see also @parseRd and @Rpackage:rbibutils;textual}{Rdpack}.
        

produces:

|                                                           |
|-----------------------------------------------------------|
| (see also Murdoch 2010 and Boshnakov and Putman 2020) ,   |
| (see also Murdoch 2010; Boshnakov and Putman 2020) ,      |
| see also Murdoch (2010) and Boshnakov and Putman (2020) . |

In the parenthesised form, adding `;nobrackets` at the end of the list
of keys causes the enclosing parentheses to be dropped. This is useful
if you wish to use markup for the text surrounding the references. For
example,

            (\emph{see also}  \insertCite{@@parseRd; @Rpackage:rbibutils;nobrackets}{Rdpack}).
          

gives: (*see also* Murdoch 2010; Boshnakov and Putman 2020 ). Without
‘`;nobrackets`’ the result would be (*see also* (Murdoch 2010; Boshnakov
and Putman 2020) ).

### Rd macro insertNoCite

The macro `\insertNoCite{key}{package}` records one or more references
for `\insertAllCited` but does not cite it. Setting `key` to `*` will
include all references from the specified package. For example,
`\insertNoCite{parseRd}{Rdpack}` and `\insertNoCite{*}{rbibutils}`
record the specified references for inclusion by `\insertAllCited`.

### Rd macro insertAllCited

`\insertAllCited` inserts all references cited with `\insertCite` and
`\insertNoCite`. Putting this macro in the references section will keep
the references up to date automatically. The Rd section may look
something like:

           \references{
             \insertAllCited{}
           }
        

or in roxygen2, the references chunk might look like this:

           #' @references
           #'   \insertAllCited{}
        

### Rd macro insertCiteOnly

`\insertCiteOnly{key}{package}` is as `\insertCite` but does not include
the key in the list of references for `\insertAllCited`.

## Value

for `insert_ref`, a character string

## References

For illustrative purposes there are two sets of citations below The
first set of references is obtained with `\insertRef` for each
reference:

Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.

Georgi N. Boshnakov, Chris Putman (2020). *rbibutils: Convert Between
Bibliography Formats*. <https://CRAN.R-project.org/package=rbibutils>.

Putnam C (2020). “Library bibutils, version 6.10.”
<https://sourceforge.net/projects/bibutils/>.

—-

The following references are obtained with a single `\insertAllCited{}`.
The references are sorted automatically by the surnames of the authors:

Georgi N. Boshnakov, Chris Putman (2020). *rbibutils: Convert Between
Bibliography Formats*. <https://CRAN.R-project.org/package=rbibutils>.  
  
Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.  
  
Chris Putnam (2020). “Library bibutils, version 6.10.”
<https://sourceforge.net/projects/bibutils/>.

## Author

Georgi N. Boshnakov

## See also

[`Rdpack-package`](https://geobosh.github.io/Rdpack/reference/Rdpack-package.md)
for overview,

`vignette("Inserting_bibtex_references", package = "Rdpack")` for
further details on the citation macros

[`insert_citeOnly`](https://geobosh.github.io/Rdpack/reference/insert_citeOnly.md)
for the function generating citations

## Examples

``` r
cat(insert_ref("Rpackage:rbibutils", "Rdpack"), "\n")
#> Georgi
#> N. Boshnakov, Chris Putman (2020).
#> \emph{rbibutils: Convert Between Bibliography Formats}.
#> \url{https://CRAN.R-project.org/package=rbibutils}. 
```
