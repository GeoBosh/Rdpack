# Convert an Rd object to text and show it

Render an Rd object as text and show it.

## Usage

``` r
Rdo_show(rdo)
```

## Arguments

- rdo:

  an Rd object

## Details

`Rdo_show` renders the help page represented by `rdo` as text and shows
it with [`file.show()`](https://rdrr.io/r/base/file.show.html).

`Rdo_show` is a simplified front end to `utils::Rd2txt`. See
[`viewRd`](https://geobosh.github.io/Rdpack/reference/viewRd.md) for
more complete rendering, including of references and citations.

## Value

Invisible `NULL`. The function is used for the side effect of showing
the text representation of `rdo`.

## Author

Georgi N. Boshnakov

## See also

[`viewRd`](https://geobosh.github.io/Rdpack/reference/viewRd.md)

## Examples

``` r
## create a minimal Rd object
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class = TRUE )
if (FALSE) { # \dontrun{
## run this interactively:    
Rdo_show(u1)
} # }
```
