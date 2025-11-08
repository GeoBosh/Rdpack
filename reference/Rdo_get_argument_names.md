# Get the names of arguments in usage sections of Rd objects

Get the names of arguments in usage sections of Rd objects.

## Usage

``` r
Rdo_get_argument_names(rdo)
```

## Arguments

- rdo:

  an Rdo object.

## Details

All arguments names in the "arguments" section of `rdo` are extracted.
If there is no such section, the results is a character vector of length
zero.

Arguments which have different descriptions for different OS'es are
included and not duplicated.

Arguments which have descriptions for a particular OS are included,
irrespectively of the OS of the running R process. (**todo:** introduce
argument to control this?)

## Value

a character vector

## Author

Georgi N. Boshnakov

## See also

[`Rdo_get_item_labels`](https://geobosh.github.io/Rdpack/reference/Rdo_get_item_labels.md)

## Examples

``` r
##---- Should be DIRECTLY executable !! ----
```
