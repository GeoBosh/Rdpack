# Parse the name section of an Rd object

Parse the name section of an Rd object.

## Usage

``` r
parse_Rdname(rdo)
```

## Arguments

- rdo:

  an Rd object

## Details

The content of section "`\name`" is extracted. If it contains a hyphen,
\`-', the part before the hyphen is taken to be the topic (usually a
function name), while the part after the hyphen is the type. If the name
does not contain hyphens, the type is set to the empty string.

## Value

a list with two components:

- fname:

  name of the topic, usually a function

- type:

  type of the topic, such as `"method"`

## Author

Georgi N. Boshnakov

## Examples

``` r
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class=TRUE )

parse_Rdname(u1)
#> $fname
#>        name 
#> "Dummyname" 
#> 
#> $type
#> type 
#>   "" 
#> 

u2 <- list_Rd(name = "dummyclass-class", alias = "Dummyclass",
              title = "Class dummyclass",
              description = "Objects and methods for something.",
              Rd_class=TRUE )

parse_Rdname(u2)
#> $fname
#>         name 
#> "dummyclass" 
#> 
#> $type
#>    type 
#> "class" 
#> 
```
