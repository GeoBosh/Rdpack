# Insert a new element in an Rd object

Insert a new element at a given position in an Rd object.

## Usage

``` r
Rdo_insert_element(rdo, val, pos)
```

## Arguments

- rdo:

  an Rd object

- val:

  the content to insert.

- pos:

  position at which to insert `val`, typically an integer but may be
  anything accepted by the operator "\[\[".

## Details

`val` is inserted at position `pos`, between the elements at positions
`pos-1` and `pos`. If `pos` is equal to 1, `val` is prepended to `rdo`.
If `pos` is missing or equal to the length of `rdo`, `val` is appended
to `rdo`.

todo: allow vector `pos` to insert deeper into the object.

todo: character `pos` to insert at a position specified by "tag" for
example?

todo: more guarded copying of attributes?

## Value

an Rd object

## Author

Georgi N. Boshnakov
