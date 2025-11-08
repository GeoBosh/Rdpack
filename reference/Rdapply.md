# Apply a function over an Rd object

Apply a function recursively over an Rd object, similarly to rapply but
keeping attributes.

## Usage

``` r
Rdapply(x, ...)

Rdtagapply(object, FUN, rdtag, classes = "character", how = "replace",
           ...)

rattr(x, y)
```

## Arguments

- x:

  the Rd object on which to apply a function.

- object:

  the Rd object on which to apply a function.

- FUN:

  The function to apply, see details

- rdtag:

  apply FUN only to elements whose `Rd_tag` attribute is `rdtag`.

- y:

  an Rd object with the same structure as `x`, see \`Details'.

- ...:

  arguments to pass to `rapply`, see \`Details'.

- classes:

  a character vector, passed on to
  [`rapply`](https://rdrr.io/r/base/rapply.html), see \`Details'.

- how:

  a character string, passed on to
  [`rapply`](https://rdrr.io/r/base/rapply.html), see \`Details'.

## Details

`Rdapply` works like `rapply` but preserves the attributes of `x` and
(recursively) any sublists of it. `Rdapply` first calls `rapply`,
passing all arguments to it. Then it restores recursively the attributes
by calling `rattr`.

Note that the object returned by `rapply` is assumed to have identical
structure to the original object. This means that argument `how` of
`rapply` must not be "unlist" and normally will be "replace".
`Rdtagapply` gives sensible default values for `classes` and `how`. See
the documentation of [`rapply`](https://rdrr.io/r/base/rapply.html) for
details and the possible choices for `classes`, `how` or other arguments
passed to it via `"\dots"`.

`Rdtagapply` is a convenience variant of `Rdapply` for the common task
of modifying or examining only elements with a given `Rd_tag` attribute.
Since the Rd equation macros `\eqn` and `\deqn` are assigned Rd tag
"VERB" but are processed differently from other "VERB" pieces,
pseudo-tags "mathVERB" and "nonmathVERB" are provided, such that
"mathVERB" is for actions on the first argument of the mathematical
macros `\eqn` and `\deqn`, while "nonmathVERB" is for actions on "VERB"
macros in all other contexts. There is also a pseudo-tag "nonmath" for
anything that is not math.

`rattr` is an auxilliary function which takes two Rd objects (with
identical structure) and recursively examines them. It makes the
attributes of any lists in the first argument identical to the
corresponding attributes in the second.

## Value

For `Rdapply` and `Rdtagapply`, an Rd object with some of its leaves
replaced as specified above.

For `rattr`, the object `x` with attributes of any list elements of it
set to the corresponding attributes of `y`.

## Author

Georgi N. Boshnakov

## Note

todo: may be it is better to rename the argument FUN of `Rdtagapply` to
`f`, which is its name in `rapply`.

## See also

[`rapply`](https://rdrr.io/r/base/rapply.html)

## Examples

``` r
# create an Rd object for the sake of example
u1 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x)",
              value = "numeric vector",
              author = "A. Author",
              examples = "\na <- matrix(1:6,nrow=2)\na %*% t(a)\nt(a) %*% a",
              Rd_class=TRUE )

# correct R code for examples but wrong for saving in Rd files
Rdo_show(u1)

# escape percents everywhere except in comments
#  (actually, .anypercent escapes only unescaped percents)
rdo <- Rdapply(u1, Rdpack:::.anypercent, classes = "character", how = "replace")

# syntactically wrong R code for examples but ok for saving in Rd files
Rdo_show(rdo)


# Rdo2Rdf does this by default for examples and other R code,
#   so code can be kept syntactically correct while processing.
#   (reprompt() takes care of this too as it uses Rdo2Rdf for saving)

fn <- tempfile("u1", fileext="Rd")
Rdo2Rdf(u1, file = fn)
#>  The Rd content was written to file  /tmp/RtmpYjkkCT/u11d934fd72af8Rd 

# the saved file contains escaped percents but they disappear in parsing:
file.show(fn)
Rdo_show(tools::parse_Rd(fn))

# if you think that sections should start on new lines,
# the following makes the file a little more human-friendly
#   (by inserting new lines).
u2 <- Rdpack:::.Rd_tidy(u1)
Rdo2Rdf(u2, file = fn)
#>  The Rd content was written to file  /tmp/RtmpYjkkCT/u11d934fd72af8Rd 
file.show(fn)

unlink(fn)
```
