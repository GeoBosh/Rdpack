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

in .onLoad(), the function is used purely to set up a bibstyle as
discussed in Details.

Internally, Rdpack uses it to extract styles set up by packages:

\- if called with argument `package` only, the style requested by that
package;

\- if called with no arguments, a list of all styles.

## Author

Georgi N. Boshnakov
