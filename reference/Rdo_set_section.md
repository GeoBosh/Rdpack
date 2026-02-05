# Replace a section in an Rd file

Replace a section in an Rd file.

## Usage

``` r
Rdo_set_section(text, sec, file, ...)
```

## Arguments

- text:

  the new text of the section, a character vector.

- sec:

  name of the section.

- file:

  name of the file.

- ...:

  arguments to be passed on to `Rdo_modify`.

## Details

Parses the file, replaces the specified section with the new content and
writes the file back. The text is processed as appropriate for the
particular section (`sec`).

For example:

`Rdo_set_section("Georgi N. Boshnakov", "author", "./man/Rdo2Rdf.Rd")`

(Some care is needed with the author field for "xxx-package.Rd" files,
such as "Rdpack-package.Rd", where the `Author(s)` field has somewhat
different layout.)

By default `Rdo_set_section` does not create the section if it does not
exist, since this may not be desirable for some Rd files. The "..."
arguments can be used to change this, they are passed on to
[`Rdo_modify`](https://geobosh.github.io/Rdpack/reference/Rdo_modify.md),
see its documentation for details.

## Value

This function is used mainly for the side effect of changing `file`. It
returns the Rd formatted text as a character vector.

## Author

Georgi N. Boshnakov

## See also

[`Rdo_modify`](https://geobosh.github.io/Rdpack/reference/Rdo_modify.md)

## Examples

``` r
fnA <- tempfile("dummyfun", fileext = "Rd")
dummyfun <- function(x) x
reprompt(dummyfun, filename = fnA)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#> Error in reprompt(dummyfun, filename = fnA): unsuccessful attempt to create Rd doc. using a 'prompt' function.
Rdo_show(tools::parse_Rd(fnA))
#> Warning: cannot open file '/tmp/Rtmpwv08SD/dummyfun1c012d2be854Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

## set the author section, create it if necessary.
Rdo_set_section("A.A. Author", "author", fnA, create = TRUE)
#> Warning: cannot open file '/tmp/Rtmpwv08SD/dummyfun1c012d2be854Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection
Rdo_show(tools::parse_Rd(fnA))
#> Warning: cannot open file '/tmp/Rtmpwv08SD/dummyfun1c012d2be854Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

## replace the author section
Rdo_set_section("Georgi N. Boshnakov", "author", fnA)
#> Warning: cannot open file '/tmp/Rtmpwv08SD/dummyfun1c012d2be854Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection
Rdo_show(tools::parse_Rd(fnA))
#> Warning: cannot open file '/tmp/Rtmpwv08SD/dummyfun1c012d2be854Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

unlink(fnA)
```
