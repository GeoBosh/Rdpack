# Insert or remove content in an Rd fragment

Insert or remove content in an Rd fragment.

## Usage

``` r
Rdo_flatinsert(rdo, val, pos, before = TRUE)

Rdo_flatremove(rdo, from, to)
```

## Arguments

- rdo:

  an Rd object.

- val:

  the value to insert.

- pos:

  position.

- before:

  if TRUE, insert the new content at pos, pushing the element at pos
  forward.

- from:

  beginning of the region to remove.

- to:

  end of the region to remove.

## Details

`Rdo_flatinsert` inserts `val` at position `pos`, effectively by
concatenation.

`Rdo_flatremove` removes elements from `from` to `to`.

## Value

the modified `rdo`

## Author

Georgi N. Boshnakov
