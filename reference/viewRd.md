# View Rd files in a source package

View Rd files in a source package.

## Usage

``` r
viewRd(infile, type = getOption("help_type"), stages = NULL)
```

## Arguments

- infile:

  name of an Rd file, a character string.

- type:

  one of `"text"` or `"html"`

- stages:

  a character vector specifying which stages of the R installation
  process to immitate. The default, `c("build", "install", "render")`,
  should be fine in most cases.

## Details

This function can be used to view Rd files from the source directory of
a package. The page is presented in text format or in html browser,
according to the setting of argument `type`. The default is
`getOption("help_type")`.

## Value

the function is used for the side effect of showing the help page in a
text help window or a web browser.

## Author

Georgi N. Boshnakov

## Note

Developers with `"devtools"` can use `viewRd()` instead of
[`help()`](https://rdrr.io/r/utils/help.html) for documentation objects
that contain Rd macros, such as `insertRef`, see vignette:

`vignette("Inserting_bibtex_references", package = "Rdpack")`.
