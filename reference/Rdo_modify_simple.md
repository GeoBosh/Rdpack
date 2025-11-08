# Simple modification of Rd objects

Simple modification of Rd objects.

## Usage

``` r
Rdo_modify_simple(rdo, text, section, ...)
```

## Arguments

- rdo:

  an Rd object.

- text:

  a character vector

- section:

  name of an Rd section, a string.

- ...:

  additional arguments to be passed to `Rdo_modify`.

## Details

Argument `text` is used to modify (as a replacement of or addition to)
the content of section `section` of `rdo`.

This function can be used for simple modifications of an Rd object using
character content without converting it separately to Rd.

`text` is converted to Rd with `char2Rdpiece(text, section)`. The result
is passed to `Rdo_modify`, together with the remaining arguments.

## Value

an Rd object

## Author

Georgi N. Boshnakov

## See also

[`Rdo_modify`](https://geobosh.github.io/Rdpack/reference/Rdo_modify.md)
