# Update and Manipulate Rd Documentation Objects

Functions for manipulation of R documentation objects, including
functions reprompt() and ereprompt() for updating 'Rd' documentation for
functions, methods and classes; 'Rd' macros for citations and import of
references from 'bibtex' files for use in 'Rd' files and 'roxygen2'
comments; 'Rd' macros for evaluating and inserting snippets of 'R' code
and the results of its evaluation or creating graphics on the fly; and
many functions for manipulation of references and Rd files.

## Details

Package `Rdpack` provides a number of functions for maintenance of
documentation in R packages. Although base R and package `methods` have
functions for creation of skeleton documentation, if a function gets a
new argument or a generic gets a new method, then updating existing
documentation is somewhat inconvenient. This package provides functions
that update parts of the Rd documentation that can be dealt with
automatically and leave manual changes untouched. For example, usage
sections for functions are updated and if there are undescribed
arguments, additional items are put in the \`arguments' section.

A set of functions and macros support inclusion of references and
citations from BibTeX files in R documentation (Rd and roxygen2). These
tools use only facilities provided by base R and package rbibutils
(Boshnakov and Putman 2020) .

There are also convenience macros for inclusion of evaluated examples
and graphs, which hide some of the hassle of doing this directly with
the underlying `\Sexpr`'s.

The subsections below give additional details, see also the vignettes.

### Creating and updating Rd files

The main function provided by this package is
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md).
There is also a function
[`promptPackageSexpr`](https://geobosh.github.io/Rdpack/reference/promptPackageSexpr.md)
for creating initial skeleton for overall package description such as
this help page.

[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
produces a skeleton documentation for the requested object, similarly to
functions like `prompt`, `promptMethods`, and `promptClass`. Unlike
those functions,
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
updates existing documentation (installed or in an Rd object or file)
and produces a skeleton from scratch as a last resort only. If the
documentation object describes more than one function, all descriptions
are updated. Basically,
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
updates things that are generated automatically, leaving manual editing
untouched.

The typical use of `reprompt` is with one argument, as in

        reprompt(infile = "./Rdpack/man/reprompt.Rd")
        reprompt(reprompt)
        reprompt("reprompt")

`reprompt` updates the documentation of all objects described in the Rd
object or file, and writes the updated Rd file in the current working
directory, see
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md) for
details. To describe a new function in an existing Rd file, just add
something like `myfun()` and run reprompt to insert the correct
signature, alias, etc. This works also for replacement functions, see
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md) for
details.

[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
updates the Rd documentation in a file, overwrites it and opens it in an
editor. It calls `reprompt` to do the actual job but has different
defaults. Which editor is opened, is system dependent, see the
[`edit`](https://rdrr.io/r/utils/edit.html) and
[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
for futher details.

Users who work on Rd files in RStudio can use add-in “Reprompt” to
invoke `reprompt` conveniently on an Rd file or on a selected object in
an R source code file, see
[`RStudio_reprompt`](https://geobosh.github.io/Rdpack/reference/RStudio_reprompt.md).
This add-in was contributed by Duncan Murdoch.

Users of Emacs/ESS have various options, depending on their workflow.
One approach is to define a key to call
[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
on the file being edited, see
[georgisemacs](https://github.com/GeoBosh/georgisemacs) for an example
setup.

[`promptPackageSexpr`](https://geobosh.github.io/Rdpack/reference/promptPackageSexpr.md)
creates a skeleton for a package overview in file `name-package.Rd`.
Then the file can be edited as needed. This function needs to be called
only once for a package since automatic generation of information in
`name-package.Rd` is achieved with Sexpr's at build time, not with
verbatim strings (`promptPackage` used to insert verbatim strings but in
recent versions of R it also uses macros.).

For example, the source of this help page is file \`Rdpack-package.Rd'.
It was initially produced using

        promptPackageSexpr("Rdpack")

The factual information at the beginning of this help topic (the index
above, the version and other stuff that can be determined automatically)
is kept automatically up to date.

### References and Citations

Another set of functions is for management of bibliographic references
in Rd files. The old approach based on function
[`rebib`](https://geobosh.github.io/Rdpack/reference/rebib.md) is fully
functional, see below, but the recommended way to insert references and
citations is based on Rd macros.

The provided Rd macros are fully portable and, in particular, work in Rd
files and roxygen2 comments, see
[`insertRef`](https://geobosh.github.io/Rdpack/reference/insert_ref.md)
and vignette `vignette("Inserting_bibtex_references", "Rdpack")` for
details and examples.

The Bibtex source for the references and citations produced by the Rd
macros is file "REFERENCES.bib", which should be located in the root of
the package installation directory. Rdpack needs also to be mentioned in
two places in file \`DESCRIPTION'. These one-off preparation steps are
enumerated below:

1.  Put the following line in file \`DESCRIPTION':  
    `RdMacros: Rdpack`  
    (If there is already a line starting with 'RdMacros:', add Rdpack to
    the list on that line.)

2.  Add Rdpack to the list of imports (`Imports:` field) in file
    \`DESCRIPTION'.

3.  Add the following line to file \`NAMESPACE':

            importFrom(Rdpack,reprompt)

    Alternatively, if devtools is managing your NAMESPACE file, the
    equivalent roxygen2 line is:

            #' @importFrom Rdpack reprompt

4.  Create file `"REFERENCES.bib"` in subdirectory `"inst/"` of the
    package and put the BibTeX references in that file.

The Rd macro `\insertRef` takes two arguments: a BibTeX key and the name
of a package. Thus, `\insertRef{key}{package}` inserts the reference
whose key is `key` from "REFERENCES.bib" of the specified package
(almost always the one being documented).

Citations can be done with Rd macro `\insertCite`, which inserts
citation(s) for one or more BibTeX keys and records the keys.
`\insertCiteOnly` is similar to `\insertCite` but does not record the
keys. `\insertNoCite` records the keys but does not produce citations.

`\insertAllCited` creates a bibliography including all references
recorded by `\insertCite` and `\insertNoCite`. It is usually put in
section “References”, something like:

        \references{
          \insertAllCited{}
        }

in an Rd file. The analogous documentation chunk in roxygen2 might look
like this:

        #' @references
        #'   \insertAllCited{}

Don't align the backslash with the second 'e' of `@references`, since
roxygen2 may interpret it as verbatim text, not macro.

Bibliography styles for lists of references are supported as well.
Currently the only alternative offered is to use long names (Georgi N.
Boshnakov) in place of the default style (Boshnakov GN). More
comprehensive alternatives can be included if needed or requested.

Convenience functions
[`makeVignetteReference`](https://geobosh.github.io/Rdpack/reference/makeVignetteReference.md)
and
[`vigbib`](https://geobosh.github.io/Rdpack/reference/makeVignetteReference.md)
generate Bibtex entries for vignettes.

### Previewing documentation pages

It is convenient during development to be able to view the rendered
version of the document page being edited. The function
[`viewRd`](https://geobosh.github.io/Rdpack/reference/viewRd.md) renders
a documentation file in a source package and displays it as text or in a
browser. It renders references properly in any workflow, including
devtools development mode (Wickham et al. 2018) in Emacs/ESS, Rstudio,
Rgui. This function is a good candidate to be assigned to a key in
editors which support this.

I created this function (in 2017) since the functions provided by
devtools and Emacs/ESS are giving errors when processing pages
containing Rd macros.

### Static Management of References

In the alternative approach, the function
[`rebib`](https://geobosh.github.io/Rdpack/reference/rebib.md) updates
the bibliographic references in an Rd file. Rdpack uses a simple scheme
for inclusion of bibliographic references. The key for each reference is
in a TeX comment line, as in:

        \references{
          ...
          % bibentry: key1
          % bibentry: key2
          ...
        }

`rebib` puts each reference after the line containing its key. It does
nothing if the reference has been put by a previous call of `rebib`. If
the Bibtex entry for some references changes, it may be necessary to
update them in the Rd file, as well. Call `rebib` with `force = TRUE` to
get this effect. There is also a facility to include all references from
the Bibtex file, see the documentation of
[`rebib`](https://geobosh.github.io/Rdpack/reference/rebib.md) for
details.

### Inserting evaluated examples

Sometimes the documentation of an object becomes more clear if
accompanied by snippets of R code and their results. The standard Rd
macro `\Sexpr` caters for a number of possibilities to evaluate R code
and insert the results and the code in the documentation. The Rd macro
`\printExample` provided by package Rdpack builds on it to print a
snippet of R code and the results of its evaluation, similarly to
console output but the code is not prefixed and the results are prefixed
with comment symbols. For example, `\printExample{2+2; a <- 2*3; a}`
produces the following in the rendered documentation:

    2 + 2
    ##: [1] 4
    a <- 2 * 3
    a
    ##: [1] 6

The help page of
[`promptUsage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
contains a number of examples created with `\printExample`. The
corresponding Rd file can be obtained from the package tarball or from
<https://github.com/GeoBosh/Rdpack/blob/master/man/promptUsage.Rd>.

