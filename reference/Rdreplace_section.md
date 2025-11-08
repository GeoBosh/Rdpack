# Replace the contents of a section in one or more Rd files

Replace the contents of a section in one or more Rd files.

## Usage

``` r
Rdreplace_section(text, sec, pattern, path = "./man", exclude = NULL, ...)
```

## Arguments

- text:

  the replacement text, a character string.

- sec:

  the name of the section without the leading backslash, as for
  `Rdo_set_section`.

- pattern:

  regular expression for R files to process, see Details.

- path:

  the directory were to look for the Rd files.

- exclude:

  regular expression for R files to exclude, see Details.

- ...:

  not used.

## Details

`Rdreplace_section` looks in the directory specified by `path` for files
whose names match `pat` and drops those whose names match `exclude`.
Then it replaces section `sec` in the files selected in this way.

`Rdreplace_section` is a convenience function to replace a section (such
as a keyword or author) in several files in one go. It calls
[`Rdo_set_section`](https://geobosh.github.io/Rdpack/reference/Rdo_set_section.md)
to do the work.

## Value

A vector giving the full names of the processed Rd files, but the
function is used for the side effect of modifying them as described in
section Details.

## Author

Georgi N. Boshnakov

## See also

[`Rdo_set_section`](https://geobosh.github.io/Rdpack/reference/Rdo_set_section.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# replace the author in all Rd files except pkgname-package
Rdreplace_section("A. Author", "author", ".*[.]Rd$", exclude = "-package[.]Rd$")
} # }
```
