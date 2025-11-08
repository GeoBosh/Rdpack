# Parse Rd source text as the contents of a section

Parse Rd source text as the contents of a given section.

## Usage

``` r
parse_Rdtext(text, section = NA)
```

## Arguments

- text:

  Rd source text, a character vector.

- section:

  the section name, a string.

## Details

If `section` is given, then `parse_Rdtext` parses `text` as appropriate
for the content of section `section`. This is achieved by inserting
`text` as an argument to the TeX macro `section`. For example, if
`section` is "`\usage`", then a line "`\usage{`" is inserted at the
begiinning of `text` and a closing "`}`" at its end.

If `section` is NA then `parse_Rdtext` parses it without preprocessing.
In this case `text` itself will normally be a complete section fragment.

## Value

an Rd fragment

## Author

Georgi N. Boshnakov

## Note

The text is saved to a temporary file and parsed using `parse_Rd`. This
is done for at least two reasons. Firstly, `parse_Rd` works most
reliably (at the time of writing this) from a file. Secondly, the saved
file may be slightly different (escaped backslashes being the primary
example). It would be a nightmare to ensure that all concerned functions
know if some Rd text is read from a file or not.

The (currently internal) function `.parse_Rdlines` takes a character
vector, writes it to a file (using `cat`) and calls `parse_Rd` to parse
it.

## See also

[`parse_Rdpiece`](https://geobosh.github.io/Rdpack/reference/parse_Rdpiece.md)
