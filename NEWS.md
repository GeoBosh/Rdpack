# Changes in Version 0.7-0 (CRAN)

- consolidated the changes introduced since the previous CRAN release of Rdpack
  (it was 0.5-5) in preparation for the next release.  Users of the new macros
  for citation can use `Rdpack (>=0.7)` in the `Imports:` field of file
  "DESCRIPTION" to ensure that they are available.
  
- comprehensive overhaul of handling of errors and warnings during processing of
  references and citations. In particular, such errors should (in most cases)
  produce only warnings during `R CMD build` and `R CMD INSTALL`, and not
  prevent the package from being built and installed.

- Unresolved BibTeX keys produce warnings during building and installation of
  the package, but not errors. Dummy entries are inserted in the documentation
  explaining what was amiss (currently with 'author' A Adummy). 

# Changes in Version 0.6-x

- new Rd macros for citations

   - `\insertCite` inserts citation(s) for one or more keys and records the keys
     for `\insertAllCited` (see below).
	   
   - `\insertCiteOnly` is similar to `\insertCite` but does not record the keys.
     
   - `\insertNoCite` records the keys but does not produce a citation.

   - `\insertAllCited` prints a bibliography including all references recorded
     by `\insertAllCited` and `\insertNoCite`.

- new entries in this file will use markdown syntax.

- updates to the documentation.


# Changes in Version 0.5-7

   - `get_bibentries()` gets a new argument "everywhere". When is is TRUE, the
     default, unescaped percents are escaped in all bibtex fields, otherwise the
     replacement is done only in field "URL".

   - removed several `print()` statements which were accidentally left in the
     code in v. 0.5-6.

   - updated help page of `get_bibentries()` and included examples.

   - cleaned up the imports in NAMESPACE.


