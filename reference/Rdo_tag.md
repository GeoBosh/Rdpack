# Set the Rd_tag of an object

Set the Rd_tag of an object.

## Usage

``` r
Rdo_comment(x = "%%")

Rdo_tag(x, name)

Rdo_verb(x)

Rdo_Rcode(x)

Rdo_text(x)

Rdo_newline()
```

## Arguments

- x:

  an object, appropriate for the requested Rd_tag.

- name:

  the tag name, a string.

## Details

These functions simply set attribute "`Rd_tag`" of `x`, effectively
assuming that the caller has prepared it as needed.

`Rdo_tag` sets the "`Rd_tag`" attribute of `x` to `name`. The other
functions are shorthands with a fixed name and no second argument.

`Rdo_comment` tags an Rd element as comment.

`Rdo_newline` gives an Rd element representing an empty line.

## Value

`x` with its "`Rd_tag`" set to `name` (`Rdo_tag`), "TEXT" (`Rdo_text`),
"VERB" (`Rdo_verb`) or "RCODE" (`Rdo_Rcode`).

## Author

Georgi N. Boshnakov
