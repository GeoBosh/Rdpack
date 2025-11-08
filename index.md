# Table of Contents

Rdpack provides functions for manipulation of R documentation objects,
including functions
[`reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
and
[`ereprompt()`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
for updating existing Rd documentation for functions, methods and
classes; Rd macros for citations and import of references from `bibtex`
files for use in `Rd` files and `roxygen2` comments (`\insertRef`,
`\insertCite`, `\insertAllCited`); Rd macros for evaluating and
inserting snippets of R code and the results of its evaluation
(`\printExample`) or creating graphics on the fly (`\insertFig`); and
many functions for manipulation of references and Rd files.

1.  [Installing Rdpack](#org8a647c9)
2.  [Inserting Bibtex references and citations](#org4e77937)
    1.  [Preparation](#org766760b)
    2.  [Inserting references](#orgf0b8e07)
    3.  [Inserting citations](#orgbff7de3)
    4.  [Changing the style of references](#orge63a829)
    5.  [Troubleshooting](#org35439dc)
        1.  [A puzzling message in devtools development
            mode](#orgc0ddf98)
        2.  [Typical errors](#orge94900c)
    6.  [Latex markup in BibTeX entries](#org7490870)
    7.  [Encoding of file REFERENCES.bib](#org5fd3efd)
3.  [Viewing Rd files](#orgb41e139)
4.  [Using Rdpack::reprompt()](#orgcdf91db)
    1.  [What it does](#orge44c86a)
    2.  [Reprompt and open in an editor](#org975854d)
5.  [Inserting evaluated examples](#orgb77362a)
    1.  [Evaluating the examples in section Examples](#org3bee793)
6.  [Inserting figures/graphs/plots](#org9b84bd5)

# Installing Rdpack

Install the [latest stable
version](https://cran.r-project.org/package=Rdpack) from CRAN:

``` R
install.packages("Rdpack")
```

You can also install the [development
version](https://github.com/GeoBosh/Rdpack) of `Rdpack` from Github:

``` R
library(devtools)
install_github("GeoBosh/Rdpack")
```

# Inserting Bibtex references and citations

The simplest way to insert Bibtex references is with the Rd macro
`\insertRef`. Just put `\insertRef{key}{package}` in the documentation
to insert item with key `key` from file `REFERENCES.bib` in your package
`package`. Alternatively, use one or more `\insertCite{key}{package}`
commands to cite works from `REFERENCES.bib`, then issue a single
`\insertAllCited{}` directive to produce a list of all cited references.
For this to work the `DESCRIPTION` file of the package needs to be
amended, see below the full details.

## Preparation

To prepare a package for importing BibTeX references it is necessary to
tell the package management tools that package Rdpack and its Rd macros
are needed. The references should be put in file `inst/REFERENCES.bib`.
These steps are enumerated below in somewhat more detail, see also the
vignette
[`Inserting_bibtex_references`](https://cran.r-project.org/package=Rdpack).

1.  Add the following lines to file “DESCRIPTION”:

    ``` R
    Imports: Rdpack
    RdMacros: Rdpack
    ```

    Make sure the capitalisation of `RdMacros:` is as shown. If the
    field `RdMacros:` is already present, add “Rdpack” to the list on
    that line. Similarly for field “Imports:”.

2.  Add the following line to file “NAMESPACE”:

    ``` R
    importFrom(Rdpack,reprompt)
    ```

    The equivalent line for `roxygen2` is

    ``` R
    #' @importFrom Rdpack reprompt
    ```

3.  Create file `REFERENCES.bib` in subdirectory `inst/` of your package
    and put the BibTeX references in it.

## Inserting references

Once the steps outlined above are done, references can be inserted in
the documentation as

``` R
\insertRef{key}{package}
```

where `key` is the bibtex key of the reference and `package` is your
package. This works in `Rd` files and in `roxygen` documentation chunks.

Usually references are put in section `references`. In an `Rd` file this
might look something like:

``` R
\references{
\insertRef{Rdpack:bibtex}{Rdpack}

\insertRef{R}{bibtex}
}
```

The equivalent `roxygen2` documentation chunk would be:

``` R
#' @references
#' \insertRef{Rpackage:rbibutils}{Rdpack}
#'
#' \insertRef{R}{bibtex}
```

The first line above inserts the reference with key `Rpackage:rbibutils`
in Rdpack’s REFERENCES.bib. The second line inserts the reference
labeled `R` in file REFERENCES.bib from package `bibtex`.

The example above demonstrates that references from other packages can
be inserted (in this case `bibtex`), as well. This is strongly
discouraged for released versions but is convenient during development.
One relatively safe use is when the other package is also yours - this
allows authors of multiple packages to not copy the same refences to
each of their own packages.

For further details see the vignette
[`Inserting_bibtex_references`](https://cran.r-project.org/package=Rdpack)
or open it from `R`:

``` R
vignette("Inserting_bibtex_references", package = "Rdpack")
```

(The latest version of the vignette is at
[`Inserting_bibtex_references (development version on github)`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_bibtex_references.pdf).)

## Inserting citations

Additional Rd macros are available for citations. They also can be used
in both Rd and roxygen2 documentation.

`\insertCite{key}{package}` cites `key` and records it for use by
`\insertAllCited` and `\insertCited`, see below. `key` can contain more
keys separated by commas.

`\insertCite{parseRd,Rpackage:rbibutils}{Rdpack}` produces (Murdoch
2010; Boshnakov and Putman 2020) and
`\insertCite{Rpackage:rbibutils}{Rdpack}` gives (Boshnakov and Putman
2020).

By default the citations are parenthesised:
`\insertCite{parseRd}{Rdpack}` produces (Murdoch 2010). To get textual
citations, like Murdoch (2010), put the string `;textual` at the end of
the key. The references in the last two sentences would be produced with
`\insertCite{parseRd}{Rdpack}` and
`\insertCite{parseRd;textual}{Rdpack}`, respectively. This also works
with several citations, e.g.

`\insertCite{parseRd,Rpackage:rbibutils;textual}{Rdpack}` produces:
Murdoch (2010); Boshnakov and Putman (2020).

The macro `\insertNoCite{key}{package}` records one or more references
for `\insertAllCited` but does not cite it. Setting `key` to `*` will
include all references from the specified package. For example,
`\insertNoCite{R}{bibtex}` and `\insertNoCite{*}{utils}` record the
specified references for inclusion by `\insertAllCited`.

`\insertAllCited` inserts all references cited with `\insertCite` or
`\insertNoCite`. Putting this macro in the references section will keep
it up to date automatically. The Rd section may look something like:

``` R
\insertAllCited{}
```

or, in roxygen2, the references chunk might look like this:

``` R
#' @references
#'   \insertAllCited{}
```

Don’t align the backslash with the second ‘e’ of `@references`, since
roxygen2 may interpret it as verbatim text, not macro.

`\insertCited{}` works like `\insertAllCited` but empties the reference
list after finishing its work. This means that the second and subsequent
`\insertCited` in the same help page will list only citations done since
the preceding `\insertCited`. Prompted by issue 27 on github to allow
separate reference lists for each method and the class in R6
documentation.

To mix the citations with other text, such as \`\`see also’’ and
\`\`chapter 3’’, write the list of keys as a free text, starting it with
the symbol `@` and prefixing each key with it. The `@` symbol will not
appear in the output. For example, the following code

``` R
\insertCite{@see also @parseRd and @Rpackage:rbibutils}{Rdpack}
\insertCite{@see also @parseRd; @Rpackage:rbibutils}{Rdpack}
\insertCite{@see also @parseRd and @Rpackage:rbibutils;textual}{Rdpack}
```

produces:

(see also Murdoch 2010 and Boshnakov and Putman 2020)

(see also Murdoch 2010; Boshnakov and Putman 2020)

see also Murdoch (2010) and Boshnakov and Putman (2020)

With the parenthesised citations, if you need markup for the text before
or after the citations, say `see also` in italic, put
`;nobrackets`^([1](#fn.1)) at the end of the first argument of the Rd
macro, take out the part containing markup, and put the parentheses were
suitable. For example,

``` R
(\emph{see also} \insertCite{@@parseRd and @Rpackage:rbibutils;nobrackets}{Rdpack})
```

(in markdown, use `_see also_` in place of `\emph{see also})`. This
gives:

(*see also* Murdoch 2010 and Boshnakov and Putman 2020)

—

`\insertCiteOnly{key}{package}` is as `\insertCite` but does not include
the key in the list of references for `\insertAllCited`.

## Changing the style of references

Bibliography styles for lists of references are supported from *Rdpack
(\>= 0.8)*. Currently the only alternative offered is to use long names
(Georgi N. Boshnakov) in place of the default style (Boshnakov GN). More
comprehensive alternatives can be included if needed or requested.

To cause all lists of references produced by `\insertAllCited` in a
package to appear with full names, add `.onLoad()` function to your
package. If you don’t have `.onLoad()`, just copy the following
definition:

``` R
.onLoad <- function(lib, pkg){
    Rdpack::Rdpack_bibstyles(package = pkg, authors = "LongNames")
    invisible(NULL)
}
```

If you already have `.onLoad()`, add the line containing the
[`Rdpack::Rdpack_bibstyles`](https://geobosh.github.io/Rdpack/reference/Rdpack_bibstyles.md)
call to it.

After installling/reloading your package the lists of references should
appear with long author names. “Rdpack” itself now uses this style.

## Troubleshooting

### A puzzling message in devtools development mode

The described procedure works transparently in `roxygen2` chunks and
with Hadley Wickham’s package `devtools`. Packages are built and
installed properly with the `devtools` commands and the references are
processed as expected.

Currently (2017-08-04) if you run help commands `?xxx` for functions
from the package you are working on *in developement mode* and their
help pages contain references, you may encounter some puzzling warning
messages, something like:

``` R
1: In tools::parse_Rd(path) :
  ~/mypackage/man/abcde.Rd: 67: unknown macro '\insertRef'
