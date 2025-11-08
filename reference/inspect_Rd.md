# Inspect and update an Rd object or file

Inspect and update an Rd object or file.

## Usage

``` r
inspect_Rd(rdo, package = NULL)

inspect_Rdfun(rdo, alias_update = TRUE)

inspect_Rdmethods(rdo, package = NULL)

inspect_Rdclass(rdo)
```

## Arguments

- rdo:

  an Rd object or file name

- package:

  name of a package

- alias_update:

  if `TRUE`, add missing alias entries for functions with usage
  statements.

## Details

These functions check if the descriptions of the objects in `rdo` are
consistent with their current definitions and update them, if necessary.
The details depend on the type of the documented topic. In general, the
functions update entries that can be produced programmatically, possibly
accompanied with a suggestion to the author to write some additional
text.

`inspect_Rd` checks the `\name` section of `rdo` and dispatches to one
of the other `inspect_XXX` functions depening on the type of the topic.

`inspect_Rdfun` processes documentation of functions. It checks the
usage entries of all functions documented in `rdo` and updates them if
necessary. It appends "`\alias`" entries for functions that do not have
them. Entries are created for any arguments that are missing from the
"`\arguments`" section. Warning is given for arguments in the
"`\arguments`" section that are not present in at least one usage entry.
`inspect_Rdfun` understands the syntax for S3 methods and S4 methods
used in "usage" sections, as well. The S4 methods may also be in a
section as produced by `promptMethods`.

`inspect_Rdmethods` checks and updates documentation of an S4 generic
function.

`inspect_Rdclass` checks and updates documentation of an S4 class.

Since method signatures and descriptions may be present in documentation
of a class, as well as in that of methods, the question arises where to
put "`\alias`" entries to avoid duplication. Currently, alias entries
are put in method descriptions.

## Author

Georgi N. Boshnakov
