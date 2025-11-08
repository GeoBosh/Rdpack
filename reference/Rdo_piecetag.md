# Give information about Rd elements

Give information about Rd elements.

## Usage

``` r
Rdo_piecetag(name)

Rdo_sectype(x)

is_Rdsecname(name)
```

## Arguments

- name:

  the name of an Rd macro, a string.

- x:

  the name of an Rd macro, a string.

## Details

`Rdo_piecetag` gives the "Rd_tag" of the Rd macro `name`.

`Rdo_sectype` gives the "Rd_tag" of the Rd section `x`.

`is_Rdsecname(name)` returns TRUE if `name` is the name of a top level
Rd section.

The information returned by these functions is obtained from the
charater vectors `Rdo_piece_types` and `Rdo_predefined_sections`.

## Author

Georgi N. Boshnakov

## See also

[`Rdo_piece_types`](https://geobosh.github.io/Rdpack/reference/predefined.md)
and
[`Rdo_predefined_sections`](https://geobosh.github.io/Rdpack/reference/predefined.md)

## Examples

``` r
Rdo_piecetag("eqn")  # ==> "VERB"
#> [1] "VERB"
Rdo_piecetag("code") # ==> "RCODE"
#> [1] "RCODE"

Rdo_sectype("usage") # ==> "RCODE"
#> [1] "RCODE"
Rdo_sectype("title") # ==> "TEXT"
#> [1] "TEXT"

Rdo_sectype("arguments")
#> [1] "TEXT"
```
