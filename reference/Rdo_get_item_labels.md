# Get the labels of items in an Rd object

Get the labels of items in an Rd object.

## Usage

``` r
Rdo_get_item_labels(rdo)
```

## Arguments

- rdo:

  an Rd object.

## Details

`Rdo_get_item_labels(rdo)` gives the labels of all `"\item"`s in `rdo`.
Argument `rdo` is often a section or other Rd object fragment, see the
examples.

## Value

a character vector

## Author

Georgi N. Boshnakov

## Examples

``` r
infile <- system.file("examples", "tz.Rd", package = "Rdpack")
rd <- tools::parse_Rd(infile)

## get item labels found anywhere in the Rd object
(items <- Rdo_get_item_labels(rd))
#> [1] "x"           "y"           "type"        "flag"        "res"        
#> [6] "convergence"

## search only in section "arguments" (i.e., get argument names)
## (note [[1]] - there is only one arguments section)
pos.args <- Rdo_locate_core_section(rd, "\\arguments")[[1]]
(args <- Rdo_get_item_labels(rd[[pos.args$pos]]))
#> [1] "x"    "y"    "type" "flag"

## search only in section "value"
pos.val <- Rdo_locate_core_section(rd, "\\value")[[1]]
(vals <- Rdo_get_item_labels(rd[[pos.val$pos]]))
#> [1] "res"         "convergence"

## There are no other items in 'rd', so this gives TRUE:
all.equal(items, c(args, vals)) # TRUE
#> [1] TRUE
```
