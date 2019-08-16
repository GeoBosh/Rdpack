# Rdpack 0.11-1

- in documentation of S4 classes, such as `"classname-class.Rd"`, `reprompt()`
  was sometimes inserting entries for slots already listed in the Slots
  section. The same bug was causing the new slots not to be reported properly to
  the user.

- in some cases `reprompt()` failed to process properly `\S4method` entries in
  the Usage section of Rd files. Now fixed.
  
- `reprompt()` now handles `\S4method` statements for replacement methods.  As
  for other functions and methods (S3 and S4), it is sufficient to put a
  declaration with empty argument list in the Usage sectio and `reprompt()` will
  insert the correct formal arguments for the method (they may be different from
  those of the generic).
  
- `reprompt()`  now gives a more helpful error message when `type` is invalid.

- corrected some minor typo's in the documentation.

- README and the documentation of `reprompt()` and `Rdpack-package` now give
  more details on `reprompt()`ing replacement functions.

- README.md and README.org now give the correct `install.packages`
  instruction for CRAN (pull request #10 from @katrinleinweber).

- some examples were leaving a stray file, `dummyfun.Rd`, after
  `R CMD check`.
  

# Rdpack 0.11-0 (CRAN)

- Updated the vignette about `\insertFig`, `\printExample` and `\runExamples`,
  to reflect the lifting in `R 3.6.0` of some limitations of Rd processing in
  previous R versions.
  
- Vignette 'Inserting BibTeX references' now includes a section on bibliography
  styles. This section was previously only in README.
  
- The fix in Rdpack 0.10-3 (see below) for an issue introduced in R-devel in Oct
  2018 will be made permanent, at least for now. This fix resolves also a
  similar issue in package `pkgdown`, see the discussion at 
  https://github.com/GeoBosh/Rdpack/issues/9 for details and further links.
  
  

# Rdpack 0.10-3

* fixed issue#9 (reported by by @aravind-j) appearing when a package is built
  with R-devel (since about Oct 2018) causing references by `\insertAllCited{}`
  to appear in a single paragraph in the `html` rendering of the Rd documentation.
  

# Rdpack 0.10-2

* added pkgdown site to DESCRIPTION.

* README and the vignette about evaluated examples now state that R-devel no
  longer gives warnings about `\Sexpr` not being a top level section. 
  This means that macro `runExamples` which creates section 'Examples'
  containing code and results of evaluation will be useable in CRAN packages. 

* new function `Rdo_fetch()` gets the Rd object representing a help page from an
  installed or source package. It works also for packages under devtool's
  developer's mode
  
* The site created with pkgdown contains fewer errors now.
  (Note that the documentation builds without error with R's tools).

* Started moving tests from my local setup to testthat. 

# Rdpack 0.10-1 (CRAN)

* removed redundant references from REFERENCES.bib (they were leftovers from
  testing).

# Rdpack 0.10-0 

* updated vignette 'Inserting_bibtex_references'.


# Rdpack 0.9-1

* now `REFERENCES.bib` is read-in using the declared encoding for the
  corresponding package. If there is no declared encoding, "UTF-8" is assumed. 

* Now macros `\insertCite` and `\insertCiteOnly` use the correct `results=rd`
  instead of `results=Rd`. This was not catched by `R`s building tools but
  caused errors when processed with `pkgdown::build_site()`. Fixes issue#8. Also
  fixes r-lib/pkgdown#784. 
  Thanks to [Jay Hesselberth](https://github.com/jayhesselberth) for uncovering
  this. 

* now references produced by the citation macros for BibTeX entries of type
  `@book` and `@incollection` treat field 'series' similarly to other BibTeX
  styles, including JSS (issue#7 raised by Kisung You). Note that even though
  the underlying base R tools are based on JSS, they treat this field
  differently.

* Bugfix: now Rd macro `\printExample` evaluates the expressions in the correct
  environment. 
  
* help page of `get_usage` gets a fairly complete Details section with numerous
  evaluated examples. 
  
* now `run_examples()` escapes `%` by default, before returning the text. This is
  needed for text that is to be included in an Rd file. It can be turned off by
  setting the new argument `escape` to `FALSE`.

* now `reprompt()` gives a more informative error message if an Rd file
  describes a non-existent S4 class. This is not captured by `R`s tools. It can
  happen during development if a class is removed.

* now reports printed by `reprompt()` about methods documented in Usage
  sections, but no longer existing, are more readable. This is due to a new
  print method for (the mostly internal) class "f_usage".

* Many features of Rdpack are best demonstrated on a package. The new package
  RdpackTester under `./inst/examples` now makes this easier.

* now the help page "predefined.Rd" does not print some tables twice in the pdf
  manual. (This was due to using `\if{latex}{}{}' instead of
  `\ifelse{latex}{}{}' for those tables.)

* also in "predefined.Rd", removed illegal use of vertical bars (in column
  specifications of tabular environments) from the pure LaTeX code in the
  `\ifelse` clause(s) and wrapped them in `\out{}`. 

* in "get_sig_text.Rd", replace `help()` with `utils::help()` to avoid warnings
  from more stringent `R CMD check`. Similarly, in "Rdpack-package.Rd" replace
  `packageDescription()` with `utils::packageDescription()`. This may
  be needed in `\Sexpr`'s more generally (__TODO:__ check if these would still
  be needed if the symbols are imported by the package.)


# Rdpack 0.9-0 (CRAN)

* some brush-up of the documentation for the changes since version 0.8-0 of the package.


# Rdpack 0.8-4

* now simple mathematics in BibTeX entries is rendered natively, no need to replace dollars
  with `\eqn{}`.


# Rdpack 0.8-3

* new macro `\printExample` for inclusion of example computations in narrative sections, such
  as `Details`. The code is evaluated and printed similarly to `R` sessions but the code is
  not prefixed and the output is prefixed with comment symbols, eg.
  ```
  2+2
  ##: 4
  ```

* new experimental macro `\runExamples` for use as top level section in an Rd
  file as a replacement of section `\examples`. `\runExamples{code}` evaluates
  the code and creates section `\examples` containing the code and the results
  (similarly to `\printExample`).  So, `\runExamples{2 + 2}` produces
  ```
  \examples{
  2 + 2
  ##: 4
  }
  ```
  The generated section `examples` is processed by R's documentation tools
  (almost) as if it was there from the outset.

* new experimental macro `\insertFig` to create a figure with `R` code and
  include it in the documentation. The related macro `\makeFig` just creates a
  graphics file, which can be included with the standard Rd command `\figure`.
  
* new vignette gives a brief description of the new macros.
  

# Rdpack 0.8-2

* Now text citations use "et al." when there are three or more authors. 
  (Issue#6 reported by Timothy P. Bilton)
  

# Rdpack 0.8-1

* in this file, added backticks to `\insertRef` and `\insertAllCited` (see
  below) - in the rendered `News` on CRAN the backslashed words had disappeared.


# Rdpack 0.8-0 (CRAN)

* `\insertRef` and `\insertAllCited` macros now support `bibstyles` for
  formatting references (feature requested by Jamie Halliday, issue#5). Use
  `Rdpack (>= 0.8)` in `Imports:` to use this feature. Currently only long
  author names are supported but complete support for styles can be added
  trivially if requested.
  
* updates to the documentation, in particular the bulk of Rdpack-package.Rd was
  from 2011!



# Rdpack 0.7-1

* improvements to handling of free form citations in textual mode:

* (bugfix) now the whole citation is not parenthesised in textual mode,
  
* the handling for textual mode was incomplete in that additional text after the
  citation was not put inside the parentheses along with the year.

* updates to the documentation.

* fix a bug in `Rdo_locate_core_section()`.


# Rdpack 0.7-0 (CRAN)

* consolidated the changes introduced since the previous CRAN release of Rdpack
  (it was 0.5-5) in preparation for the next release.  Users of the new macros
  for citation can use `Rdpack (>=0.7)` in the `Imports:` field of file
  "DESCRIPTION" to ensure that they are available.
  
* comprehensive overhaul of handling of errors and warnings during processing of
  references and citations. In particular, such errors should (in most cases)
  produce only warnings during `R CMD build` and `R CMD INSTALL`, and not
  prevent the package from being built and installed.

* Unresolved BibTeX keys produce warnings during building and installation of
  the package, but not errors. Dummy entries are inserted in the documentation
  explaining what was amiss (currently with 'author' A Adummy). 


# Rdpack 0.6-x

* new Rd macros for citations

* `\insertCite` inserts citation(s) for one or more keys and records the keys
  for `\insertAllCited` (see below).
	   
* `\insertCiteOnly` is similar to `\insertCite` but does not record the keys.
     
* `\insertNoCite` records the keys but does not produce a citation.

* `\insertAllCited` prints a bibliography including all references recorded by
  `\insertCite` and `\insertNoCite`.

* new entries in this file will use markdown syntax.

* updates to the documentation.


# Rdpack 0.5-7

* `get_bibentries()` gets a new argument "everywhere". When is is TRUE, the
   default, unescaped percents are escaped in all bibtex fields, otherwise the
   replacement is done only in field "URL".

* removed several `print()` statements which were accidentally left in the
  code in v. 0.5-6.

* updated help page of `get_bibentries()` and included examples.

* cleaned up the imports in NAMESPACE.


# Rdpack 0.5-6

* `insert_ref()` and Rd macro `\insertRef` should now work ok in the presence
  of percent encoded symbols in URL field of a BibTeX entry.  Closes issue
  "Unexpected END_OF_INPUT error (URL parsing?)", see 
  [Rdpack issue 3](https://github.com/GeoBosh/Rdpack/issues/3), raised by
  [jdnewmil](https://github.com/jdnewmil).

* `get_bibentries()` now takes care of percent encoded symbols in URLs.  It now
  returns an object from class "bibentryRd", which inherits from "bibentry" but
  has its own print method which escapes or unescapes the percent signs in URLs
  depending on the requested output style. This was also reported by by
  [jdnewmil](https://github.com/jdnewmil) in issue#3 referenced above.

* `get_bibentries()` now tries to load the `bib` file from the development
   directory of argument "package", in case it is in development mode under
   "devtools". (Even though the search is with `system.file()`, which `devtools`
   replaces with its own version, the bib file still needs to be looked for in
   "inst/", i.e. it is not in the root directory as is the case in installed
   packages.)


# Rdpack 0.5-5 (CRAN)

* Streamlined the help page of `reprompt()` and `Rdpack-package`.

* new argument, `edit', in `reprompt()` opens the Rd file after updating it.

* new function `ereprompt()` (`e' for _edit_)* opens `reprompt()` with suitable
  defaults to replace the original Rd file and open it in an editor, otherwise
  equivalent to `reprompt()`.

* now if `infile` does not exist, `reprompt()`, and hence `ereprompt()`, strips
  the directory part, finds the root of the package directory, and looks for the
  file under `man/` (this uses package `rprojroot`'). In particular, if the
  working directory is anywhere under the package root, `infile` can be simply
  the name of the Rd file, without path.

* now README.md is generated from README.org. I changed the layout and
     amended the information in it.

* README.* now get links to
     [georgisemacs](https://github.com/GeoBosh/georgisemacs) for an emacs
     function to `reprompt()` the Rd file at point.

* `viewRd()` now works also when the file is from a package under devtools'
  development mode on any platform (e.g. RStudio, Emacs/ESS, Rgui).


# Rdpack 0.5-4.9000

* new RStudio add-in 'Reprompt`, contributed by Duncan Murdoch.

  If the file being edited in the code editor is an Rd file it calls
  `reprompt()`. If the file is as R source file, it looks for the help page of a
  selected object name and works on it if found, otherwise creates one.


# Rdpack 0.5-4

* added the version of `Rdpack` to the abstract of the vignette.  This seems
  more informative than giving the compilation date.

* now `reprompt()` doesn't give spurious warnings about unknown Rd macros when
  the Rd file contains user defined Rd macros. These warnings were harmless and
  rare, but alarming and annoying.

* fixed a bug in `inspect_args()` which caused the warning _"In is.na(x) :
  is.na() applied to non-(list or vector) of type 'NULL'"_ in `reprompt()`, when
  the signature of a function in "Usage" section was empty.


# Rdpack 0.5-3 (CRAN)

* The warning message about a missing reference key now appears also in the
  respective help page.


# Rdpack 0.5-2

* added the github url to DESCRIPTION.

* now give a more informative warning if a key is missing from REFERENCES.bib
  (thanks to Kisung You for suggesting this).
     

# Rdpack 0.5-1 (CRAN)

* an example was not restoring the working directory.


# Rdpack 0.5-0

* moved gbRd from Depends to Imports and adjusted some examples to use
  `tools::parse_Rd()` rather than `parse_Rd()` (before this was not necessary
  since 'gbRd' _depended on_ 'tools').


# Rdpack 0.4-23

* new function `viewRd()` parses and shows an Rd file in a source package.  
  May be particularly helpful for devtools developers.

* revamped the vignette, added additional explanations of possible issues.

* new functions `makeVignetteReference()` and `vigbib()` generate Bibtex
  references for vignettes in a package.

# Rdpack 0.4-22 (CRAN)

* Added the requirement to **Import Rdpack** to the help page of
     `insert_ref()`.  (It was out of sync with the vignette.)

* Updated Description in DESCRIPTION, which was also out of sync with the
     vignette.

* Bug fix in the vignette: changed `\@references` to `@references` in the
     roxygen2 example.


# Rdpack 0.4-21 (CRAN)

* Edited and amended vignette _"Inserting_bibtex_references"_, including:
   
* additional explanation and an example,
	   
* requirement to import Rdpack and a mention of travis etc.
	   
* paragraph about devtools.

* changed the URL for parse_Rd.pdf in REFERENCES.bib to https.


# Rdpack 0.4-20 (CRAN)

* cleaned up some minor CRAN issues.


# Rdpack 0.4-19

* new facility for inserting references from BibTeX files - just put the line:

        RdMacros: Rdpack

  in the `DESCRIPTION` file of your package and the references in
  `inst/REFERENCES.bib`.  Then put `\inserRef{key}{yourpackage}` in
  documentation chunks to insert item `key` from the bib file. This works with
  both manually created Rd files and roxygen comments, see the documentation for
  details.


# Rdpack 0.4-18 (CRAN)

* from now on, put (CRAN) next to versions published on CRAN (as above)

* a minor correction in file NEWS.


# Rdpack 0.4-17

* In file DESCRIPTION, changed reprompt and rebib to `reprompt()` and
     `rebib()`.


# Rdpack 0.4-16

* don't export `parse_text`

* corrected bug in reprompt for S4 classes - new slots were not handled
  correctly (see `slots.R` for details).

* reprompt for S4 methods* if the methods documentation describes methods that
  do not exist, print an informative message for the user. (Such methods are
  also printed for debugging purposes but in non-user friendly form.)

- included `methods` in `Imports:` - around R-devel version 2015-07-01 r68620
  not including it triggers warnings)


# Rdpack 0.4-8

* new functions `.whichtageq` and `.whichtagin`; replaced most calls to
  `toolsdotdotdotRdTags` with these.

* removed `toolsdotdotdotRdTags`

# Rdpack 0.4-7

* removed `:::` calls from code; copied some functions from `tools` to achieve
  this (see "threedots.R"). Renamed the functions replacing `:::` with
  dotdotdot.

* export by name (not the generic export pattern); preparation for more
  selective export of functions in the future.

* new functions: `Rdo_get_argument_names`, `Rdo_get_item_labels`

# Rdpack 0.4-5

* dependence `bibtex` becomes "Imports".  `tools` and `gbRd` remain (for now)
  "Depends" since functions from them are used in some examples without
  `require()`'s.

* `rebib()`: now `outfile=""` can be used to request overwriting `infile`.
   (a small convenience; before the change, one could do this by giving the
   `outfile` and `infile` the same values.)

* Bug fix: `predefined.Rd` contained `\tabular` environments with vertical bars,
  `|`, in the format specification. This is not documented in "Writing R exts"
  but works for LaTeX and remained unnoticed by me and R CMD check. However,
  rendering the help page for the objects documented in "predefined.Rd" gave an
  error in html and text mode.  Package installation failed only if html was
  requested at build time.

* small changes in the documentation

# Rdpack 0.4-1

* new major feature: processing references from Bibtex files.  The top user
  level function is `rebib()`, which updates section "references" in an Rd
  file. `promptPackageSexpr()` has been updated to use this
  feature. `inspect_Rdbib()` can be used in programming.

* new auxiliary functions for work with `bibentry` objects.

* new convenience programming functions for Rd objects.

* some small bug fixes.

* some gaps in the documentation filled.


# Rdpack 0.3-11

* `reprompt()` was not handling properly S4 replacement methods. Changed the
   parsing of the arguments to rectify this. Some other functions also needed
   correction to handle this.

# Rdpack 0.3-10

* `Depends` field in DESCRIPTION file updated to require R 2.15.0 or later.
   (because of a few uses of `paste0()` in recent code.)

# Rdpack 0.3-8 (CRAN)

* first public version
