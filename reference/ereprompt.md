# Update an Rd file and open it in an editor

Update an Rd file and open it in an editor. This is a wrapper for
reprompt with different defaults for some parameters.

## Usage

``` r
ereprompt(..., edit = TRUE, filename = TRUE)
```

## Arguments

- ...:

  passed on to
  [`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md),
  see its documentation for details.

- edit:

  if `TRUE`, the default, open an editor when finished.

- filename:

  if `TRUE`, the default, replace and/or edit the original Rd file.

## Details

`ereprompt` calls `reprompt` to do the actual job but has different
defaults for the arguments described on this page. By default, it
replaces the original Rd file with the updated documentation and opens
it in an editor.

## Value

called for the side effect of updating Rd documentation file and opening
it in an editor

## Author

Georgi N. Boshnakov

## See also

[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
which does the actual work

## Examples

``` r
## this assumes that the current working directory is
## in any subdirectory of the development directory of  Rdpack 
if (FALSE) { # \dontrun{
ereprompt(infile = "reprompt.Rd")
} # }
```
