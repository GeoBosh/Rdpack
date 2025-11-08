# Find the position of an "Rd_tag"

Find the position of an "Rd_tag".

## Usage

``` r
Rdo_get_insert_pos(rdo, tag)
```

## Arguments

- rdo:

  an Rd object

- tag:

  the "Rd_tag" to search for, a string

## Details

This function returns a position in `rdo`, where the next element
carrying "Rd_tag" `tag` should be inserted. The position is determined
as follows.

If one or more elements of `rdo` have "Rd_tag" `tag`, then the position
is one plus the position of the last such element.

If there are no elements with "Rd_tag" `tag`, the position is one plus
the length of `rdo`, unless `tag` is a known top level Rd section. In
that case, the position is such that the standard ordering of sections
in an Rd object is followed. This is set in the internal variable
`.rd_sections`.

## Value

an integer

## Author

Georgi N. Boshnakov

## Examples

``` r
#h <- help("Rdo_macro")
#rdo <- utils:::.getHelpFile(h)
rdo <- Rdo_fetch("Rdo_macro", "Rdpack")

ialias <- which(tools:::RdTags(rdo) == "\\alias")
ialias
#> [1] 3 4 5 6 7
next_pos <- Rdo_get_insert_pos(rdo, "\\alias") # 1 + max(ialias)
next_pos
#> [1] 8
stopifnot(next_pos == max(ialias) + 1)

ikeyword <- which(tools:::RdTags(rdo) == "\\keyword")
ikeyword
#> [1] 8
next_pos <- Rdo_get_insert_pos(rdo, "\\keyword") # 1 + max(ikeyword)
next_pos
#> [1] 9
stopifnot(next_pos == max(ikeyword) + 1)
```
