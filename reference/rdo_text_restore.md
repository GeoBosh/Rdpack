# Ensure exported fragments of Rd are as the original

For an Rd object imported from a file, this function ensures that
fragments that were not not changed during the editing of the object
remain unchanged in the exported file. This function is used by
reprompt() to ensure exactly that.

## Usage

``` r
rdo_text_restore(cur, orig, pos_list, file)
```

## Arguments

- cur:

  an Rd object

- orig:

  an Rd object

- pos_list:

  a list of srcref objects specifying portions of files to replace, see
  'Details'.

- file:

  a file name, essentially a text representation of `cur`.

## Details

This is essentially internal function. It exists because, in general, it
is not possible to restore the original Rd file from the Rd object due
to the specifications of the Rd format. The file exported from the
parsed Rd file is functionally equivalent to the original but equivalent
things for the computer are not necessarily equally pleasant for humans.

This function is used by `reprompt` when the source is from a file and
the option to keep the source of unchanged sections as in the original.

**todo:** needs clean up, there are unnecessary arguments in particular.

## Value

the main result is the side effect of replacing sections in `file` not
changed by `reprompt` with the original ones.

## Author

Georgi N. Boshnakov

## See also

[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md)
