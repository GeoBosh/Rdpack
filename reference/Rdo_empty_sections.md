# Find or remove empty sections in Rd objects

Find or remove empty sections in Rd objects

## Usage

``` r
Rdo_empty_sections(rdo, with_bs = FALSE)

Rdo_drop_empty(rdo, sec = TRUE)
```

## Arguments

- rdo:

  an Rd object or Rd source text.

- with_bs:

  if `TRUE` return the section names with the leading backslash.

- sec:

  not used

## Details

The function `checkRd` is used to determine which sections are empty.

## Value

For `Rdo_empty_sections`, the names of the empty sections as a character
vector.

For `Rdo_drop_empty`, the Rd object stripped from empty sections.

## Author

Georgi N. Boshnakov

## Examples

``` r
dummyfun <- function(x) x
rdo8 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x,y)",
              value = "numeric vector",
              author = "",
              details = "",
              note = "",
              Rd_class=TRUE )

Rdo_empty_sections(rdo8)        # "details" "note"    "author"
#> [1] "details" "note"    "author" 

rdo8a <- Rdo_drop_empty(rdo8)
Rdo_empty_sections(rdo8a)       # character(0)
#> character(0)
```
