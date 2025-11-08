# Remove srcref attributes from Rd objects

Removes srcref attributes from Rd objects.

## Usage

``` r
Rdo_remove_srcref(rdo)
```

## Arguments

- rdo:

  an Rd object

## Details

`srcref` attrbutes (set by `parse_Rd`) may be getting in the way during
manipulation of Rd objects, such as comparisons, addition and
replacement of elements. This function traverses the argument and
removes the `srcref` attribute from all of its elements.

## Value

an Rd object with no srcref attributes.

## Author

Georgi N. Boshnakov
