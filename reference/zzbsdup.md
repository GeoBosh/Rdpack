# Escape backslashes and percent in Rd code

Escape backslashes and percent in Rd code.

## Usage

``` r
.bspercent(x)

.anypercent(x)
```

## Arguments

- x:

  a character string

## Details

`.bsdup(x)` duplicates backslashes.

`.bspercent(x)` escapes percent signs.

`.anypercent(x)` also escapes percent signs but but only if the `Rd_tag`
attribute of `x` is not COMMENT.

## Author

Georgi N. Boshnakov

## Examples

``` r
##---- Should be DIRECTLY executable !! ----
```
