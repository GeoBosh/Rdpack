# Parse a piece of Rd source text

Parse a piece of Rd source text.

## Usage

``` r
parse_Rdpiece(x, result = "")
```

## Arguments

- x:

  the piece of Rd text, a character vector.

- result:

  if "text", converts the result to printable text (e.g. to be shown to
  the user), otherwise returns an Rd object.

## Details

`parse_Rdpiece` parses a piece of source Rd text. The text may be an
almost arbitrary piece that may be inserted in an Rd source file, except
that it should not be a top level section (use
[`parse_Rdtext`](https://geobosh.github.io/Rdpack/reference/parse_Rdtext.md)
for sections). Todo: it probably can be also a parsed piece, check!

This is somewhat tricky since `parse_Rd` does not accept arbitrary piece
of Rd text. It handles either a complete Rd source or a fragment,
defined (as I understand it) as a top level section. To circumvent this
limitation, this function constructs a minimal complete Rd source
putting argument `x` in a section (currently "Note") which does not have
special formatting on its own. After parsing, it extracts only the part
corresponding to `x`.

`parse_Rdpiece` by default returns the parsed Rd piece. However, if
`result="text"`, then the text is formatted as the help system would do
when presenting help pages in text format.

**TODO:** add an argument for macros?

## Value

a parsed Rd piece or its textual representation as described in Details

## Author

Georgi N. Boshnakov

## Examples

``` r
# the following creates Rd object rdo
dummyfun <- function(x) x
u1 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x,y)",
              value = "numeric vector",
              author = "A. Author",
              Rd_class = TRUE )
fn <- tempfile("dummyfun", fileext = "Rd")
reprompt(dummyfun, filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#> Error in reprompt(dummyfun, filename = fn): unsuccessful attempt to create Rd doc. using a 'prompt' function.
rdo <- tools::parse_Rd(fn)
#> Warning: cannot open file '/tmp/RtmpYjkkCT/dummyfun1d934d98a04Rd': No such file or directory
#> Error in file(con, "r"): cannot open the connection

# let's prepare a new item
rd <- "\\item{...}{further arguments to be passed on.}"
newarg <- parse_Rdtext(rd, section = "\\arguments")

# now append 'newarg' to the arguments section of rdo
iarg <- which(tools:::RdTags(rdo) == "\\arguments")
#> Error: object 'rdo' not found
rdoa <- append_to_Rd_list(rdo, newarg, iarg)
#> Error: object 'rdo' not found

Rdo_show(rdoa)
#> Error: object 'rdoa' not found

# for arguments and other frequent tasks, there are specialised functions
dots <- paste0("\\", "dots")
rdob <- Rdo_append_argument(rdo, dots, "further arguments to be passed on.")
#> Error: object 'rdo' not found

Rdo_show(reprompt(rdob, filename = fn))
#> Error: object 'rdob' not found

unlink(fn)
```
