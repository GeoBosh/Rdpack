Rdpack provides functions for manipulation of R documentation objects, including
function `reprompt()` for updating existing Rd documentation for functions,
methods and classes; function `rebib()` for import of references from `bibtex`
files; a macro for importing `bibtex` references which can be used in `Rd` files
and `roxygen2` comments; and other convenience functions for references.


# Table of Contents

1.  [Installing Rdpack](#org0a314db)
2.  [Inserting Bibtex references](#org50e6746)
    1.  [Preparation](#org1d9f5ef)
    2.  [Inserting the references](#org6a3941d)
    3.  [Development using \*devtools"](#orgc484d54)
3.  [Using Rdpack::reprompt()](#org9300f19)
    1.  [What it does](#org96ca096)
    2.  [Reprompt and open in an editor](#orgaa59f6a)
4.  [Viewing Rd files](#org5d64da6)


<a id="org0a314db"></a>

# Installing Rdpack

The latest stable version is on CRAN. 

    install_packages("Rdpack")

You can also install the development version of `Rdpack` from Github:

    library(devtools)
    install_github("GeoBosh/Rdpack")


<a id="org50e6746"></a>

# Inserting Bibtex references

The simplest way to insert Bibtex references is with the Rd macro `\insertRef`.
Just put `\insertRef{key}{package}` in the documentation to insert item with key
`key`  from file `REFERENCES.bib` in your package `package`. For this to work
the `DESCRIPTION` file of the package needs to be amended, see below the full
details. 


<a id="org1d9f5ef"></a>

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


<a id="org6a3941d"></a>

## Inserting the references

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

For further details see the vignette at
[`Inserting_bibtex_references`](https://cran.r-project.org/package=Rdpack), or open it from `R`:

    vignette("Inserting_bibtex_references", package = "Rdpack")


<a id="orgc484d54"></a>

## Development using \*devtools"

The described procedure works transparently in `roxygen2` chunks and with Hadley
Wickham's package `devtools`.  Packages are built and installed properly with
the `devtools` commands and the references are processed as expected.

Currently (2017-08-04) if you run help commands `?xxx` for functions from the
package you are working on *in developement mode* and their help pages contain
references, you may encounter some puzzling warning messages, something like:

    1: In tools::parse_Rd(path) :
      ~/mypackage/man/abcde.Rd: 67: unknown macro '\insertRef'

These warnings are harmless - the help pages are built properly and no warnings
appear outside *developer's mode*, e.g. in a separate R~session. See below for a
way to inspect help pages directly from Rd files.

If you care, here is what happens.  These warnings appear because `devtools`
reroutes the help command to process the developer's Rd sources (rather than the
documentation in the installed directory) but doesn't tell `parse_Rd` where to
look for additional macros. Indeed, the message above shows that the error is in
processing a source Rd file in the development directory of the package and that
the call to `parse_Rd` specifies only the file.


<a id="org9300f19"></a>

# Using Rdpack::reprompt()


<a id="org96ca096"></a>

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


<a id="orgaa59f6a"></a>

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


<a id="org5d64da6"></a>

# Viewing Rd files

A function, `viewRd()` to view Rd files in the source directory of a package was
introduced in version 0.4-23 of `Rdpack`. A typical user call would look something like:

    Rdpack::viewRd("./man/filename.Rd")

By default the requested help page is shown in text format. To open the page in a browser,
set argument 'type' to "html":

    Rdpack::viewRd("./man/filename.Rd", type = "html")

This works also in RStudio, but not if the package of the Rd file is in
development mode (I couldn't figure out how rectify this, see also TODO file).

