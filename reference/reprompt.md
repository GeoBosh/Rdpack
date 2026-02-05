# Update the documentation of a topic

Examine the documentation of functions, methods or classes and update it
with additional arguments, aliases, methods or slots, as appropriate.
This is an extention of the promptXXX() family of functions.

## Usage

``` r
reprompt(object, infile = NULL, Rdtext = NULL, final = TRUE, 
         type = NULL, package = NULL, methods = NULL, verbose = TRUE, 
         filename = NULL, sec_copy = TRUE, edit = FALSE, ...)
```

## Arguments

- object:

  the object whose documentation is to be updated, such as a string, a
  function, a help topic, a parsed Rd object, see \`Details'.

- infile:

  a file name containing Rd documentation, see \`Details'.

- Rdtext:

  a character string with Rd formatted text, see \`Details'.

- final:

  logical, if `TRUE` modifies the output of `prompt` so that the package
  can be built.

- type:

  type of topic, such as `"methods"` or `"class"`, see \`Details'.

- package:

  package name; document only objects defined in this package,
  especially useful for methods, see \`Details'.

- methods:

  used for documentation of S4 methods only, rarely needed even for
  them. This argument is passed on to
  [`promptMethods`](https://rdrr.io/r/methods/promptMethods.html), see
  its documentation for details.

- verbose:

  if `TRUE` print messages on the screen.

- filename:

  name of the file for the generated Rd content; if `NULL`, a suitable
  file name is generated, if `TRUE` it will be set to `infile`, if
  `FALSE` the Rd text is returned, see \`Details'.

- ...:

  currently not used.

- sec_copy:

  if `TRUE` copy Rd contents of unchanged sections in the result, see
  Details.

- edit:

  if `TRUE` call `file.edit` just before returning. This argument is
  ignored if `filename` is `FALSE`.

## Details

The typical use of `reprompt` is with one argument, as in

        reprompt(infile = "./Rdpack/man/reprompt.Rd")
        reprompt(reprompt)
        reprompt("reprompt")
      

`reprompt` updates the requested documentation and writes the new Rd
file in the current working directory. When argument `infile` is used,
the descriptions of all objects described in the input file are updated.
When an object or its name is given, `reprompt` looks first for
installed documentation and processes it in the same way as in the case
of `infile`. If there is no documentation for the object, `reprompt`
creates a skeleton Rd file similar to the one produced by the base R
functions from the `prompt` family (if `final = TRUE`, the default, it
modifies the output of
[`prompt()`](https://rdrr.io/r/utils/prompt.html), so that the package
can be built).

To document a function, say `myfun`, in an existing Rd file, just add
`myfun()` to the usage section in the file and call `reprompt()` on that
file. Put quotes around the function name if it is non-syntactic. For
replacement functions (functions with names ending in `<-`) `reprompt()`
will insert the proper usage statement. For example, if the signature of
`xxx<-` is `(x, ..., value)` then both, `"xxx<-"()` and `xxx() <- value`
will be replaced by `xxx(x, ...) <- value`.

For S4 methods and classes the argument "package" is often needed to
restrict the output to methods defined in the package of interest.

        reprompt("myfun-methods")

        reprompt("[<--methods", package = "mypackage")
        reprompt("[<-", type = "methods", package = "mypackage") # same

        reprompt("myclass", type = "class", package = "mypackage")
        reprompt("myclass-class", package = "mypackage")         # same
      

Without the "package" argument the reprompt for `"[<-"` would give all
methods defined by loaded packages at the time of the call.

Currently `reprompt` functionality is not implemented for topic
"package" but if `object` has the form "name-package" (or the equivalent
with argument `topic`) and there is no documentation for `package?name`,
`reprompt` calls
[`promptPackageSexpr`](https://geobosh.github.io/Rdpack/reference/promptPackageSexpr.md)
to create the required shell. Note that the shell produced by
`promptPackageSexpr` does not need \`reprompting' since the
automatically generated information is included by `\Sexpr`'s, not
literal strings.

Below are the details.

Typically, only one of `object`, `infile`, and `Rdtext` is supplied.
Warning messages are issued if this is not the case.

The object must have been made available by the time when `reprompt()`
is issued. If the object is in a package this is typically achieved by a
[`library()`](https://rdrr.io/r/base/library.html) command.

`object` may be a function or a name, as accepted by the `?` operator.
If it has the form "name-class" and "name-methods" a documentation shell
for class "name" or the methods for generic function "name" will be
examined/created. Alternatively, argument `type` may be set to "class"
or "methods" to achieve the same effect.

`infile` specifies a documentation file to be updated. If it contains
the documentation for one or more functions, `reprompt` examines their
usage statements and updates them if they have changed. It also adds
arguments to the "arguments" section if not all arguments in the usage
statements have entries there. If `infile` describes the methods of a
function or a class, the checks made are as appropriate for them. For
example, new methods and/or slots are added to the corresponding
sections.

It is all too easy in interactive use to forget to name the `infile`
argument, compare  
`reprompt("./man/reprompt.Rd")` vs.
`reprompt(infile = "./man/reprompt.Rd")`).  
A convenience feature is that if `infile` is missing and `object` is a
character string ending in ".Rd" and containing a forward slash (i.e. it
looks like Rd file in a directory), then it is taken to be `infile`.

`Rdtext` is similar to `infile` but the Rd content is taken from a
character vector.

If Rd content is supplied by `infile` or `Rdtext`, `reprompt` uses it as
a basis for comparison. Otherwise it tries to find installed
documentation for the object or topic requested. If that fails, it
resorts to one of the `promptXXX` functions to generate a documentation
shell. If that also fails, the requested object or topic does not exist.

If the above succeeds, the function examines the current definition of
the requested object(s), methods, or class and amends the documentation
with any additional items it finds.

For Rd objects describing one or more functions, the usage expressions
are checked and replaced, if they have changed. Arguments appearing in
one or more usage expressions and missing from section "Arguments" are
amended to it with content "Describe ..." and a message is printed.
Arguments no longer in the usage statements are NOT removed but a
message is issued to alert the user. Alias sections are inserted for any
functions with "usage" but without "alias" section.

If `filename` is a character string, it is used as is, so any path
should be included in the string. Argument `filename` usuallly is
omitted since the automatically generated file name is suitable in most
cases. Exceptions are functions with non-standard names (such as
replacement functions whose names end in `"<-"`) for which the generated
file names may not be acceptable on some operating systems.

If `filename` is missing or `NULL`, a suitable name is generated as
follows. If `infile` is supplied, `filename` is set to a file with the
same name in the current working directory (i.e. any path information in
`infile` is dropped). Otherwise, `filename` is obtained by appending the
name tag of the Rd object with `".Rd"`.

If `filename` is `TRUE`, it is set to `infile` or, if `infile` is
missing or `NULL`, a suitable name is generated as above. This can be
used to change `infile` in place.

If `filename` is `FALSE`, the Rd text is returned as a character vector
and not written to a file.

If `edit` is `TRUE`, the reprompted file is opened in an editor, see
also
[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
(\`e' for \`edit') which is like `reprompt` but has as default
`edit = TRUE` and some other related settings.

[`file.edit()`](https://rdrr.io/r/utils/file.edit.html) is used to call
the editor. Which editor is opened depends on the OS and on the user
configuration. RStudio users will probably prefer the 'Reprompt' add-in
or the underlying function
[`RStudio_reprompt`](https://geobosh.github.io/Rdpack/reference/RStudio_reprompt.md).
Emacs users would normally have set up `emacsclient` as their editor and
this is automatically done by EMACS/ESS (even on Windows).

If argument `sec_copy` is `TRUE` (the default), `reprompt` will,
effectively, copy the contents of (some) unchanged sections, thus
ensuring that they are exactly the same as in the original. This needs
additional work, since parsing an Rd file and then exporting the created
Rd object to an Rd file does not necessarilly produce an identical Rd
file (some escape sequences may be changed in the process, for example).
Even though the new version should be functionally equivalent to the
original, such changes are usually not desirable. For example, if such
changes creep into the Details section (which `reprompt` never changes)
the user may be annoyed or worried.

## Value

if `filename` is a character string or `NULL`, the name of the file to
which the updated shell was written.

Otherwise, the Rd text is returned as a character vector.

## Author

Georgi N. Boshnakov

## Note

The arguments of `reprompt` are similar to prompt, with some additions.
As in `prompt`, `filename` specifies the output file. In `reprompt` a
new argument, `infile`, specifies the input file containing the Rd
source.

When `reprompt` is used to update sources of Rd documentation for a
package, it is best to supply the original Rd file in argument `infile`.
Otherwise, if the original Rd file contains `\Sexpr` commands,
`reprompt` may not be able to recover the original Rd content from the
installed documentation. Also, the fields (e.g. the keywords) in the
installed documentation may not be were you expect them to be. (This may
be addressed in a future revision.)

While `reprompt` adds new items to the documentation, it never removes
existing content. It only issues a suggestion to remove an item, if it
does not seem necessary any more (e.g. a removed argument from a
function definition).

`reprompt` handles usage statements for S3 and S4 methods introduced
with any of the macros `\method`, `\S3method` and `\S4method`, as in
`\method{fun}{class}(args...)`. `reprompt` understands also subsetting
ans subassignment operators. For example, suppose that the `\arguments`
section of file "bracket.Rd" contains these directives (or any other
wrong signatures):

        \method{[}{ts}()
        \method{[[}{Date}()

Then `reprompt("./bracket.Rd")` will change them to

        \method{[}{ts}(x, i, j, drop = TRUE)
        \method{[[}{Date}(x, \dots, drop = TRUE)

This works for the assignment operators and functions, as well. For
example, any of these

        \method{`[<-`}{POSIXlt}()
        \method{[}{POSIXlt}(x, j) <- value

will be converted by `reprompt` to the standard form

        \method{[}{POSIXlt}(x, i, j) <- value

Note that the quotes in `` `[<-` `` above.

Usage statements for functions are split over two or more lines if
necessary. The user may edit them afterwards if the automatic splitting
is not appropriate, see below.

The usage section of Rd objects describing functions is left intact if
the usage has not changed. To force `reprompt` to recreate the usage
section (e.g. to reformat long lines), invalidate the usage of one of
the described functions by removing an argument from its usage
expression. Currently the usage section is recreated completely if the
usage of any of the described functions has changed. Manual formatting
may be lost in such cases.

## See also

[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md)
which by default calls the editor on the original file

## Examples

``` r
## note: usage of reprompt() is simple.  the examples below are bulky
##       because they simulate various usage scenarios with commands,
##       while in normal usage they would be due to editing.

## change to a temporary directory to avoid clogging up user's
cur_wd <- getwd()
tmpdir <- tempdir()
setwd(tmpdir)

## as for prompt() the default is to save in current dir as "seq.Rd".
## the argument here is a function, reprompt finds its doc and
## updates all objects described along with `seq'.
## (In this case there is nothing to update, we have not changed `seq'.)

fnseq <- reprompt(seq)
#> Rd source not supplied, looking for installed documentation.
#> Installed documentation found, processing it...
#>  The Rd content was written to file  seq.Rd 

## let's parse the saved Rd file (the filename is returned by reprompt)
rdoseq <- tools::parse_Rd(fnseq)   # parse fnseq to see the result.
Rdo_show(rdoseq)

## we replace usage statements with wrong ones for illustration.
## (note there is an S3 method along with the functions)
dummy_usage <- char2Rdpiece(paste("seq()", "\\method{seq}{default}()",
                   "seq.int()", "seq_along()", "seq_len()", sep="\n"),
                   "usage")
rdoseq_dummy <- Rdo_replace_section(rdoseq, dummy_usage)
Rdo_show(rdoseq_dummy)  # usage statements are wrong

reprompt(rdoseq_dummy, file = "seqA.Rd")
#> Processing the Rd object...
#>  The Rd content was written to file  seqA.Rd 
#> [1] "seqA.Rd"
Rdo_show(tools::parse_Rd("seqA.Rd"))  # usage ok after reprompt

## define function myseq() 
myseq <- function(from, to, x){
    if(to < 0) {
        seq(from = from, to = length(x) + to)
    } else seq(from, to)
}

## we wish to describe  myseq() along with seq();
##    it is sufficient to put myseq() in the usage section
##    and let reprompt() do the rest
rdo2 <- Rdo_modify_simple(rdoseq, "myseq()", "usage")
reprompt(rdo2, file = "seqB.Rd")  # updates usage of myseq
#> Processing the Rd object...
#>  The Rd content was written to file  seqB.Rd 
#> [1] "seqB.Rd"

## show the rendered result:
Rdo_show(tools::parse_Rd("seqB.Rd"))

## Run this if you wish to see the Rd file:
##   file.show("seqB.Rd")

reprompt(infile = "seq.Rd", filename = "seq2.Rd")
#> 
#> Parsing the Rd documentation in file seq.Rd ...
#>  The Rd content was written to file  seq2.Rd 
#> [1] "seq2.Rd"
reprompt(infile = "seq2.Rd", filename = "seq3.Rd")
#> 
#> Parsing the Rd documentation in file seq2.Rd ...
#>  The Rd content was written to file  seq3.Rd 
#> [1] "seq3.Rd"

## Rd objects for installed help may need some tidying for human editing.
#hseq_inst <- help("seq")
#rdo <- utils:::.getHelpFile(hseq_inst)
rdo <- Rdo_fetch("seq", "base")
rdo
#> List of 16
#>  $ :List of 1
#>   ..$ : chr "Sequence Generation"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 7 8 7 26 8 26
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\title"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 7 1 7 27 1 27
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "seq"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 6 7 6 9 7 9
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\name"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 6 1 6 10 1 10
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "seq"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 8 8 8 10 8 10
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\alias"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 8 1 8 11 1 11
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "seq.default"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 9 8 9 18 8 18
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\alias"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 9 1 9 19 1 19
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "seq.int"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 10 8 10 14 8 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\alias"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 10 1 10 15 1 15
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "seq_along"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 11 8 11 16 8 16
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\alias"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 11 1 11 17 1 17
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "seq_len"
#>   .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 12 8 12 14 8 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\alias"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 12 1 12 15 1 15
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 1
#>   ..$ : chr "manip"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 144 10 144 14 10 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\keyword"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 144 1 144 15 1 15
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 13
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 13 14 13 14 14 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  Generate regular sequences.  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 14 1 14 31 1 31
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 14 38 14 40 38 40
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 14 32 14 41 32 41
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is a standard generic with a\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 14 42 14 71 42 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  default method.  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 15 1 15 19 1 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq.int"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 15 26 15 32 26 32
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 15 20 15 33 20 33
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is a primitive which can be\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 15 34 15 62 34 62
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  much faster but has a few restrictions.  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 16 1 16 43 1 43
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq_along"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 16 50 16 58 50 58
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 16 44 16 59 44 59
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " and\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 16 60 16 64 60 64
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 17 1 17 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq_len"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 17 9 17 15 9 15
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 17 3 17 16 3 16
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " are very fast primitives for two common cases.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 17 17 17 64 17 64
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\description"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 13 1 18 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 17
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 19 8 19 8 8 8
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq("
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 20 1 20 4 1 4
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : list()
#>   .. ..- attr(*, "Rd_tag")= chr "\\dots"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 20 5 20 9 5 9
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ")\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 20 10 20 11 10 11
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 21 1 21 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "seq"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 22 9 22 11 9 11
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "default"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 22 14 22 20 14 20
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\method"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 22 1 22 21 1 21
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "(from = 1, to = 1, by = ((to - from)/(length.out - 1)),\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 22 22 22 77 22 77
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "    length.out = NULL, along.with = NULL, "
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 23 1 23 42 1 42
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : list()
#>   .. ..- attr(*, "Rd_tag")= chr "\\dots"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 23 43 23 47 43 47
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ")\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 23 48 23 49 48 49
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 24 1 24 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq.int(from, to, by, length.out, along.with, "
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 25 1 25 46 1 46
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : list()
#>   .. ..- attr(*, "Rd_tag")= chr "\\dots"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 25 47 25 51 47 51
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ")\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 25 52 25 53 52 53
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 26 1 26 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq_along(along.with)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 27 1 27 22 1 22
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq_len(length.out)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 28 1 28 20 1 20
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\usage"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 19 1 29 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 16
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 30 12 30 12 12 12
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 31 1 31 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : list()
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "\\dots"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 31 9 31 13 9 13
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "arguments passed to or from methods."
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 31 16 31 51 16 51
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\item"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 31 3 31 52 3 52
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 31 53 31 53 53 53
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 32 1 32 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "from, to"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 32 9 32 16 9 16
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 7
#>   .. .. ..$ : chr "the starting and (maximal) end values of the\n"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 32 19 32 63 19 63
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr "    sequence.  Of length "
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 1 33 25 1 25
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr "1"
#>   .. .. .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 32 33 32 32 32
#>   .. .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 26 33 33 26 33
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr " unless just "
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 34 33 46 34 46
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr "from"
#>   .. .. .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 53 33 56 53 56
#>   .. .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 47 33 57 47 57
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr " is supplied as\n"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 33 58 33 73 58 73
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr "    an unnamed argument."
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 34 1 34 24 1 24
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\item"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 32 3 34 25 3 25
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 34 26 34 26 26 26
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 35 1 35 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "by"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 35 9 35 10 9 10
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "number: increment of the sequence."
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 35 13 35 46 13 46
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\item"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 35 3 35 47 3 47
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 35 48 35 48 48 48
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 36 1 36 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "length.out"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 36 9 36 18 9 18
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 7
#>   .. .. ..$ : chr "desired length of the sequence.  A\n"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 36 21 36 55 21 55
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr "    non-negative number, which for "
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 1 37 35 1 35
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr "seq"
#>   .. .. .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 42 37 44 42 44
#>   .. .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 36 37 45 36 45
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr " and "
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 46 37 50 46 50
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ :List of 1
#>   .. .. .. ..$ : chr "seq.int"
#>   .. .. .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 57 37 63 57 63
#>   .. .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 51 37 64 51 64
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr " will be\n"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 37 65 37 73 65 73
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..$ : chr "    rounded up if fractional."
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 38 1 38 29 1 29
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\item"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 36 3 38 30 3 30
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 38 31 38 31 31 31
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 39 1 39 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "along.with"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 39 9 39 18 9 18
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "take the length from the length of this argument."
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 39 21 39 69 21 69
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\item"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 39 3 39 70 3 70
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 39 71 39 71 71 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\arguments"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 30 1 40 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 186
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 41 10 41 10 10 10
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  Numerical inputs should all be "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 42 1 42 33 1 33
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "finite"
#>   .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 42 40 42 45 40 45
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 42 34 42 46 34 46
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " (that is, not infinite,\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 42 47 42 71 47 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 1 43 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "NaN"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 15 43 17 15 17
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 9 43 18 9 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 3 43 19 3 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " or "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 20 43 23 20 23
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "NA"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 30 43 31 30 31
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 24 43 32 24 32
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ").\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 43 33 43 35 33 35
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 44 1 44 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  The interpretation of the unnamed arguments of "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 45 1 45 49 1 49
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 45 56 45 58 56 58
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 45 50 45 59 50 59
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " and\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 45 60 45 64 60 64
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 1 46 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq.int"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 9 46 15 9 15
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 3 46 16 3 16
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 17 46 20 17 20
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "not"
#>   .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 27 46 29 27 29
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\emph"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 21 46 30 21 30
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " standard, and it is recommended always to\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 46 31 46 73 31 73
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  name the arguments when programming.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 47 1 47 39 1 39
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 48 1 48 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 49 1 49 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 49 9 49 11 9 11
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 49 3 49 12 3 12
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is  generic, and only the default method is described here.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 49 13 49 73 13 73
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  Note that it dispatches on the class of the "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 50 1 50 46 1 46
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "first"
#>   .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 50 55 50 59 55 59
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\strong"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 50 47 50 60 47 60
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " argument\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 50 61 50 70 61 70
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  irrespective of argument names.  This can have unintended consequences\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 51 1 51 73 1 73
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  if it is called with just one argument intending this to be taken as\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 52 1 52 71 1 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 1 53 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "along.with"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 9 53 18 9 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 3 53 19 3 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ": it is much better to use "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 20 53 46 20 46
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq_along"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 53 53 61 53 61
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 47 53 62 47 62
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " in that\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 53 63 53 71 63 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  case.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 54 1 54 8 1 8
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 55 1 55 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 1 56 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq.int"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 9 56 15 9 15
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 3 56 16 3 16
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is an "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 17 56 23 17 23
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "internal generic"
#>   .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 30 56 45 30 45
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 24 56 46 24 46
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " which dispatches on\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 56 47 56 67 47 67
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  methods for "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 57 1 57 14 1 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "\"seq\""
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 57 21 57 25 21 25
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 57 15 57 26 15 26
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " based on the class of the first supplied\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 57 27 57 68 27 68
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  argument (before argument matching).\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 58 1 58 39 1 39
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 59 1 59 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  Typical usages are\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 60 1 60 21 1 21
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 6
#>   .. ..$ : chr "seq(from, to)\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 61 15 61 28 15 28
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr "seq(from, to, by= )\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 62 1 62 20 1 20
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr "seq(from, to, length.out= )\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 63 1 63 28 1 28
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr "seq(along.with= )\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 64 1 64 18 1 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr "seq(from)\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 65 1 65 10 1 10
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr "seq(length.out= )\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 66 1 66 18 1 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\preformatted"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 61 1 67 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 67 2 67 2 2 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  The first form generates the sequence "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 68 1 68 40 1 40
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 3
#>   .. ..$ : chr "from, from+/-1, "
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 68 47 68 62 47 62
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : list()
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\dots"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 68 63 68 67 63 67
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr ", to"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 68 68 68 71 68 71
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 68 41 68 72 41 72
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 68 73 68 73 73 73
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  (identical to "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 69 1 69 16 1 16
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "from:to"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 69 23 69 29 23 29
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 69 17 69 30 17 30
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ").\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 69 31 69 33 31 33
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 70 1 70 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  The second form generates "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 71 1 71 28 1 28
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "from, from+by"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 71 35 71 47 35 47
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 71 29 71 48 29 48
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ", "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 71 49 71 50 49 50
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : list()
#>   .. ..- attr(*, "Rd_tag")= chr "\\ldots"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 71 51 71 56 51 56
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ", up to the\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 71 57 71 68 57 68
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  sequence value less than or equal to "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 72 1 72 39 1 39
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "to"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 72 46 72 47 46 47
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 72 40 72 48 40 48
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".  Specifying "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 72 49 72 62 49 62
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ : chr "to -\n"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 72 69 72 73 69 73
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ : chr "  from"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 73 1 73 6 1 6
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 72 63 73 7 63 7
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " and "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 73 8 73 12 8 12
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "by"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 73 19 73 20 19 20
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 73 13 73 21 13 21
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " of opposite signs is an error.  Note that the\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 73 22 73 68 22 68
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  computed final value can go just beyond "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 74 1 74 42 1 42
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "to"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 74 49 74 50 49 50
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 74 43 74 51 43 51
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " to allow for\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 74 52 74 65 52 65
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  rounding error, but is truncated to "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 1 75 38 1 38
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "to"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 45 75 46 45 46
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 39 75 47 39 47
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".  ("
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 48 75 51 48 51
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "Just beyond"
#>   .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 60 75 70 60 70
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\sQuote"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 52 75 71 52 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 75 72 75 72 72 72
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  is by up to "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 1 76 14 1 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 2
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "10^{-10}"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 20 76 27 20 27
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "1e-10"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "VERB"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 30 76 34 30 34
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\eqn"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 15 76 35 15 35
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " times "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 36 76 42 36 42
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "abs(from - to)"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 49 76 62 49 62
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 43 76 63 43 63
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 76 64 76 66 64 66
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 77 1 77 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  The third generates a sequence of "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 78 1 78 36 1 36
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "length.out"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 78 43 78 52 43 52
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 78 37 78 53 37 53
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " equally spaced\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 78 54 78 69 54 69
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  values from "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 1 79 14 1 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "from"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 21 79 24 21 24
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 15 79 25 15 25
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " to "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 26 79 29 26 29
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "to"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 36 79 37 36 37
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 30 79 38 30 38
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".  ("
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 39 79 42 39 42
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "length.out"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 49 79 58 49 58
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 43 79 59 43 59
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is usually\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 79 60 79 71 60 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  abbreviated to "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 1 80 17 1 17
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "length"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 24 80 29 24 29
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 18 80 30 18 30
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " or "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 31 80 34 31 34
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "len"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 41 80 43 41 43
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 35 80 44 35 44
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ", and "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 45 80 50 45 50
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq_len"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 57 80 63 57 63
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 51 80 64 51 64
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " is much\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 80 65 80 73 65 73
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  faster.)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 81 1 81 11 1 11
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. [list output truncated]
#>   ..- attr(*, "Rd_tag")= chr "\\details"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 41 1 109 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 21
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 112 8 112 8 8 8
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 1 113 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq.int"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 9 113 15 9 15
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 3 113 16 3 16
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " and the default method of "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 17 113 43 17 43
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 50 113 52 50 52
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 44 113 53 44 53
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " for numeric\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 113 54 113 66 54 66
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  arguments return a vector of type "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 1 114 36 1 36
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "\"integer\""
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 43 114 51 43 51
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 37 114 52 37 52
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " or "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 53 114 56 53 56
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "\"double\""
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 63 114 70 63 70
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 57 114 71 57 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ":\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 114 72 114 73 72 73
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  programmers should not rely on which.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 115 1 115 40 1 40
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 116 1 116 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 1 117 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq_along"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 9 117 17 9 17
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 3 117 18 3 18
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " and "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 19 117 23 19 23
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "seq_len"
#>   .. .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 30 117 36 30 36
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 24 117 37 24 37
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " return an integer vector, unless\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 117 38 117 71 38 71
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  it is a "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 118 1 118 10 1 10
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "long vector"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 118 23 118 33 23 33
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 118 17 118 34 17 34
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\emph"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 118 11 118 35 11 35
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " when it will be double.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 118 36 118 60 36 60
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\value"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 112 1 119 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 6
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 121 13 121 13 13 13
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 122 1 122 57 1 57
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 123 1 123 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ : chr "The New S Language"
#>   .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 123 9 123 26 9 26
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\emph"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 123 3 123 27 3 27
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 123 28 123 29 28 29
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  Wadsworth & Brooks/Cole.\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 124 1 124 27 1 27
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\references"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 121 1 125 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 22
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 126 10 126 10 10 10
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  The methods "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 1 127 14 1 14
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "seq.Date"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 27 127 34 27 34
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 21 127 35 21 35
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 15 127 36 15 36
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr " and "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 37 127 41 37 41
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "seq.POSIXt"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 54 127 63 54 63
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 48 127 64 48 64
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 42 127 65 42 65
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 127 66 127 67 66 67
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 128 1 128 1 1 1
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 129 1 129 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr ":"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 129 15 129 15 15 15
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 129 9 129 16 9 16
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 129 3 129 17 3 17
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ",\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 129 18 129 19 18 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 130 1 130 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "rep"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 130 15 130 17 15 17
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 130 9 130 18 9 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 130 3 130 19 3 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ",\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 130 20 130 21 20 21
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 131 1 131 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "sequence"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 131 15 131 22 15 22
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 131 9 131 23 9 23
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 131 3 131 24 3 24
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ",\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 131 25 131 26 25 26
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 132 1 132 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "row"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 132 15 132 17 15 17
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 132 9 132 18 9 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 132 3 132 19 3 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ",\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 132 20 132 21 20 21
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "  "
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 133 1 133 2 1 2
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ :List of 1
#>   .. ..$ :List of 1
#>   .. .. ..$ : chr "col"
#>   .. .. .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 133 15 133 17 15 17
#>   .. .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. .. ..- attr(*, "Rd_tag")= chr "\\link"
#>   .. .. ..- attr(*, "srcref")= 'srcref' int [1:6] 133 9 133 18 9 18
#>   .. .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   .. ..- attr(*, "Rd_tag")= chr "\\code"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 133 3 133 19 3 19
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr ".\n"
#>   .. ..- attr(*, "Rd_tag")= chr "TEXT"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 133 20 133 21 20 21
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\seealso"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 126 1 134 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  $ :List of 8
#>   ..$ : chr "\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 135 11 135 11 11 11
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(0, 1, length.out = 11)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 136 1 136 27 1 27
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(stats::rnorm(20)) # effectively 'along'\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 137 1 137 44 1 44
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(1, 9, by = 2)     # matches 'end'\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 138 1 138 38 1 38
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(1, 9, by = pi)    # stays below 'end'\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 139 1 139 42 1 42
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(1, 6, by = 3)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 140 1 140 18 1 18
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(1.575, 5.125, by = 0.05)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 141 1 141 29 1 29
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..$ : chr "seq(17) # same as 1:17, or even better seq_len(17)\n"
#>   .. ..- attr(*, "Rd_tag")= chr "RCODE"
#>   .. ..- attr(*, "srcref")= 'srcref' int [1:6] 142 1 142 51 1 51
#>   .. .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>   ..- attr(*, "Rd_tag")= chr "\\examples"
#>   ..- attr(*, "srcref")= 'srcref' int [1:6] 135 1 143 1 1 1
#>   .. ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  - attr(*, "Rdfile")= chr "/tmp/R-4.5.2/src/library/base/man/seq.Rd"
#>  - attr(*, "class")= chr "Rd"
#>  - attr(*, "meta")=List of 2
#>   ..$ docType  : chr(0) 
#>   ..$ generator: chr ""
#>  - attr(*, "srcref")= 'srcref' int [1:6] 0 0 145 1 0 1
#>   ..- attr(*, "srcfile")=Class 'srcfile' <environment: 0x560846fafc38> 
#>  - attr(*, "prepared")= int 3
rdo <- Rdpack:::.Rd_tidy(rdo)          # tidy up (e.g. insert new lines
                                       #          for human readers)
reprompt(rdo) # rdo and rdoseq are equivalent
#> Processing the Rd object...
#>  The Rd content was written to file  seq.Rd 
#> [1] "seq.Rd"
all.equal(reprompt(rdo), reprompt(rdoseq)) # TRUE
#> Processing the Rd object...
#>  The Rd content was written to file  seq.Rd 
#> Processing the Rd object...
#>  The Rd content was written to file  seq.Rd 
#> [1] TRUE

## clean up 
unlink("seq.Rd")         # remove temporary files
unlink("seq2.Rd")
unlink("seq3.Rd")
unlink("seqA.Rd")
unlink("seqB.Rd")

setwd(cur_wd)            # restore user's working directory
unlink(tmpdir)
```
