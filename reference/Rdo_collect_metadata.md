# Collect aliases or other metadata from an Rd object

Collect aliases or other metadata from an Rd object.

## Usage

``` r
Rdo_collect_aliases(rdo)

Rdo_collect_metadata(rdo, sec)
```

## Arguments

- rdo:

  an Rd object

- sec:

  the kind of metadata to collect, a character string, such as "alias"
  and "keyword".

## Details

`Rdo_collect_aliases` finds all aliases in `rdo` and returns them as a
named character vector. The name of an alias is usually the empty
string, `""`, but it may also be "windows" or "unix" if the alias is
wrapped in a `#ifdef` directive with the corresponding first argument.

`Rdo_collect_metadata` is a generalisation of the above. It collects the
metadata from section(s) `sec`, where `sec` is the name of a section
without the leading backslash. `sec` is assumed to be a section
containing a single word, such as "keyword", "alias", "name".

Currently `Rdo_collect_metadata` is not exported.

## Value

a named character vector, as described in Details.

## Author

Georgi N. Boshnakov

## See also

`tools:::.Rd_get_metadata`

## Examples

``` r
## this example originally (circa 2012) was:
##     infile <- file.path(R.home(), "src/library/base/man/timezones.Rd")
## but the OS conditional alias in that file has been removed.
## So, create an artificial example:
infile <- system.file("examples", "tz.Rd", package = "Rdpack")

## file.show(infile)
rd <- tools::parse_Rd(infile)

## The functions described here handle "ifdef" and similar directives.
## This detects OS specific aliases (windows = "onlywin" and unix = "onlyunix"):
Rdo_collect_aliases(rd)
#>                                     windows       unix 
#>       "a1"       "a2"       "a3"  "onlywin" "onlyunix" 
Rdpack:::Rdo_collect_metadata(rd, "alias") # same
#>                                     windows       unix 
#>       "a1"       "a2"       "a3"  "onlywin" "onlyunix" 

## In contrast, the following do not find "onlywin" and "onlyunix":
sapply(rd[which(tools:::RdTags(rd)=="\alias")], as.character)
#> list()
tools:::.Rd_get_metadata(rd, "alias")
#> [1] "a1" "a2" "a3"

Rdpack:::Rdo_collect_metadata(rd, "name")
#>            
#> "dummyfun" 
Rdpack:::Rdo_collect_metadata(rd, "keyword")
#>             
#> "kw1" "kw2" 
```
