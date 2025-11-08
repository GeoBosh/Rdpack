# Manipulate a number of Rd files

Manipulate a number of Rd files.

## Usage

``` r
Rd_combo(rd, f, ..., .MORE)
```

## Arguments

- rd:

  names of Rd files, a character vector.

- f:

  function to apply, see Details.

- ...:

  further arguments to pass on to `f`.

- .MORE:

  another function to be applied for each file to the result of `f`.

## Details

`Rd_combo` parses each file in `rd`, applies `f` to the Rd object, and
applies the function `.MORE` (if supplied) on the results of `f`.

A typical value for `.MORE` is `reprompt` or another function that saves
the resulting Rd object.

todo: `Rd_combo` is already useful but needs further work.

## Examples

``` r
if (FALSE) { # \dontrun{
rdnames <- dir(path = "./man", pattern=".*[.]Rd$", full.names=TRUE)

## which Rd files don't have a value section?
counts <- unlist(Rd_combo(rdnames, function(x) length(Rdo_locate_core_section(x, "\value"))))
rdnames[counts == 0]

## reprompt all files
Rd_combo(rdnames, reprompt)
for(nam in rdnames) try(reprompt(nam))
for(nam in rdnames) try(reprompt(nam, sec_copy=FALSE))
} # }
```
