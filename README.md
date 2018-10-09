[![CRANStatusBadge](http://www.r-pkg.org/badges/version/Rdpack)](https://cran.r-project.org/package=Rdpack)
[![rpackages.io rank](http://www.rpackages.io/badge/Rdpack.svg)](http://www.rpackages.io/package/Rdpack)

Rdpack provides functions for manipulation of R documentation objects, including
functions `reprompt()` and `ereprompt()` for updating existing Rd documentation
for functions, methods and classes; Rd macros for citations and import of
references from `bibtex` files for use in `Rd` files and `roxygen2` comments
(`\insertRef`, `\insertCite`); Rd macros for evaluating and inserting snippets
of R code and the results of its evaluation (`\printExample`) or creating
graphics on the fly (`\insertFig`); and many functions for manipulation of
references and Rd files.


# Table of Contents

1.  [Installing Rdpack](#org2e20466)
2.  [Inserting Bibtex references and citations](#org93ae1c3)
    1.  [Preparation](#org4b80cba)
    2.  [Inserting references](#org73a8538)
    3.  [Inserting citations](#orgb10cfbe)
    4.  [Changing the style of references](#orgf71c82f)
    5.  [Troubleshooting](#org4e737e6)
        1.  [A puzzling message in devtools development mode](#org1405095)
        2.  [Typical errors](#org52dc53a)
    6.  [Latex markup in BibTeX entries](#orged9746f)
    7.  [Encoding of file REFERENCES.bib](#org2fb6841)
3.  [Viewing Rd files](#org34a78b5)
4.  [Using Rdpack::reprompt()](#orgfd7af49)
    1.  [What it does](#org6ed52fe)
    2.  [Reprompt and open in an editor](#orga8f3dc6)
5.  [Inserting evaluated examples](#orgf979734)
6.  [Inserting figures/graphs/plots](#orgaf22e59)
7.  [Versions of Rdpack](#orgae9fd91)


<a id="org2e20466"></a>

# Installing Rdpack

Install the  [latest stable version](https://cran.r-project.org/package=Rdpack) from CRAN:

    install_packages("Rdpack")

You can also install the [development version](https://github.com/GeoBosh/Rdpack) of `Rdpack` from Github:

    library(devtools)
    install_github("GeoBosh/Rdpack")


<a id="org93ae1c3"></a>

# Inserting Bibtex references and citations

The simplest way to insert Bibtex references is with the Rd macro `\insertRef`.
Just put `\insertRef{key}{package}` in the documentation to insert item with key
`key` from file `REFERENCES.bib` in your package `package`. Alternatively, use
one or more `\insertCite{key}{package}` commands to cite works from
`REFERENCES.bib`, then issue a single `\insertAllCited{}` directive to produce a
list of all cited references. For this to work
the `DESCRIPTION` file of the package needs to be amended, see below the full
details. 


<a id="org4b80cba"></a>

## Preparation

To prepare a package for importing BibTeX references it is necessary to tell the
package management tools that package Rdpack and its Rd macros are needed. The
references should be put in file `inst/REFERENCES.bib`.  These steps are
enumerated below in somewhat more detail, see also the vignette
[`Inserting_bibtex_references`](https://cran.r-project.org/package=Rdpack).

1.  Add the following lines to  file "DESCRIPTION":
    
        Imports: Rdpack
        RdMacros: Rdpack
    
    Make sure the capitalisation of `RdMacros:` is as shown. If the field
    `RdMacros:` is already present, add "Rdpack" to the list on that
    line. Similarly for field "Imports".

2.  Add the following line to file "NAMESPACE":
    
        importFrom(Rdpack,reprompt)
    
    The equivalent line for `roxygen2` is 
    
        #' @importFrom Rdpack reprompt

3.  Create file `REFERENCES.bib` in subdirectory `inst/` of your package and
    put the BibTeX references in it.


<a id="org73a8538"></a>

## Inserting references

Once the steps outlined above are done, references can be inserted in the
documentation as

    \insertRef{key}{package}

where `key` is the bibtex key of the reference and `package` is your package.
This works in `Rd` files and in `roxygen` documentation chunks.

Usually references are put in section `references`. In an `Rd` file this might look
something like:

    \references{
    \insertRef{Rdpack:bibtex}{Rdpack}
    
    \insertRef{R}{bibtex}
    }

The equivalent `roxygen2` documentation chunk would be:

    #' @references
    #' \insertRef{Rpack:bibtex}{Rdpack}
    #'
    #' \insertRef{R}{bibtex}

The first line above inserts the reference with key `Rpack:bibtex` in Rdpack's
REFERENCES.bib. The second line inserts the reference labeled `R` in file
REFERENCES.bib from package `bibtex`. 

The example above demonstrates that references from other packages can be
inserted (in this case `bibtex`), as well. This is strongly discouraged for
released versions but is convenient during development. One relatively safe use
is when the other package is also yours - this allows authors of multiple
packages to not copy the same refences to each of their own packages.

For further details see the vignette 
[`Inserting_bibtex_references`](https://cran.r-project.org/package=Rdpack)
or open it from `R`:

    vignette("Inserting_bibtex_references", package = "Rdpack")

(The latest version of the vignette is at
[`Inserting_bibtex_references (development version on github)`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_bibtex_references.pdf).)


<a id="orgb10cfbe"></a>

## Inserting citations

From version 0.6-1 of "Rdpack", additional Rd macros are available for
citations.  They can be used in both Rd and roxygen2 documentation.

`\insertCite{key}{package}` cites `key` and records it for use by
`\insertAllCited`, see below. `key` can contain more keys separated by commas.

`\insertCite{parseRd,Rpack:bibtex}{Rdpack}` produces 
(Murdoch 2010; Francois 2014)
and 
`\insertCite{Rpack:bibtex}{Rdpack}`         gives
(Francois 2014).

By default the citations are parenthesised: `\insertCite{parseRd}{Rdpack}` produces
(Murdoch 2010).  To get
textual citations, like 
Murdoch (2010), 
put the string `;textual` at the end of the key. The references in the last two sentences
would be produced with `\insertCite{parseRd}{Rdpack}` and
`\insertCite{parseRd;textual}{Rdpack}`, respectively.  This also works with several
citations, e.g.

`\insertCite{parseRd,Rpack:bibtex;textual}{Rdpack}` produces:
Murdoch (2010); Francois (2014).

The macro `\insertNoCite{key}{package}` records one or more
references for `\insertAllCited` but does not cite it. Setting
`key` to `*` will include all references from the
specified package. For example, 
`\insertNoCite{R}{bibtex}`  and  `\insertNoCite{*}{utils}`
record the specified references for inclusion by `\insertAllCited`. 

`\insertAllCited` inserts all references cited with
`\insertCite` or `\insertNoCite`. Putting this macro
in the references section will keep it up to date automatically. 
The Rd section may look something like:

    \insertAllCited{}

or, in roxygen2, the references chunk might look like this:

    #' @references
    #'     \insertAllCited{}

To mix the citations with other text, such as \`\`see also'' and \`\`chapter 3'',
write the list of keys as a free text, starting it with the symbol `@` and
prefixing each key with it.  The `@` symbol will not appear in the output. For
example, the following code

    \insertCite{@see also @parseRd and @Rpack:bibtex}{Rdpack}
    \insertCite{@see also @parseRd; @Rpack:bibtex}{Rdpack}
    \insertCite{@see also @parseRd and @Rpack:bibtex;textual}{Rdpack}

produces:

(see also Murdoch 2010 and Francois 2014) 

(see also Murdoch 2010; Francois 2014) 

see also Murdoch (2010) and Francois (2014)

&#x2014;

`\insertCiteOnly{key}{package}` is as `\insertCite` but does not include the key
in the list of references for `\insertAllCited`.


<a id="orgf71c82f"></a>

## Changing the style of references

Bibliography styles for lists of references are supported from <span class="underline">Rdpack (>=
0.8)</span>. Currently the only alternative offered is to use long names (Georgi
N. Boshnakov) in place of the default style (Boshnakov GN). More comprehensive
alternatives can be included if needed or requested.

To cause all lists of references produced by `\insertAllCited` in a package to appear with
full names, add `.onLoad()` function to your package. If you don't have `.onLoad()`, just
copy the following definition: 

    .onLoad <- function(lib, pkg){
        Rdpack::Rdpack_bibstyles(package = pkg, authors = "LongNames")
        invisible(NULL)
    }

If you already have `.onLoad()`, add the line containing the
`Rdpack::Rdpack_bibstyles` call to it.

After installling/reloading your package the lists of references should appear
with long author names. "Rdpack" itself now uses this style.


<a id="org4e737e6"></a>

## Troubleshooting


<a id="org1405095"></a>

### A puzzling message in devtools development mode

The described procedure works transparently in `roxygen2` chunks and with Hadley
Wickham's package `devtools`.  Packages are built and installed properly with
the `devtools` commands and the references are processed as expected.

Currently (2017-08-04) if you run help commands `?xxx` for functions from the
package you are working on *in developement mode* and their help pages contain
references, you may encounter some puzzling warning messages, something like:

    1: In tools::parse_Rd(path) :
      ~/mypackage/man/abcde.Rd: 67: unknown macro '\insertRef'

These warnings are harmless and can be ignored &#x2014; the help pages are built
properly and no warnings appear outside *developer's mode*, e.g. in a separate R
session<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>. Even better, use the function `viewRd()` described
below to view the required help file.


<a id="org52dc53a"></a>

### Typical errors

The functions underlying the processing of references and citations intercept
errors, such as missing BibTeX labels or badly formed items in REFERENCES.bib,
and issue informative warnings during the building and installation of the
package, so that the developer is alerted but the package can still be built and
installed. In these cases the functions usually insert a suitable text in the
documentation, as well. If you encounter a situation contradicting this
description, it is probably a bug &#x2014; please report it (but check first for the
typical errors listed below).

A non-decipherable error message is probably caused by one of the following 
typical errors:

-   misspelled `RdMacros:` field in file DESCRIPTION. The safest way to avoid this
    is to copy it from the DESCRIPTION file of a working package.

-   omitted second argument of a reference or citation macro. Most of these macros
    have the package name as a second argument.

These errors occur during parsing of the Rd files, before the control is passed
to the `Rdpack`'s macros. 


<a id="orged9746f"></a>

## Latex markup in BibTeX entries

In principle, BibTeX entries may contain arbitrary Latex markup, while the Rd format
supports only a subset. As a consequence, some BibTeX entries may need some editing when
included in REFERENCES.bib<sup><a id="fnr.2" class="footref" href="#fn.2">2</a></sup>. Only do this for entries that do not render properly or
cause errors, since most of the time this should not be necessary.

If mathematics doesn't render properly replace the Latex dollar syntax with Rd's `\eqn`,
e.g. `$x^2$` with `\eqn{x^2}`. This should not be needed for versions of Rdpack
0.8-4 or later. 

Some Latex macros may have to be removed or replaced with suitable Rd markup. Again,
do this only if they cause problems, since some are supported, e.g. `\doi`.

See also the overview help page, \code{help("Rdpack-package")}, of \pkg{Rdpack}. 
Among other things, it contains some dummy references which illustrate the above.


<a id="org2fb6841"></a>

## Encoding of file REFERENCES.bib

If a package has a declared encoding (in file `DESCRIPTION`), `REFERENCES.bib` is read-in
with that encoding<sup><a id="fnr.3" class="footref" href="#fn.3">3</a></sup>.  Otherwise, the encoding of `REFERENCES.bib` is assumed to be
UTF-8 (which includes ASCII as a subset).

Note that BibTeX entries downloaded from online databases and similar sources may contain
unexpected characters in other encodings, e.g. 'latin1'. In such cases the check tools in
R-devel (since about 2018-10-01) may give warnings like:

    prepare_Rd: input string 1 is invalid in this locale

To resolve this, convert the file to the declared encoding or UTF-8. Alternatively, replace
the offending symbols with their classic TeX/LaTeX equivalents (which are ASCII). Non-ASCII
symbols in BibTeX entries obtained from online databases are often in fields like "Abstract",
which are normally not included in lists of references and can be deleted from REFERENCES.bib.

One way to check for non-ASCII symbols in a file is `tools::showNonASCIIfile()`.

Internally, LaTeX sequences standing for accented Latin characters, such as `\'e` and `\"o`,
are converted to UTF-8.  So, even if the file REFERENCES.bib is pure ASCII, it may implicitly
give raise to non-ASCII characters. This may cause R's checking tools to complain about
non-ASCII characters even after it has been verified that there are none. If this happens,
add the encoding declaration to file DESCRIPTION<sup><a id="fnr.4" class="footref" href="#fn.4">4</a></sup>:

    Encoding: UTF-8

Needless to say, make sure that there are really no characters from encodings like 'latin1'.


<a id="org34a78b5"></a>

# Viewing Rd files

A function, `viewRd()`, to view Rd files in the source directory of a package
was introduced in version 0.4-23 of `Rdpack`. A typical user call would look
something like:

    Rdpack::viewRd("./man/filename.Rd")

By default the requested help page is shown in text format. To open the page in
a browser, set argument 'type' to "html":

    Rdpack::viewRd("./man/filename.Rd", type = "html")

`viewRd()` renders references and citations correctly, since it understands Rd macros.

Users of 'devtools' can use `viewRd` in place of `help()` to view rendered Rd
sources in development mode. This should work also in development mode on any
platform (e.g. RStudio, Emacs/ESS, Rgui).


<a id="orgfd7af49"></a>

# Using Rdpack::reprompt()


<a id="org6ed52fe"></a>

## What it does

`Rdpack::reprompt()` updates `Rd` documentation. In the most common case when it
is called on an `Rd` file, it updates the documentation of all functions,
methods and classes documented in the file. For functions this includes
updating the usage section, adding missing aliases and `\item`'s for arguments
not described yet. For methods and classes entries for new methods and slots
are updated in a similar way. See the documentation for details.

`Rdpack::reprompt()` can also be invoked on an object or the name of an object,
just as `utils::prompt`. In that case it checks for installed documentation for
the object and works on it if found. Otherwise it creates an `Rd` file with
initial content similar to the one generated by `utils::prompt` but modified
so that the package can be built.

If a new function, say `newfun` is to be documented in an existing Rd file, just
add `newfun()` to the usage section in the file and call `Rdpack::reprompt()` to
insert the correct usage statement, add an alias, and add items for any new
arguments.

`Rdpack::reprompt()` **does not remove** anything that has become obsolete 
but it alerts the user to remove aliases, methods, and descriptions of arguments
that have been removed. 


<a id="orga8f3dc6"></a>

## Reprompt and open in an editor

To open the `reprompt()`-ed file, argument `edit` can be used.  For this to
work, `options("editor")` needs to be set suitably but it usually is.  If `edit
= TRUE`, then `Rdpack::reprompt()` will open the Rd file in an editor.  For more
convenient access to this feature, use `Rdpack::ereprompt()` (edit reprompt),
which calls `Rdpack::reprompt()` with `edit = TRUE` and sets the output filename
to be the same as the input filename.

In RStudio, `reprompt()` can be invoked on the `Rd` file being edited or the
selected name of an object in a source code file using RStudio add-in
`Repropmpt` (contributed by Duncan Murdoch). Obviously, this makes sense only
for Rd files not generated by `roxygen2`.

In Emacs/ESS there are various ways to use `Rdpack::reprompt()` and
`Rdpack::ereprompt()`. If `options("editor")` is set to `emacsclient`,
`Rdpack::ereprompt` is one option. It can also be assigned to a key (wrapped in
Elisp code), for example to be invoked on the currently edited file. Such a
function and example key binding can be found at [georgisemacs](https://github.com/GeoBosh/georgisemacs).


<a id="orgf979734"></a>

# Inserting evaluated examples

There is a macro that takes a chunk of R code, evaluates it, and includes both the code and
the results in the rendered documentation. The layout is similar to that in the R console but
the code is not prefixed with anything and the output is prefixed with comment symbols.
For example,

    \printExample{2+2; a <- 2*3; a}

gives

    2 + 2
    ##: 4
    a <- 2 * 3
    a
    ##: 6

See vignette [`Inserting_figures_and_evaluated_examples`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_figures_and_evaluated_examples.pdf) for more details.


<a id="orgaf22e59"></a>

# Inserting figures/graphs/plots

Figures can be inserted with the help of the standard Rd markup command `\figure`. 
The Rd macro `\insertFig` provided by package \pkg{Rdpack} takes a snipped of R code,
evaluates it and inserts the plot produced by it (using `\figure`).  `\insertFig` takes three
arguments: a filename, the package name and the code to evaluate to produce the figure. 
For example,

    \insertFig{cars.png}{mypackage}{x <- cars$speed; y <- cars$dist; plot(x,y)}

will evaluate the code, save the graph in file `"man/figures/cars.png"` subdirectory of
package `"mypackage"`, and include the figure using `\figure`. 

See vignette [`Inserting_figures_and_evaluated_examples`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_figures_and_evaluated_examples.pdf) for more details.


<a id="orgae9fd91"></a>

# Versions of Rdpack

Versions of `Rdpack` on Github are almost always fully functional (at least
passing `R CMD check --as-cran`), and so use a three-part version number. If a
version is really unstable, I would use the conventional fourth part
`.9000`. For release on CRAN, the version is incremented to
`x.x.0`<sup><a id="fnr.5" class="footref" href="#fn.5">5</a></sup>.

Note that if `Rdpack (>= x.x.0)` is required, it can be abbreviated to 
`Rdpack (>= x.x)`. 


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> If you care, here is what happens.  These warnings appear
because `devtools` reroutes the help command to process the developer's Rd
sources (rather than the documentation in the installed directory) but doesn't
tell `parse_Rd` where to look for additional macros. Indeed, the message above
shows that the error is in processing a source Rd file in the development
directory of the package and that the call to `parse_Rd` specifies only the
file.

<sup><a id="fn.2" href="#fnr.2">2</a></sup> Thanks to Michael Dewey for suggesting the discussion of this.

<sup><a id="fn.3" href="#fnr.3">3</a></sup> From `Rdpack (>=0.9-1)` The issue of not handling the encoding was raised by
Professor Brian Ripley.

<sup><a id="fn.4" href="#fnr.4">4</a></sup> Admittedly, this is not ideal since the user should not need to care how things are
processed internally but I haven't pinpointed the exact cause for this.

<sup><a id="fn.5" href="#fnr.5">5</a></sup> I adopted this versionning scheme from `Rdpack 0.7.0`.