# Changes in Version 0.5-6

   - `insert_ref()` and Rd macro `\insertRef` should now work ok in the presence
     of percent encoded symbols in URL field of a BibTeX entry.  Closes issue
     "Unexpected END_OF_INPUT error (URL parsing?)", see 
	 [Rdpack issue 3](https://github.com/GeoBosh/Rdpack/issues/3), raised by
     [jdnewmil](https://github.com/jdnewmil).

   - `get_bibentries()` now takes care of percent encoded symbols in URLs.  It
     now returns an object from class "bibentryRd", which inherits from
     "bibentry" but has its own print method which escapes or unescapes the
     percent signs in URLs depending on the requested output style. This was
     also reported by by [jdnewmil](https://github.com/jdnewmil) in issue#3
     referenced above.

   - `get_bibentries()` now tries to load the `bib` file from the development
     directory of argument "package", in case it is in development mode under
     "devtools". (Even though the search is with `system.file()`, which
     `devtools` replaces with its own version, the bib file still needs to be
     looked for in "inst/", i.e. it is not in the root directory as is the case
     in installed packages.)


# Changes in Version 0.5-5 (CRAN)

   - Streamlined the help page of `reprompt()` and `Rdpack-package`.

   - new argument, `edit', in `reprompt()` opens the Rd file after updating it.

   - new function `ereprompt()` (`e' for _edit_) - opens `reprompt()` with suitable
     defaults to replace the original Rd file and open it in an editor, otherwise
     equivalent to `reprompt()`.

   - now if `infile` does not exist, `reprompt()`, and hence `ereprompt()`, strips
     the directory part, finds the root of the package directory, and looks for
     the file under `man/` (this uses package `rprojroot`'). In particular,
     if the working directory is anywhere under the package root,
     `infile` can be simply the name of the Rd file, without path.

   - now README.md is generated from README.org. I changed the layout and
     amended the information in it.

   - README.* now get links to
     [georgisemacs](https://github.com/GeoBosh/georgisemacs) for an emacs
     function to `reprompt()` the Rd file at point.

   - `viewRd()` now works also when the file is from a package under devtools'
     development mode on any platform (e.g. RStudio, Emacs/ESS, Rgui).


# Changes in Version 0.5-4.9000

   - new RStudio add-in 'Reprompt`, contributed by Duncan Murdoch.

     If the file being edited in the code editor is an Rd file it calls
     `reprompt()`. If the file is as R source file, it looks for the help page
     of a selected object name and works on it if found, otherwise creates one.


# Changes in Version 0.5-4

   - added the version of `Rdpack` to the abstract of the vignette.  This seems
     more informative than giving the compilation date.

   - now `reprompt()` doesn't give spurious warnings about unknown Rd macros when
     the Rd file contains user defined Rd macros. These warnings were harmless
     and rare, but alarming and annoying. 

   - fixed a bug in `inspect_args()` which caused the warning
       _"In is.na(x) : is.na() applied to non-(list or vector) of type 'NULL'"_
     in `reprompt()`, when the signature of a function in "Usage" section was
     empty.


# Changes in Version 0.5-3 (CRAN)

   - The warning message about a missing reference key now appears also in the
     respective help page.


# Changes in Version 0.5-2

   - added the github url to DESCRIPTION.

   - now give a more informative warning if a key is missing from REFERENCES.bib
     (thanks to Kisung You for suggesting this).
     

# Changes in Version 0.5-1 (CRAN)

   - an example was not restoring the working directory.


# Changes in Version 0.5-0

   - moved gbRd from Depends to Imports and adjusted some examples to use
     `tools::parse_Rd()` rather than `parse_Rd()` (before this was not necessary
     since 'gbRd' _depended on_ 'tools').


# Changes in Version 0.4-23

   - new function `viewRd()` parses and shows an Rd file in a source package.
     May be particularly helpful for devtools developers.

   - revamped the vignette, added additional explanations of possible issues.

   - new functions `makeVignetteReference()` and `vigbib()` generate Bibtex
     references for vignettes in a package.

# Changes in Version 0.4-22 (CRAN)

   - Added the requirement to **Import Rdpack** to the help page of
     `insert_ref()`.  (It was out of sync with the vignette.)

   - Updated Description in DESCRIPTION, which was also out of sync with the
     vignette.

   - Bug fix in the vignette: changed `\@references` to `@references` in the
     roxygen2 example.


# Changes in Version 0.4-21 (CRAN)

   - Edited and amended vignette _"Inserting_bibtex_references"_, including:
   
       - additional explanation and an example,
	   
       - requirement to import Rdpack and a mention of travis etc.
	   
       - paragraph about devtools.

   - changed the URL for parse_Rd.pdf in REFERENCES.bib to https.


# Changes in Version 0.4-20 (CRAN)

   - cleaned up some minor CRAN issues.


# Changes in Version 0.4-19

   - new facility for inserting references from BibTeX files - just put the
     line:

        RdMacros: Rdpack

    in the `DESCRIPTION` file of your package and the references in
    `inst/REFERENCES.bib`.  Then put `\inserRef{key}{yourpackage}` in
    documentation chunks to insert item `key` from the bib file. This works with
    both manually created Rd files and roxygen comments, see the documentation
    for details.


# Changes in Version 0.4-18 (CRAN)

   - from now on, put (CRAN) next to versions published on CRAN (as above)

   - a minor correction in file NEWS.


# Changes in Version 0.4-17

   - In file DESCRIPTION, changed reprompt and rebib to `reprompt()` and
     `rebib()`.


# Changes in Version 0.4-16

   - don't export `parse_text`

   - corrected bug in reprompt for S4 classes - new slots were not handled
     correctly (see `slots.R` for details).

   - reprompt for S4 methods - if the methods documentation describes methods
     that do not exist, print an informative message for the user. (Such methods
     are also printed for debugging purposes but in non-user friendly form.)

   - included `methods` in `Imports:` - around R-devel version 2015-07-01 r68620
     not including it triggers warnings)


# Changes in Version 0.4-8

   - new functions `.whichtageq` and `.whichtagin`; replaced most calls to
     `toolsdotdotdotRdTags` with these.

   - removed `toolsdotdotdotRdTags`

# Changes in Version 0.4-7

   - removed `:::` calls from code; copied some functions from `tools` to
     achieve this (see "threedots.R"). Renamed the functions replacing `:::`
     with dotdotdot.

   - export by name (not the generic export pattern); preparation for more
     selective export of functions in the future.

   - new functions: `Rdo_get_argument_names`, `Rdo_get_item_labels`

# Changes in Version 0.4-5

   - dependence `bibtex` becomes "Imports".  `tools` and `gbRd` remain (for now)
     "Depends" since functions from them are used in some examples without
     "require"'s.

   - `rebib()`: now `outfile=""` can be used to request overwriting `infile`.
     (a small convenience; before the change, one could do this by giving the
     `outfile` and `infile` the same values.)

   - Bug fix: "predefined.Rd! contained `\tabular` environments with vertical
     bars, `|`, in the format specification. This is not documented in "Writing
     R exts" but works for LaTeX and remained unnoticed by me and R CMD
     check. However, rendering the help page for the objects documented in
     "predefined.Rd" gave an error in html and text mode.  Package installation
     failed only if html was requested at build time.

   - small changes in the documentation

# Changes in Version 0.4-1

   - new major feature: processing references from Bibtex files.  The top user
     level function is `rebib()`, which updates section "references" in an Rd
     file. `promptPackageSexpr()` has been updated to use this
     feature. `inspect_Rdbib()` can be used in programming.

   - new auxiliary functions for work with `bibentry` objects.

   - new convenience programming functions for Rd objects.

   - some small bug fixes.

   - some gaps in the documentation filled.


# Changes in Version 0.3-11

   - `reprompt()` did not handle properly S4 replacement methods. Changed the
     parsing of the arguments to rectify this. Some other functions also needed
     correction to handle this.

# Changes in Version 0.3-10

   - `Depends` field in DESCRIPTION file updated to require R 2.15.0 or later.
     (because of a few uses of `paste0()` in recent code.)

# Changes in Version 0.3-8 (CRAN)

   - first public version
