# Inspect the usage section in an Rd object

Inspect the usage section in an Rd object.

## Usage

``` r
inspect_usage(rdo)
```

## Arguments

- rdo:

  an Rd object.

## Details

The usage section in the Rd object, `rdo`, is extracted and parsed. The
usage of each function described in `rdo` is obtained also from the
actual installed function and compared to the one from `rdo`.

The return value is a list, with one element for each function usage as
returned by `compare_usage1`.

One of the consequences of this is that an easy way to add a usage
description of a function, say `fu` to an existing Rd file is to simply
add a line `fu()` to the usage section of that file and run `reprompt`
on it.

## Value

a list of comparison results as described in \`Details' (todo: give more
details here)

## Author

Georgi N. Boshnakov

## See also

[`inspect_args`](https://geobosh.github.io/Rdpack/reference/inspect_args.md)
