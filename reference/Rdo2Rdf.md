# Convert an Rd object to Rd file format

Converts an Rd object to Rd format and saves it to a file or returns it
as a character vector. It escapes percents where necessary and
(optionally) backslashes in the examples section.

## Usage

``` r
Rdo2Rdf(rdo, deparse = FALSE, ex_restore = FALSE, file = NULL,
        rcode = TRUE, srcfile = NULL)
```

## Arguments

- rdo:

  an Rd object or a character vector, see \`Details'.

- deparse:

  logical, passed to the print method for Rd objects, see \`Details'.

- ex_restore:

  logical, if `TRUE` escapes backslashes where necessary.

- file:

  a filename where to store the result. If `NULL` or "missing", the
  result is returned as a character vector.

- rcode:

  if TRUE, duplicate backslahes in RCODE elements, see Details.

- srcfile:

  NULL or a file name, see 'Details'.

## Details

The description here is rather technical and incomplete. In any case it
concerns almost exclusively Rd files which use escape sequences
containing multiple consecutive backslashes or escaped curly braces
(such things appear in regular expressions, for example).

In principle, this function should be redundant, since the `print` and
`as.character` methods for objects of class "Rd" would be expected to do
the job. I was not able to get the desired result that way (the
`deparse` option to `print` did not work completely for me either).

Arguments `ex_restore` and `rcode` were added on an ad-hoc basis.
`rcode` is more recent and causes `Rdo2Rdf` to duplicate backslashes
found in any element `Rd_tag`-ed with "RCODE". `ex_restore` does the
same but only for the examples section. In effect, if `rcode` is TRUE,
`ex_restore` is ignored.

The initial intent of this function (and the package Rdpack as a whole
was not to refer to the Rd source file. However, there is some
flexibility in the Rd syntax that does not allow the source file to be
restored identically from the parsed object. This concerns mainly
backslahes (and to some extent curly braces) which in certain contexts
may or may not be escaped and the parsed object is the same. Although
this does not affect functionality, it may be annoying if the escapes in
sections not examined by `reprompt` were changed.

If `srcfile` is the name of a file, the file is parsed and the Rd text
of sections of `rdo` that are identical to sections from `srcfile` is
taken directly from `srcfile`, ensuring that they will be identical to
the original.

## Value

`NULL`, if `file` is not `NULL`. Otherwise the Rd formatted text as a
character vector.

## Author

Georgi N. Boshnakov

## Note

Here is an example when the author's Rd source cannot be restored
exactly from the parsed object.

In the Rd source "author" has two backslashes here: `\author`.

In the Rd source "author" has one backslash here: `\author`.

Both sentences are correct and the parsed file contains only one
backslash in both cases. If `reprompt` looks only at the parsed object
it will export one backslash in both cases. So, further reprompt()-ing
will not change them again. This is if `reprompt` is called with
`sec_copy = FALSE`. With the default `sec_copy = TRUE`, `reprompt` calls
`Rdo2Rdf` with argument `srcfile` set to the name of the Rd file and
since `reprompt` does not modify section "Note", its text is copied from
the file and the author's original preserved.

However, the arguments of `\eqn` are parse_Rd-ed differently (or so it
seems) even though they are also in verbatim.

## Examples

``` r
# # this keeps the backslashes in "author" (see Note above)
# reprompt(infile="./man/Rdo2Rdf.Rd")

# # this outputs "author" preceded by one backslash only.
# reprompt(infile="./man/Rdo2Rdf.Rd", sec_copy = FALSE)
```