```

These warnings are harmless and can be ignored — the help pages are
built properly and no warnings appear outside *developer’s mode*,
e.g. in a separate R session^([2](#fn.2)). Even better, use the function
[`viewRd()`](https://geobosh.github.io/Rdpack/reference/viewRd.md)
described below to view the required help file.

### Typical errors

The functions underlying the processing of references and citations
intercept errors, such as missing BibTeX labels or badly formed items in
REFERENCES.bib, and issue informative warnings during the building and
installation of the package, so that the developer is alerted but the
package can still be built and installed. In these cases the functions
usually insert a suitable text in the documentation, as well. If you
encounter a situation contradicting this description, it is probably a
bug — please report it (but check first for the typical errors listed
below).

A non-decipherable error message is probably caused by one of the
following typical errors:

- misspelled `RdMacros:` field in file DESCRIPTION. The safest way to
  avoid this is to copy it from the DESCRIPTION file of a working
  package.

- omitted second argument of a reference or citation macro. Most of
  these macros have the package name as a second argument.

These errors occur during parsing of the Rd files, before the control is
passed to the `Rdpack`’s macros.

## Latex markup in BibTeX entries

In principle, BibTeX entries may contain arbitrary Latex markup, while
the Rd format supports only a subset. As a consequence, some BibTeX
entries may need some editing when included in
REFERENCES.bib^([3](#fn.3)). Only do this for entries that do not render
properly or cause errors, since most of the time this should not be
necessary.

If mathematics doesn’t render properly replace the Latex dollar syntax
with Rd’s `\eqn`, e.g. `$x^2$` with `\eqn{x^2}`. This should not be
needed for versions of Rdpack 0.8-4 or later.

Some Latex macros may have to be removed or replaced with suitable Rd
markup. Again, do this only if they cause problems, since some are
supported, e.g. `\doi`.

See also the overview help page,
[`help("Rdpack-package")`](https://geobosh.github.io/Rdpack/reference/Rdpack-package.md),
of package `"Rdpack"`. Among other things, it contains some dummy
references which illustrate the above.

## Encoding of file REFERENCES.bib

If a package has a declared encoding (in file `DESCRIPTION`),
`REFERENCES.bib` is read-in with that encoding^([4](#fn.4)). Otherwise,
the encoding of `REFERENCES.bib` is assumed to be UTF-8 (which includes
ASCII as a subset).

Note that BibTeX entries downloaded from online databases and similar
sources may contain unexpected characters in other encodings,
e.g. ‘latin1’. In such cases the check tools in R-devel (since about
2018-10-01) may give warnings like:

``` R
prepare_Rd: input string 1 is invalid in this locale
```

To resolve this, convert the file to the declared encoding or UTF-8.
Alternatively, replace the offending symbols with their classic
TeX/LaTeX equivalents (which are ASCII). Non-ASCII symbols in BibTeX
entries obtained from online databases are often in fields like
“Abstract”, which are normally not included in lists of references and
can be deleted from REFERENCES.bib.

One way to check for non-ASCII symbols in a file is
[`tools::showNonASCIIfile()`](https://rdrr.io/r/tools/showNonASCII.html).

Internally, LaTeX sequences standing for accented Latin characters, such
as `\'e` and `\"o`, are converted to UTF-8. So, even if the file
REFERENCES.bib is pure ASCII, it may implicitly give raise to non-ASCII
characters. This may cause R’s checking tools to complain about
non-ASCII characters even after it has been verified that there are
none. If this happens, add the encoding declaration to file
DESCRIPTION^([5](#fn.5)):

``` R
Encoding: UTF-8
```

Needless to say, make sure that there are really no characters from
encodings like ‘latin1’.

# Viewing Rd files

The function
[`viewRd()`](https://geobosh.github.io/Rdpack/reference/viewRd.md) can
be used to view Rd files in the source directory of a
package^([6](#fn.6)). A typical user call would look something like:

``` R
Rdpack::viewRd("./man/filename.Rd")
```

The requested help page is shown in the default format for the current R
session (taken from `getOption("help_type")`). To request a specific
format set `type` to `"html"` or `"text"`, as in:

``` R
Rdpack::viewRd("./man/filename.Rd", type = "html") # open in a browser
Rdpack::viewRd("./man/filename.Rd", type = "text") # text
```

[`viewRd()`](https://geobosh.github.io/Rdpack/reference/viewRd.md)
renders references and citations correctly, since it processes Rd
macros.

Users of ‘devtools’ can use `viewRd` in place of
[`help()`](https://rdrr.io/r/utils/help.html) to view rendered Rd
sources in development mode. This should work also in development mode
on any platform (e.g. RStudio, Emacs/ESS, Rgui)^([7](#fn.7)).

# Using Rdpack::reprompt()

## What it does

[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
updates `Rd` documentation. In the most common case when it is called on
an `Rd` file, it updates the documentation of all functions, methods and
classes documented in the file. For functions this includes updating the
usage section, adding missing aliases and `\item`’s for arguments not
described yet. For methods and classes entries for new methods and slots
are updated in a similar way. See the documentation for details.

[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
can also be invoked on an object or the name of an object, just as
[`utils::prompt`](https://rdrr.io/r/utils/prompt.html). In that case it
checks for installed documentation for the object and works on it if
found. Otherwise it creates an `Rd` file with initial content similar to
the one generated by
[`utils::prompt`](https://rdrr.io/r/utils/prompt.html) but modified so
that the package can be built.

If a new function, say `newfun` is to be documented in an existing Rd
file, just add `newfun()` to the usage section in the file and call
[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
to insert the correct usage statement, add an alias, and add items for
any new arguments. Put quotes around the function name if it is
non-syntactic. For replacement functions (functions with names ending in
`<-`)
[`reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
will insert the proper usage statement. For example, if the signature of
`xxx<-` is `(x, ..., value)`, then both, `"xxx<-"()` and
`xxx() <- value` will be replaced by `xxx(x, ...) <- value`.

[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
**does not remove** anything that has become obsolete but it alerts the
user to remove aliases, methods, and descriptions of arguments that have
been removed.

## Reprompt and open in an editor

To open the
[`reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)-ed
file, argument `edit` can be used. For this to work, `options("editor")`
needs to be set suitably but it usually is. If `edit = TRUE`, then
[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
will open the Rd file in an editor. For more convenient access to this
feature, use
[`Rdpack::ereprompt()`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
(edit reprompt), which calls
[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
with `edit = TRUE` and sets the output filename to be the same as the
input filename.

In RStudio,
[`reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
can be invoked on the `Rd` file being edited or the selected name of an
object in a source code file using RStudio add-in `Repropmpt`
(contributed by Duncan Murdoch). Obviously, this makes sense only for Rd
files not generated by `roxygen2`.

In Emacs/ESS there are various ways to use
[`Rdpack::reprompt()`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
and
[`Rdpack::ereprompt()`](https://geobosh.github.io/Rdpack/reference/ereprompt.md).
If `options("editor")` is set to `emacsclient`,
[`Rdpack::ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
is one option. It can also be assigned to a key (wrapped in Elisp code),
for example to be invoked on the currently edited file. Such a function
and example key binding can be found at
[georgisemacs](https://github.com/GeoBosh/georgisemacs).

# Inserting evaluated examples

`Rdpack` provides a macro that takes a chunk of R code, evaluates it,
and includes both the code and the results in the rendered
documentation. The layout is similar to that in the R console but the
code is not prefixed with anything and the output is prefixed with
comment symbols. For example,

``` R
\printExample{2+2; a <- 2*3; a}
```

gives

``` R
2 + 2
##: 4
a <- 2 * 3
a
##: 6
```

The help page of
[`?Rdpack::promptUsage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
contains a number of examples created with `\printExample`. The
corresponding Rd file can be obtained from the package tarball or from
<https://github.com/GeoBosh/Rdpack/blob/master/man/promptUsage.Rd>.

Vignette
[`Inserting_figures_and_evaluated_examples`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_figures_and_evaluated_examples.pdf)
gives further details.

## Evaluating the examples in section Examples

The macro `\runExamples` can be used as a replacement of section
`examples`. For example, if the following code is put at the top level
in an Rd file (i.e. not in a section):

``` R
\runExamples{2+2; a <- 2*3; a}
```

then it will be evaluated and replaced by a normal section examples:

``` R
\examples{
2 + 2
##: 4
a <- 2 * 3
a
##: 6
}
```

This generated examples section is processed by the standard R tools
(almost) as if it was there from the outset. In particular, the examples
are run by the R’s quality control tools and tangled along with examples
in other documentation files^([8](#fn.8)). A small example package using
this feature is at
[runExamplesCheck](https://github.com/GeoBosh/reprexes/tree/master/runExamplesCheck).

# Inserting figures/graphs/plots

Figures can be inserted with the help of the standard Rd markup command
`\figure`. To generate figures on the fly, package `"Rdpack"` provides
the Rd macro `\insertFig` which takes a snipped of R code, evaluates it
and inserts the plot produced by it (using `\figure`). `\insertFig`
takes three arguments: a filename, the package name and the code to
evaluate to produce the figure. For example,

``` R
\insertFig{cars.png}{mypackage}{x <- cars$speed; y <- cars$dist; plot(x,y)}
```

will evaluate the code, save the graph in file `"man/figures/cars.png"`
subdirectory of package `"mypackage"`, and include the figure using
`\figure`.

See vignette
[`Inserting_figures_and_evaluated_examples`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_figures_and_evaluated_examples.pdf)
for more details.

# Footnotes

^([1](#fnr.1)) From `Rdpack (> 2.1.3)` (prompted by Martin R. Smith,
issue \#23).

^([2](#fnr.2)) If you care, here is what happens. These warnings appear
because `devtools` reroutes the help command to process the developer’s
Rd sources (rather than the documentation in the installed directory)
but doesn’t tell `parse_Rd` where to look for additional macros. Indeed,
the message above shows that the error is in processing a source Rd file
in the development directory of the package and that the call to
`parse_Rd` specifies only the file.

^([3](#fnr.3)) Thanks to Michael Dewey for suggesting the discussion of
this.

^([4](#fnr.4)) From `Rdpack (>=0.9-1)` The issue of not handling the
encoding was raised by Professor Brian Ripley.

^([5](#fnr.5)) Admittedly, this is not ideal since the user should not
need to care how things are processed internally but I haven’t
pinpointed the exact cause for this.

^([6](#fnr.6)) From `Rdpack (>= 0.4-23)`.

^([7](#fnr.7)) In recent versions of Rstudio this function is no longer
needed, since `?fun` now handles the macros.

^([8](#fnr.8)) In versions of `R` before `3.6.0` the macro
`\runExamples` may cause `R CMD check` to give a warning warning about
unknown `\Sexpr` section at top level.
