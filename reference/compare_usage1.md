# Compare usage entries for a function to its actual arguments

Compare usage entries for a function to its actual arguments.

## Usage

``` r
compare_usage1(urdo, ucur)
```

## Arguments

- urdo:

  usage text for a function or S3 method from an Rd object or file.

- ucur:

  usage generated from the actual object.

## Details

Compares the usage statements for functions in the Rd object or file
`urdo` to the usage inferred from the actual definitions of the
functions. The comparison is symmetric but the interpretation assumes
that `ucur` may be more recent.

Note: do not compare the return value to TRUE with `identical` or
`isTRUE`. The attribute makes the returned value not identical to TRUE
in any case.

## Value

TRUE if the usages are identical, FALSE otherwise. The return value has
attribute "details", which is a list providing details of the
comparison. The elements of this list should be referred by name, since
if one of `urdo` or `ucur` is NULL or NA, the list contains only the
fields "obj_removed", "obj_added", "rdo_usage", "cur_usage", and
"alias".

- identical_names:

  a logical value, TRUE if the \`name' is the same in both objects.

- obj_removed:

  names present in `urdo` but not in `ucur`

- obj_added :

  names present in `ucur` but not in `urdo`

- identical_argnames :

  a logical value, TRUE if the argument names in both objects are the
  same.

- identical_defaults :

  a logical value, TRUE if the defaults for the arguments in both
  objects are the same.

- identical_formals :

  a logical value, TRUE if the formals are the same, i.e. fields
  `identical_argnames` and `identical_defaults` are both TRUE.

- added_argnames :

  names of arguments in `ucur` but not in `urdo`.

- removed_argnames:

  names of arguments in `urdo` but not in `ucur`.

- names_unchanged_defaults :

  names of arguments whose defaults are the same.

- rdo_usage :

  a copy of `urdo`.

- cur_usage :

  a copy of `ucur`.

- alias :

  alias of the name of the object, see \`Details'.

## Author

Georgi N. Boshnakov

## See also

[`inspect_usage`](https://geobosh.github.io/Rdpack/reference/inspect_usage.md)
