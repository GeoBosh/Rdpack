# Insert a new element in an Rd object possibly surrounding it with new lines

Insert a new element in an Rd object possibly surrounding it with new
lines.

## Usage

``` r
Rdo_insert(rdo, val, newline = TRUE)
```

## Arguments

- rdo:

  an Rd object

- val:

  the content to insert, an Rd object.

- newline:

  a logical value, controls the insertion of new lines before and after
  `val`, see \`Details'.

## Details

Argument `val` is inserted in `rdo` at an appropriate position, see
[`Rdo_get_insert_pos`](https://geobosh.github.io/Rdpack/reference/Rdo_get_insert_pos.md)
for detailed explanation.

If `newline` is TRUE, newline elements are inserted before and after
`val` but only if they are not already there.

Typically, `val` is a section of an Rd object and `rdo` is an Rd object
which is being constructed or modified.

## Value

an Rd object

## Author

Georgi N. Boshnakov
