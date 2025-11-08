# Internal functions used by reprompt

Internal functions used by reprompt.

## Usage

``` r
.capture_promptAny(fnam, type, package, final, ..., methods)

.capture_installed_help(fnam, type = NULL, package = NULL,
                        suffix = NULL)
```

## Arguments

- fnam:

  extended name of the object, such as "fun", "gen-methods",
  "S4cl-class" or "pkname-package", see details.

- final:

  if TRUE, put dummy title and description to make the file immediately
  usable.

- ...:

  further arguments to pass on to the prompt function(s).

- methods:

  methods to consider, used only when describing S4 methods.

- type:

  type of documentation, such as "methods" and "class", see Details.

- package:

  the package where to look for objects or documentation, useful if more
  objects of the same name exist.

- suffix:

  a character string to be appended to `fnam` to obtain the complete
  name of the help topic, e.g. "-class", "-method".

## Details

These functions are used internally by `reprompt`. It falls back to them
when only when the user has not supplied an Rd file in the call.

Note that for editing it is preferable to use the source Rd files (when
available), since some hard coded information in the installed help may
have been produced by more elaborated code in the Rd sources, most
notably Sweave expressions.

`.capture_promptAny` is used to generate documentation when none has
been supplied by the user or loaded in the session. `.capture_promptAny`
parses `fnam` to obtain the name of the object and the type of the
required documentation (function, methods, class), then generates it.
Currently this is done with the built in functions of the `promptXXX`
family.

`.capture_installed_help` does exactly that — it captures the currently
installed requested help topic. This function needs clean up. It was
originally written at a time when both the old and new help formats
where co-existing.

## Value

an Rd object on success or a `try-error` object otherwise

## Author

Georgi N. Boshnakov

## Examples

``` r
##---- Should be DIRECTLY executable !! ----
```
