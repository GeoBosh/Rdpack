# Get the text of the usage section of Rd documentation

Get the text of the usage section of Rd documentation.

## Usage

``` r
get_usage_text(rdo)
```

## Arguments

- rdo:

  an Rd object or a character string

## Details

If `rdo` is a string, it is parsed to obtain an Rd object.

The content of section "`\usage`" is extracted and converted to string.

## Value

a string

## Author

Georgi N. Boshnakov

## Note

todo: `get_usage_text` can be generalised to any Rd section but it is
better to use a different approach since `print.Rd()` does not take care
for some details (escaping %, for example). Also, the functions that use
this one assume that it returns R code, which may not be the case if the
usage section contains Rd comments.

## Examples

``` r
## get the Rd object documenting Rdo_macro
#h <- utils::help("Rdo_macro", lib.loc = .libPaths())
#rdo <- utils:::.getHelpFile(h)
rdo <- Rdo_fetch("Rdo_macro", "Rdpack")
# extract the usage section and print it:
ut <- get_usage_text(rdo)
cat(ut, sep = "\n")
#> 
#> Rdo_macro(x, name)
#> 
#> Rdo_macro1(x, name)
#> 
#> Rdo_macro2(x, y, name)
#> 
#> Rdo_item(x, y)
#> 
#> Rdo_sigitem(x, y, newline = TRUE)
```
