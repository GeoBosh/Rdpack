# Parse usage text

Parse usage text.

## Usage

``` r
parse_1usage_text(text)
parse_usage_text(text)
```

## Arguments

- text:

  conceptually, the content of the usage section of one or more Rd
  objects, a character vector, see Details.

## Details

For `parse_usage_text`, `text` is a character vector representing the
contents of the usage section of an Rdo object. `parse_usage_text` does
some preprocessing of `text` then calls `parse_1usage_text` for each
usage statement.

The preprocessing changes "`\``dots`" to "`...`" and converts S3- and
S4-method descriptions to a form suitable for
[`parse()`](https://rdrr.io/r/base/parse.html). The text is then parsed
(with `parse`) and "`srcref`" attribute removed from the parsed object.

todo: currently no checks is made for Rd comments in `text`.

`parse_1usage_text` processes the usage statement of one object and
calls
[`pairlist2f_usage1`](https://geobosh.github.io/Rdpack/reference/parse_pairlist.md)
to convert it to an object from S3 class `"f_usage"`.

## Value

for `parse_1usage_text`, an object from S3 class `"f_usage"`, see
[`pairlist2f_usage1`](https://geobosh.github.io/Rdpack/reference/parse_pairlist.md)
for its structure.

for `parse_usage_text`, a list containing one element for each usage
entry, as prepared by `parse_1usage_text`

## Author

Georgi N. Boshnakov
