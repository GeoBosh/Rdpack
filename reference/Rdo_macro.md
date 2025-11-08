# Format Rd fragments as macros (todo: a baffling title!)

Format Rd fragments as macros, generally by putting them in a list and
setting the "Rd_tag" as needed.

## Usage

``` r
Rdo_macro(x, name)

Rdo_macro1(x, name)

Rdo_macro2(x, y, name)

Rdo_item(x, y)

Rdo_sigitem(x, y, newline = TRUE)
```

## Arguments

- x:

  an object.

- y:

  an object.

- name:

  the "`Rd_tag`", a string.

- newline:

  currently ignored.

## Details

`Rdo_macro1` wraps `x` in a list with "`Rd_tag`" `name`. This is the
representation of Rd macros with one argument.

`Rdo_macro2` basically wraps a possibly transformed `x` and `y` in a
list with "`Rd_tag`" `name`. More specifically, if `x` has a non-NULL
"`Rd_tag`", `x` is wrapped in `list`. Otherwise `x` is left as is,
unless `x` is a character string, when it is converted to a text Rd
element and wrapped in `list`. `y` is processed in the same way. This is
the representation of Rd macros with two arguments.

`Rdo_macro` returns an object with "`Rd_tag`" `name`, constructed as
follows. If `x` is not of class "character", its attribute "`Rd_tag`" is
set to `name` and the result returned without further processing.
Otherwise, if it is of class "character", `x` is tagged as an Rd "TEXT"
element. It is then wrapped in a list but only if `name` is one of
"`\eqn`" or "`\deqn`". Finally, `Rdo_macro1` is called on the
transformed object.

`Rdo_item` is equivalent to `Rdo_macro2` with `name` set to "`\item`".

`Rdo_sigitem` is for items which have the syntax used in description of
signatures. In that case the first argument of "`\item`" is wrapped in
"`\code`". If `y` is missing, a text inviting the author to provide a
description of the function for this signature is inserted.

## Value

An Rd element with appropriately set `Rd_tag`, as described in
\`Details'.

## Author

Georgi N. Boshnakov
