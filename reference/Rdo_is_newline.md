# Check if an Rd fragment represents a newline character

Check if an Rd fragment represents a newline character

## Usage

``` r
Rdo_is_newline(rdo)
```

## Arguments

- rdo:

  an Rd object

## Details

This is a utility function that may be used to tidy up Rd objects.

It returns TRUE if the Rd object represents a newline character, i.e. it
is a character vector of length one containing the string `"\n"`.
Attributes are ignored.

Otherwise it returns FALSE.

## Value

TRUE or FALSE

## Author

Georgi N. Boshnakov