The argument of `\printExample` must be on a single line with versions
of R before R 3.6.0.

`\printExample` is typically placed in section Details of an object's
documentation, see section Details of
[`get_usage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
for a number of examples produced mostly with `\printExample`.

The macro `\runExamples` can be used as a replacement of section
`Examples`. For example, if the following code is put at the top level
in an Rd file (i.e. not in a section):

        \runExamples{2+2; a <- 2*3; a}

then it will be evaluated and replaced by a normal section examples:

        \examples{
        2 + 2
        ##: 4
        a <- 2 * 3
        a
        ##: 6
        }

This generated examples section is processed by the standard R tools
(almost) as if it was there from the outset. In particular, the examples
are run by the R's quality control tools and tangled along with examples
in other documentation files.

In R versions before 3.6.0 `R CMD check` used to give a warning about
unknown `\Sexpr` section at top level.

### Creating and including graphs

Figures can be inserted with the help of the standard Rd markup command
`\figure`. The Rd macro `\insertFig` provided by package Rdpack takes a
snipped of R code, evaluates it and inserts the plot produced by it
(using `\figure`). `\insertFig` takes three arguments: a filename, the
package name and the code to evaluate to produce the figure. For
example,

        \insertFig{cars.png}{mypackage}{x <- cars$speed; y <- cars$dist; plot(x,y)}

will evaluate the code, save the graph in file `"man/figures/cars.png"`
subdirectory of package `"mypackage"`, and include the figure using
`\figure`. Subdirectory `"figures"` is created if it doesn't exist.
Currently the graphs are saved in `"png"` format only. In older versions
of R the code should be on a single line for the reasons explained in
the discussion of `\printExample`.

The sister macro `\makeFig` creates the graph in exactly the same way as
`\insertFig` but does not insert it. This can be done with a separate
`\figure` command. This can be used if additional options are desired
for different output formats, see the description of `\figure` in
"Writing R extensions".

Other functions that may be useful are `Rdo2Rdf`, `Rdapply` and
`Rd_combo`. Here is also brief information about some more technical
functions that may be helpful in certain circumstances.

[`get_usage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md)
generates usage text for functions and methods. The functions can be
located in environments or other objects. This may be useful for
description of function elements of compound objects.

