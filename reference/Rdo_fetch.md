# Get help pages as Rd objects

Get a help page as an Rd object from an installed or source package.

## Usage

``` r
Rdo_fetch(Rd_name = character(0), package, dir = ".", installed = TRUE)
```

## Arguments

- Rd_name:

  names of one or more Rd help pages. `name` here is the name of an Rd
  file stripped from the extension.

- package:

  the package from which to get the Rd object, a character string.

- dir:

  a character string giving the root directory of a source package. Used
  only if `package` is missing.

- installed:

  if `TRUE`, the default, the Rd object is taken unconditionally from
  the installed `package`. If `FALSE`, the help page may be taken from a
  source tree, if appropriate (typically if `package` is in
  \`developer's mode under devtools, see Details).

## Details

If `Rd_name` is a character string (typical use case), the corresponding
help page is returned as an object from class `"Rd"`. If the length of
`Rd_name` is greater than one, the result is a Rd_named list containing
the corresponding `"Rd"` objects. The default `Rd_name = character(0)`
requests all Rd pages in the package.

Note that `Rd_name` does not contain the extention `".Rd"` but the names
in the returned list do.

Argument `package` names the package from which to fetch the
documentation object. With the default `installed = TRUE` the object is
taken unconditionally from the installed package. To get it from the
source tree of a package, use argument `"dir"` instead. The default,
`""`, for `dir` is suitable for workflows where the working directory is
the root of the desired package.

Argument `installed` concerns primarily development under package
`"devtools"`. `"devtools"` intercepts and modifies several base R
commands, concerning access to system files and getting help, with the
aim of rerouting them to the source trees of packages under developer's
mode. If argument `installed` is `TRUE`, the default, the requested
pages are taken from the installed package, even if it is in development
mode. If argument `installed` is `FALSE`, the Rd objects are taken from
the corresponding source tree, if the specified package is under
developer's mode, and from the installed package otherwise.

Argument `Rd_name` is the name used in the `\name` section of Rd files.

When working off the source tree of a package, `Rdo_fetch` processes the
Rd files, so `roxygen2` users need to update them if necessary.

## Value

if `length(Rd_name) = 1`, an object of class `"Rd"`, otherwise a list of
`"Rd"` objects.

## Author

Georgi N. Boshnakov

## Examples

``` r
## get a single help page
rdo <- Rdo_fetch("viewRd", package = "Rdpack")
Rdo_show(rdo)

## get a list of help pages
rdo <- Rdo_fetch(c("viewRd", "reprompt"), package = "Rdpack")
names(rdo)
#> [1] "viewRd.Rd"   "reprompt.Rd"
```
