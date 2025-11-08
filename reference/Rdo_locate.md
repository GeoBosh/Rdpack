# Find positions of elements in an Rd object

Find positions of elements for which a function returns TRUE.
Optionally, apply another function to the selected elements and return
the results along with the positions.

## Usage

``` r
Rdo_locate(object, f = function(x) TRUE, pos_only = TRUE,
           lists = FALSE, fpos = NULL, nested = TRUE)
```

## Arguments

- object:

  an Rd object

- f:

  a function returning TRUE if an element is desired and FALSE
  otherwise.

- pos_only:

  if TRUE, return only the positions; if this argument is a function,
  return also the result of applying the function to the selected
  element, see Details.

- lists:

  if FALSE, examine only leaves, if TRUE, examine also lists, see
  Details.

- fpos:

  a function with two arguments, `object` and position, it is called and
  the value is returned along with the position, see Details.

- nested:

  a logical value, it has effect only when `lists` is TRUE, see
  \`Details'.

## Details

With the default setting of `lists = FALSE`, the function `f` is applied
to each leave (a character string) of the Rd object. If `lists = TRUE`
the function `f` is applied also to each branch (a list). In this case,
argument `nested` controls what happens when `f` returns TRUE. If
`nested` is TRUE, each element of the list is also inspected
recursively, otherwise this is not done and, effectively, the list is
considered a leaf. If `f` does not return TRUE, the value of `nested`
has no effect and the elements of the list are inspected.

The position of each object for which `f` returns TRUE is recorded as a
numeric vector.

`fpos` and `pos_only` provide two ways to do something with the selected
elements. Argument `fpos` is more powerful than `pos_only` but the
latter should be sufficient and simpler to use in most cases.

If `fpos` is a function, it is applied to each selected element with two
arguments, `object` and the position, and the result returned along with
the position. In this case argument `pos_only` is ignored. If `fpos` is
NULL the action depends on `pos_only`.

If `pos_only = TRUE`, `Rdo_locate` returns a list of such vectors (not a
matrix since the positions of the leaves are, in general, at different
depths).

If `pos_only` is a function, it is applied to each selected element and
the result returned along with the position.

## Value

a list with one entry for each selected element. Each entry is a numeric
vector or a list with two elements:

- pos:

  the position, a vector of positive integers,

- value:

  the result of applying the function to the element at `pos`.

## Author

Georgi N. Boshnakov

## Note

The following needs additional thought.

In some circumstances an empty list, tagged with `Rd_tag` may turn up,
e.g. [`list()`](https://rdrr.io/r/base/list.html) with `Rd_tag="\dots"`
in an `\arguments` section.

On the one hand this is a list. On the other hand it may be considered a
leaf. It is not clear if any attempt to recurse into such a list should
be made at all.

## See also

[`Rdo_sections`](https://geobosh.github.io/Rdpack/reference/Rdo_sections.md)
and
[`Rdo_locate_core_section`](https://geobosh.github.io/Rdpack/reference/Rdo_sections.md)
which locate top level sections

## Examples

``` r
# todo: put examples here!
```
