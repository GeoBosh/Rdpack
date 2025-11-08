# Replace or modify parts of Rd objects

Replace or modify parts of Rd objects.

## Usage

``` r
Rdo_modify(rdo, val, create = FALSE, replace = FALSE, top = TRUE)

Rdo_replace_section(rdo, val, create = FALSE, replace = TRUE)
```

## Arguments

- rdo:

  an Rd object.

- val:

  an Rd fragment.

- create:

  if TRUE, create a new section, see \`Details'.

- replace:

  a logical, if TRUE `val` replaces the old content, otherwise `val` is
  concatenated with it, see \`Details'.

- top:

  a logical, if TRUE examine also the "Rd_tag" of `rdo`, see \`Details'.

## Details

Argument `rdo` is an Rd object (complete or a fragment) to be modified.
`val` is an Rd fragment to use for modification.

Basically, `val` is appended to (if `replace` is FALSE) or replaces (if
`replace` is TRUE) the content of an element of `rdo` which has the same
"Rd_tag" as `val`.

Argument `top` specifies whether to check the "Rd_tag" of `rdo` itself,
see below.

Here are the details.

If `top` is TRUE and `rdo` and `val` have the same (non-NULL) "Rd_tag",
then the action depends on `replace` (argument `create` is ignored in
this case). If `replace` is TRUE, `val` is returned. Otherwise `rdo` and
`val` are, effectively, concatenated. For example, `rdo` may be the
"arguments" section of an Rd object and `val` may also be an "arguments"
section containing new arguments.

Otherwise, an element with the "Rd_tag" of `val` is searched in `rdo`
using `tools:::RdTags()`. If such elements are found, the action again
depends on `replace`.

1.  If `replace` is a character string, then the first element of `rdo`
    that is a list whose only element is identical to the value of
    `replace` is replaced by `val`. If such an element is not present
    and `create` is TRUE, `val` is inserted in `rdo`. If `create` is
    FALSE, `rdo` is not changed.

2.  If `replace` is TRUE, the first element found is replaced with
    `val`.

3.  If `replace` is FALSE, `val` is appended to the first element found.

If no element with the "Rd_tag" of `val` is found the action depends on
`create`. If `create` is TRUE, then `val` is inserted in `rdo`,
effectively creating a new section. If `create` is FALSE, an error is
thrown.

`Rdo_replace_section` is like `Rdo_modify` with argument `top` fixed to
TRUE and the default for argument `replace` set to TRUE. It hardly makes
sense to call `Rdo_replace_section` with `replace = FALSE` but a
character value for it may be handy in some cases, see the examples.

## Value

an Rd object or fragment, as described in \`Details'

## Author

Georgi N. Boshnakov

## Examples

``` r
# a <- tools::parse_Rd("./man/promptUsage.Rd")
# char2Rdpiece("documentation", "keyword")

# this changes a keyword from Rd to documentation
# Rdo_replace_section(a, char2Rdpiece("documentation", "keyword"), replace = "Rd")
```
