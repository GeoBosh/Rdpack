Rdpack provides functions for manipulation of R documentation objects, including
functions `reprompt()` and `ereprompt()` for updating existing Rd documentation
for functions, methods and classes; Rd macros for citations and import of
references from `bibtex` files for use in `Rd` files and `roxygen2` comments;
and many functions for manipulation of references and Rd files.


# Table of Contents

1.  [Installing Rdpack](#orge8906ef)
2.  [Inserting Bibtex references](#orgfea8d9f)
    1.  [Preparation](#org905dcf7)
    2.  [Inserting references](#orga6bedba)
    3.  [Inserting citations](#org9ae9919)
    4.  [Troubleshooting](#orge1a9ce3)
3.  [Viewing Rd files](#orga7389b8)
4.  [Using Rdpack::reprompt()](#org1b28c8c)
    1.  [What it does](#org1b50b83)
    2.  [Reprompt and open in an editor](#org99c89a9)


<a id="orge8906ef"></a>

# Installing Rdpack

The [latest stable version](https://cran.r-project.org/package=Rdpack) is on CRAN. 

    install_packages("Rdpack")

You can also install the [development version](https://github.com/GeoBosh/Rdpack) of `Rdpack` from Github:

    library(devtools)
    install_github("GeoBosh/Rdpack")


<a id="orgfea8d9f"></a>

# Inserting Bibtex references

The simplest way to insert Bibtex references is with the Rd macro `\insertRef`.
Just put `\insertRef{key}{package}` in the documentation to insert item with key
`key`  from file `REFERENCES.bib` in your package `package`. For this to work
the `DESCRIPTION` file of the package needs to be amended, see below the full
details. 


<a id="org905dcf7"></a>

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


<a id="orga6bedba"></a>

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
or open the the from `R`:

    vignette("Inserting_bibtex_references", package = "Rdpack")

(The latest version of the vignette is at
[`Inserting_bibtex_references (development version on github)`](https://github.com/GeoBosh/Rdpack/blob/master/vignettes/Inserting_bibtex_references.pdf).)


<a id="org9ae9919"></a>

## Inserting citations

From version 0.6-1 of "Rdpack", additional Rd macros are
available for citations.  They can be used in both Rd and
roxygen2 documentation.

`\insertCite{key}{package}` cites `key` and records it for
use by `\insertAllCited`, see below. `key` can contain
more keys separated by commas.

 `\insertCite{parseRd,Rpack:bibtex}{Rdpack}` produces 
 (Murdoch 2010; Francois 2014)
and 
 `\insertCite{Rpack:bibtex}{Rdpack}`         gives
(Francois 2014)

By default the citations are parenthesised `\insertCite{parseRd}{Rdpack}` produces
(Murdoch 2010).  To get
textual citations, like 
Murdoch (2010) 
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

To mix the citations with other text, such as \`\`see also'' and
\`\`chapter 3'', write the list of keys as a free text, starting
it with the symbol `@` and prefixing each key with it. 
The `@` symbol will not appear in the output. For example, the following code

    \insertCite{@see also @parseRd and @Rpack:bibtex}{Rdpack}
    \insertCite{@see also @parseRd; @Rpack:bibtex}{Rdpack}
    \insertCite{@see also @parseRd and @Rpack:bibtex;textual}{Rdpack}

produces:

(see also Murdoch 2010 and Francois 2014) 

(see also Murdoch 2010; Francois 2014) 

see also Murdoch (2010) and Francois (2014)

&#x2014;

`\insertCiteOnly{key}{package}` is as
`\insertCite` but does not include the key in the list of
references for `\insertAllCited`.


<a id="orge1a9ce3"></a>

## Troubleshooting

The described procedure works transparently in `roxygen2` chunks and with Hadley
Wickham's package `devtools`.  Packages are built and installed properly with
the `devtools` commands and the references are processed as expected.

Currently (2017-08-04) if you run help commands `?xxx` for functions from the
package you are working on *in developement mode* and their help pages contain
references, you may encounter some puzzling warning messages, something like:

    1: In tools::parse_Rd(path) :
      ~/mypackage/man/abcde.Rd: 67: unknown macro '\insertRef'

These warnings are harmless - the help pages are built properly and no warnings
appear outside *developer's mode*, e.g. in a separate R
session<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>. Even better, use the function `viewRd()` described
below to view the required help file.


<a id="orga7389b8"></a>

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


<a id="org1b28c8c"></a>

# Using Rdpack::reprompt()


<a id="org1b50b83"></a>

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


<a id="org99c89a9"></a>

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


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> If you care, here is what happens.  These warnings appear
because `devtools` reroutes the help command to process the developer's Rd
sources (rather than the documentation in the installed directory) but doesn't
tell `parse_Rd` where to look for additional macros. Indeed, the message above
shows that the error is in processing a source Rd file in the development
directory of the package and that the call to `parse_Rd` specifies only the
file.