[`c_Rd`](https://geobosh.github.io/Rdpack/reference/c_Rd.md)
concatenates Rd pieces, character strings and lists to create a larger
Rd piece or a complete Rd object.
[`list_Rd`](https://geobosh.github.io/Rdpack/reference/list_Rd.md) is
similar to [`c_Rd`](https://geobosh.github.io/Rdpack/reference/c_Rd.md)
but provides additional features for convenient assembling of Rd
objects.

[`parse_Rdpiece`](https://geobosh.github.io/Rdpack/reference/parse_Rdpiece.md)
is a technical function for parsing pieces of Rd source text but it has
an argument to return formatted help text which may be useful when one
wishes to show it to the user.

`Rdo_set_section` can be used to set a section, such as "`\author`".

The remaining functions in the package are for programming with Rd
objects.

## Author

Georgi N. Boshnakov \[aut, cre\] (ORCID:
\<https://orcid.org/0000-0003-2839-346X\>), Duncan Murdoch \[ctb\]

Maintainer: Georgi N. Boshnakov \<georgi.boshnakov@manchester.ac.uk\>

## Note

All processing is done on the parsed Rd objects, i.e. objects of class
"Rd" or pieces of such objects (Murdoch 2010) .

The following terminology is used (todo: probably not yet consistently)
throughout the documentation.

"Rd object" - an object of class Rd, or part of such object.

"Rd piece" - part of an object of class Rd. Fragment is also used but
note that `parse_Rd` defines fragment more restrictively.

"Rd text", "Rd source text", "Rd format" - these refer to the text of
the Rd files.

## See also

[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md),
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md),
[`promptPackageSexpr`](https://geobosh.github.io/Rdpack/reference/promptPackageSexpr.md),
[`rebib`](https://geobosh.github.io/Rdpack/reference/rebib.md),

[`get_usage`](https://geobosh.github.io/Rdpack/reference/promptUsage.md),

[`viewRd`](https://geobosh.github.io/Rdpack/reference/viewRd.md),
[`vigbib`](https://geobosh.github.io/Rdpack/reference/makeVignetteReference.md),
[`makeVignetteReference`](https://geobosh.github.io/Rdpack/reference/makeVignetteReference.md),

`vignette("Inserting_bibtex_references", package = "Rdpack")`,

`vignette("Inserting_figures_and_evaluated_examples", package = "Rdpack")`

## References

**Note 1:** Reference ZZZ (2018) (see below) does not exist. It is a
test that simple math in BibTeX entries works.

**Note 2:** Reference Ünderwood et al. (1988) is included to show that
some more and less usual accents are handled.

—

Georgi N. Boshnakov, Chris Putman (2020). *rbibutils: Convert Between
Bibliography Formats*. <https://CRAN.R-project.org/package=rbibutils>.  
  
Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.  
  
Ulrich Ünderwood, Ned Ñet, Paul P̄ot (1988). “Lower Bounds for Wishful
Research Results.” Talk at Fanstord University (this is a full
UNPUBLISHED entry).  
  
Hadley Wickham, Jim Hester, Winston Chang (2018). *devtools: Tools to
Make Developing R Packages Easier*. R package version 1.13.5,
<https://CRAN.R-project.org/package=devtools>.  
  
A. ZZZ (2018). “A non-existent paper with a relation between several
fundamental constants: \\e^{i\pi}=-1\\ in the title and showing that
`a\slash b` converts to a/b.” *A non-existent journal with the formula
\\L_2\\ in its name and \# \$ & \_ ^ ~ an ampersand and other special
characters preceded by a backslash in the bib file*. This reference
demonstrates that formulas in BibTeX files are OK. A formula in field
'note': \\c^2 = a^2 + b^2\\. If you need to, even display math is
possible: \$\$ E = mc^2 ,\$\$ a famous formula.

## Examples

``` r
## The examples below show typical use but are not executable.
## For executable examples see the help pages of 
## reprompt, promptPackageSexpr, and rebib.

## To make the examples executable, replace "myfun" with a real
## function, and similarly for classes and paths to files.

if (FALSE) { # \dontrun{
## update the doc. from the Rd source and save myfun.Rd
##     in the current directory (like prompt)
reprompt(infile="path/to/mypackage/man/myfun.Rd")

## update doc of myfun() from the installed doc (if any);
##     if none is found, create it like prompt
reprompt("myfun")
reprompt(myfun)      # same

## update doc. for S4 methods from Rd source
reprompt(infile="path/to/mypackage/man/myfun-methods.Rd")

## update doc. for S4 methods from installed doc (if any);
##     if none is found, create it like promptMethods
reprompt("myfun", type = "methods")
reprompt("myfun-methods")  # same


## update doc. for S4 class from Rd source
reprompt(infile="path/to/mypackage/man/myclass-class.Rd")

## update doc. of S4 class from installed doc.
##     if none is found, create it like promptClass
reprompt("myclass-class")
reprompt("myclass", type = "class")  # same


## create a skeleton "mypackage-package.Rd"
promptPackageSexpr("mypackage")

## update the references in "mypackage-package.Rd"
rebib(infile="path/to/mypackage/man/mypackage-package.Rd", force=TRUE)
} # }
```
