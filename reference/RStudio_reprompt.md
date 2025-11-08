# Call reprompt based on RStudio editor contents

This function uses the RStudio API to call
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md) on
either the current help file in the editor, or if a name is highlighted
in a `.R` file, on that object.

## Usage

``` r
RStudio_reprompt(verbose = TRUE)
```

## Arguments

- verbose:

  If `TRUE` print progress to console.

## Details

This function depends on being run in RStudio; it will generate an error
if run in other contexts.

It depends on code being in a package that has already been built,
installed, and attached. In RStudio, this means you should run “Install
and Restart” before running this function.

It is automatically installed into RStudio as an add-in called
“Reprompt”. Whether invoked directly or through the add-in, it looks at
the file currently being edited in the code editor. If it is an `.Rd`
file, it will run
[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md) on
that file.

If it is an R source file, it will look for a selected object name. It
queries the help system to find if there is already a help page for that
name, and if so, works on that. If not, it will try to create one.

## Value

`NULL`, invisibly.

## Author

Duncan Murdoch

## See also

[`reprompt`](https://geobosh.github.io/Rdpack/reference/reprompt.md),
[`ereprompt`](https://geobosh.github.io/Rdpack/reference/ereprompt.md),
[`prompt`](https://rdrr.io/r/utils/prompt.html)
