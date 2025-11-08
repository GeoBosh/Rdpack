# Parse expressions residing in character vectors

Parse expressions residing in character vectors.

## Usage

``` r
parse_text(text, ..., keep = TRUE)
```

## Arguments

- text:

  the text to parse, normally a character vector but can be anything
  that `parse` accepts for this artgument.

- ...:

  additional arguments to be passed on to `parse`.

- keep:

  required setting for option `keep.source`, see details.

## Details

This is like `parse(text=text,...)` with the additional feature that if
the setting of option "keep.source" is not as requested by argument
`keep`, it is set to `keep` before calling `parse` and restored
afterwards.

This function is no longer exported by Rdpack since it is here for
historical reasons and to avoid unnecessary dependence on gbutils. Use
the equivalent `gbutils::parse_text` instead.

## Value

an expression representing the parsed text, see `link{parse}` for
details

## Author

Georgi N. Boshnakov

## Note

The usual setting of option "keep.source" in interactive sessions is
TRUE. However, in \`R CMD check' it is FALSE.

As a consequence, examples from the documentation may run fine when
copied and pasted in an R session but (rightly) fail \`R CMD check',
when they depend on option "keep.source" being `TRUE`.

## See also

[`parse`](https://rdrr.io/r/base/parse.html), `parse_text` in package
gbutils
