# Inspect signatures of S4 methods

Inspect signatures of S4 methods.

## Usage

``` r
inspect_clmethods(rdo, final = TRUE)

inspect_signatures(rdo, package = NULL, sec = "Methods")
```

## Arguments

- rdo:

  an Rd object.

- package:

  the name of a package, a character string or NULL.

- sec:

  the name of a section to look into, a character string.

- final:

  If not TRUE insert text with suggestions, otherwise comment the
  suggestions out.

## Details

Signatures in documentation of S4 classes and methods are stored
somewhat differently. `inspect_signatures` inspects signatures in
documentation of methods of a function. `inspect_clmethods` inspects
signatures in documentation of a class.

`inspect_signatures` was written before `inspect_clmethods()` and was
geared towards using existing code for ordinary functions (mainly
[`parse_usage_text()`](https://geobosh.github.io/Rdpack/reference/parse_usage_text.md).

If new methods are found, the functions add entries for them in the Rd
object `rdo`.

If `rdo` documents methods that do not exist, a message inviting the
user to remove them manually is printed but the offending entries remain
in the object. At the time of writing, `R CMD check` does not warn about
this.

## Value

an Rd object

## Note

todo: need consolidation.

## Author

Georgi N. Boshnakov
