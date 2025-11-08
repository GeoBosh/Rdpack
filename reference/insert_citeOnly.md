# Generate citations from bibtex keys

Generate citations from bibtex keys.

## Usage

``` r
insert_citeOnly(keys, package = NULL, before = NULL, after = NULL,
                bibpunct = NULL, ..., cached_env = NULL,
                cite_only = FALSE, dont_cite = FALSE)
```

## Arguments

- keys:

  a character string containing bibtex key(s) prefixed with the symbol
  `@`, intermixed with free text. The format is the same as for Rd macro
  `\insertCite`. Put `;textual` at the end of the string to get a
  textual citation. Similarly, `;nobrackets` requests parenthesised
  citation without the enclosing parentheses. Alternatively, `keys` can
  contain one or more keys, separated by commas.

- package:

  name of an R package.

- before:

  see [`citeNatbib`](https://rdrr.io/r/utils/cite.html).

- after:

  see [`citeNatbib`](https://rdrr.io/r/utils/cite.html).

- bibpunct:

  see [`citeNatbib`](https://rdrr.io/r/utils/cite.html).

- ...:

  further arguments; for internal use.

- cached_env:

  for internal use.

- cite_only:

  for internal use.

- dont_cite:

  for internal use.

## Details

This is the function behind `\insertCite` and related macros. Argument
`"keys"` has the syntax of the first argument of `\insertCite`, see
[`insertRef`](https://geobosh.github.io/Rdpack/reference/insert_ref.md)
for full details.

## Value

a character vector containing the references with Rd markup

## Author

Georgi N. Boshnakov

## See also

[`insert_ref`](https://geobosh.github.io/Rdpack/reference/insert_ref.md)
for description of all available Rd macros

## Examples

``` r
insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd", package = "Rdpack")
#> [1] "(see also Boshnakov and Putman 2020 and Murdoch 2010)"
## (see also Boshnakov and Putman 2020 and Murdoch 2010)

insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd;nobrackets",
  package = "Rdpack")
#> [1] "see also Boshnakov and Putman 2020 and Murdoch 2010"
## see also Boshnakov and Putman 2020 and Murdoch 2010

insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd;textual",
  package = "Rdpack")
#> [1] "see also Boshnakov and Putman (2020) and Murdoch (2010)"
## see also Boshnakov and Putman (2020) and Murdoch (2010)
```
