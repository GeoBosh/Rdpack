# Give the Rd tags at the top level of an Rd object

Give the Rd tags at the top level of an Rd object.

## Usage

``` r
Rdo_tags(rdo, nulltag = "")
```

## Arguments

- rdo:

  an Rd object.

- nulltag:

  a value to use when `Rd_tag` is missing or NULL.

## Details

The `"Rd_tag"` attributes of the top level elements of `rdo` are
collected in a character vector. Argument `nulltag` is used for elements
without that attribute. This guarantees that the result is a character
vector.

`Rdo_tags` is similar to the internal function `tools:::RdTags`. Note
that `tools:::RdTags` may return a list in the rare cases when attribute
`Rd_tags` is not present in all elements of `rdo`.

## Value

a character vector

## Author

Georgi N. Boshnakov

## See also

[`Rdo_which`](https://geobosh.github.io/Rdpack/reference/Rdo_which.md),
[`Rdo_which_tag_eq`](https://geobosh.github.io/Rdpack/reference/Rdo_which.md),
[`Rdo_which_tag_in`](https://geobosh.github.io/Rdpack/reference/Rdo_which.md)

## Examples

``` r
##---- Should be DIRECTLY executable !! ----
```
