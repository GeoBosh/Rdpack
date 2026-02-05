# Append an item for a new argument to an Rd object

Append an item for a new argument to an Rd object.

## Usage

``` r
Rdo_append_argument(rdo, argname, description = NA, indent = "  ", create = FALSE)
```

## Arguments

- rdo:

  an Rd object.

- argname:

  name of the argument, a character vector.

- description:

  description of the argument, a character vector.

- indent:

  a string, typically whitespace.

- create:

  not used (todo: remove?)

## Details

Appends one or more items to the section describing arguments of
functions in an Rd object. The section is created if not present.

If `description` is missing or NA, a "todo" text is inserted.

The inserted text is indented using the string `indent`.

The lengths of `argname` and `description` should normally be equal but
if `description` is of length one, it is repeated to achieve this when
needed.

## Value

an Rd object

## Author

Georgi N. Boshnakov

## Examples

``` r
## the following creates Rd object rdo
dummyfun <- function(x) x
fn <- tempfile("dummyfun", fileext = ".Rd")
reprompt(dummyfun, filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#> Error in reprompt(dummyfun, filename = fn): unsuccessful attempt to create Rd doc. using a 'prompt' function.
rdo <- tools::parse_Rd(fn)
#> Warning: cannot open file '/tmp/Rtmpwv08SD/dummyfun1c016d9be32e.Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

## add documentation for arguments
## that are not in the signature of 'dummyfun()'
dottext <- "further arguments to be passed on."
dots <- paste0("\\", "dots")
rdo2 <- Rdo_append_argument(rdo, dots, dottext, create = TRUE)
#> Error: object 'rdo' not found
rdo2 <- Rdo_append_argument(rdo2, "z", "a numeric vector")
#> Error: object 'rdo2' not found

## reprompt() warns to remove documentation for non-existing arguments:
Rdo_show(reprompt(rdo2, filename = fn))
#> Error: object 'rdo2' not found

unlink(fn)
```
