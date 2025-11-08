# Inspect the argument section of an Rd object

Inspect the argument section of an Rd object.

## Usage

``` r
inspect_args(rdo, i_usage)
```

## Arguments

- rdo:

  an Rd object describing functions.

- i_usage:

  see Details.

## Details

`inspect_args` checks if the arguments in the documentation object `rdo`
match the (union of) the actual arguments of the functions it describes.

If `i_usage` is missing, it is computed by inspecting the current
definitions of the functions described in `rdo`, see `inspect_usage`.
This argument is likely to be supplied if the function calling
`inspect_args` has already computed it for other purposes.

## Value

TRUE if the arguments in the documentation match the (union of) the
actual arguments of the described functions, FALSE otherwise.

The returned logical value has attribute \`details' which is a list with
the following components.

- rdo_argnames:

  arguments described in the documentation object, `rdo`.

- cur_argnames:

  arguments in the current definitions of the described functions.

- added_argnames:

  new arguments

- removed_argnames:

  removed (dropped) arguments.

## Author

Georgi N. Boshnakov
