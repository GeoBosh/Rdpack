# Reparse an Rd object

Reparse an Rd object.

## Usage

``` r
Rdo_reparse(rdo)
```

## Arguments

- rdo:

  an Rd object

## Details

`Rdo_reparse` saves `rdo` to a temporary file and parses it with
`parse_Rd`. This ensures that the Rd object is a "canonical" one, since
one and the same Rd file can be produced by different (but equivalent)
Rd objects.

Also, the functions in this package do not attend to attribute "srcref"
(and do not use it) and reparsing takes care of this. (todo: check if
there is a problem if the tempfile disappears.)

(Murdoch 2010; Francois 2014)

## References

Romain Francois (2014). *bibtex: bibtex parser*. R package version
0.4.0.  
  
Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.

## Examples

``` r
# the following creates Rd object rdo
dummyfun <- function(x) x
fn <- tempfile("dummyfun", fileext = "Rd")

reprompt(dummyfun, filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#> Error in reprompt(dummyfun, filename = fn): unsuccessful attempt to create Rd doc. using a 'prompt' function.
rdo <- tools::parse_Rd(fn)
#> Warning: cannot open file '/tmp/RtmpYjkkCT/dummyfun1d93622c6545Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

dottext <- "further arguments to be passed on."

dots <- paste0("\\", "dots")
rdo2 <- Rdo_append_argument(rdo, dots, dottext, create = TRUE)
#> Error: object 'rdo' not found
rdo2 <- Rdo_append_argument(rdo2, "z", "a numeric vector")
#> Error: object 'rdo2' not found

Rdo_show(Rdo_reparse(rdo2))
#> Error: object 'rdo2' not found

# the following does ot show the arguments. (todo: why?)
#    (see also examples in Rdo_append_argument)
Rdo_show(rdo2)
#> Error: object 'rdo2' not found

unlink(fn)
```
