# Tensor comparison and asymmetric comparison between two vectors

Tensor comparison and asymmetric comparison between two vectors.

## Usage

``` r
.ocompare(x, y)

.asym_compare(x, y)
```

## Arguments

- x:

- y:

## Details

`.ocompare` (for "outer compare") returns a matrix whose (i,j)th element
is TRUE if x\[i\] is identical to y\[j\], and FALSE otherwise.

`.asym_compare` calls `.ocompare` and iterprets its result
asymmetrically. Elements of `x` that are not in `y` ae considered "new".
Similarly, Elements of `y` that are not in `x` ae considered "removed".
Elements that are in both are "common".

Todo: check if the above is correct or the other way round! !!!

## Value

For `.ocompare`, a matrix as described in Details.

For `.asym_compare` a list with indices as follows.

- i_new:

  new elements, indices in `x` of elements that are not in `y`.

- i_removed:

  removed elements, indices in `y` of elements that are not in `x`.

- i_common:

  common elements, indices in `x` of elements that are in both, `x` and
  `y`.

## Author

Georgi N. Boshnakov

## Examples

``` r
##---- Should be DIRECTLY executable !! ----
```
