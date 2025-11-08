# Format the usage text of functions

Formats the usage text of a function so that each line contains no more
than a given number of characters.

## Usage

``` r
format_funusage(x, name = "", width = 72, realname)
```

## Arguments

- x:

  a character vector containing one element for each argument of the
  function, see \`Details'.

- name:

  the name of the function whose usage is described, a string.

- width:

  maximal width of each line of output.

- realname:

  the printed form of `name`, see \`Details', a string.

## Details

`format_funusage` formats the usage text of a function for inclusion in
Rd documentation files. If necessary, it splits the text into more lines
in order to fit it within the requested width.

Each element of argument `x` contains the text for one argument of
function `name` in the form `arg` or `arg = default`. `format_funusage`
does not look into the content of `x`, it does the necessary pasting to
form the complete usage text, inserting new lines and indentation to
stay within the specified width. Elements of `x` are never split. If an
argument (i.e., element of `x`) would cause the width to be exceeded,
the entire argument is moved to the following line.

The text on the second and subsequent lines of each usage item starts in
the column just after the opening parenthesis which follows the name of
the function on the first line.

In descriptions of S3 methods and S4 methods, argument `name` may be a
TeX macro like `\method{print}{ts}`. In that case the number of
characters in `name` has little bearing on the actual number printed. In
this case argument `realname` is used for counting both the number of
characters on the first line of the usage message and the indentation
for the subsequent lines.

## Value

The formatted text as a length one character vector.

## Author

Georgi N. Boshnakov

## Note

Only the width of `realname` is used (for counting). The formatted text
contains `name`.

The width of strings is determined by calling `nchar` with argument
`type` set to "width".

## See also

[`deparse_usage1`](https://geobosh.github.io/Rdpack/reference/deparse_usage.md)

## Examples

``` r
# this function is essentially internal,
# see deparse_usage1 and as.character.f_usage which use it.
```
