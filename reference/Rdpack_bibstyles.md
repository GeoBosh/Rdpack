# Set up a custom style for references in help pages

Set up a custom style for references in help pages.

## Usage

``` r
Rdpack_bibstyles(package, authors)
```

## Arguments

- package:

  the name of a package, a character string.

- authors:

  if equal to "LongNames", use full names of authors in reference lists,
  see Details.

## Details

This is the initial implementation of support for styles for lists of
bibliography references.

Currently setting `authors` to `"LongNames"` will cause the references
to appear with full names, eg John Smith rather than in the default
Smith J style.

Package authors can request this feature by adding the following line to
their `.onLoad` function (if their package has one):

        Rdpack::Rdpack_bibstyles(package = pkg, authors = "LongNames")

of just copy the following definition in a package that does not have
`.onLoad` :

        .onLoad <- function(lib, pkg){
            Rdpack::Rdpack_bibstyles(package = pkg, authors = "LongNames")
            invisible(NULL)
        }

After building and installing the package the references should be using
long names.

## Value

if called with no arguments, a list of the names of all styles.

if called with one argument (`package`) only, the name of the bib style,
a character string, requested by that package. The style is created if
hadn't been set up before. As a special case `package = ""` will return
the default Rdpack style.

if called with two arguments, the function set up a bibstyle as
discussed in section ‘Details’. It returns the name of that style.

## Author

Georgi N. Boshnakov
