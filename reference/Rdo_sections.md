# Locate the sections in Rd objects

Locate the Rd sections in an Rd object and return a list of their
positions and names.

## Usage

``` r
Rdo_sections(rdo)

Rdo_locate_core_section(rdo, sec)
```

## Arguments

- rdo:

  an Rd object.

- sec:

  the name of a section, a character string. For builtin sections the
  leading backslash should be included.

## Details

`Rdo_sections` locates all sections at the top level in an Rd object.
This includes the predefined sections and the user defined sections.
Sections wrapped in `#ifdef` directives are also found.

`Rdo_sections` returns a list with one entry for each section in `rdo`.
This entry is a list with components `"pos"` and `"title"` giving the
position (suitable for use in `"[["`) and the title of the section. For
user defined sections the actual name is returned, not "section".

The names of the sections are returned as single strings without
attributes. The titles of predefined sections are single words but user
defined sections may have longer titles and sometimes contain basic
markup.

`Rdo_locate_core_section` works similarly but returns only the results
for section `sec`. Currently it simply calls `Rdo_sections` and returns
only the results for `sec`.

Note that for consistency `Rdo_locate_core_section` does not attempt to
simplify the result in the common case when there is only one instance
of the requested section—it is put in a list of length one.

(Murdoch 2010) (Francois 2014)

## Value

A list giving the positions and titles of the sections in `rdo` as
described in 'Details'. The format is essentially that of
[`Rdo_locate`](https://geobosh.github.io/Rdpack/reference/Rdo_locate.md),
the difference being that field "value" from that function is renamed to
"title" here.

- pos:

  the position, a vector of positive integers,

- title:

  a standard section name, such as `"\name"` or, in the case of
  "\section", the actual title of the section.

## Author

Georgi N. Boshnakov

## Note

I wrote `Rdo_sections` and `Rdo_locate_core_section` after most of the
core functionality was tested. Currently these functions are
underused—they can replace a number of internal and exported functions.

## See also

[`Rdo_locate`](https://geobosh.github.io/Rdpack/reference/Rdo_locate.md)

## References

Romain Francois (2014). *bibtex: bibtex parser*. R package version
0.4.0.  
  
Duncan Murdoch (2010). “Parsing Rd files.”
<https://developer.r-project.org/parseRd.pdf>.

## Examples

``` r
infile <- system.file("examples", "tz.Rd", package = "Rdpack")
rd <- tools::parse_Rd(infile)

## Locate all top level sections in rd
sections <- Rdo_sections(rd)
## How many sections there are in rd?
length(sections)
#> [1] 16
## What are their titles?
sapply(sections, function(x) x$title)
#>  [1] "\\name"              "\\alias"             "\\alias"            
#>  [4] "\\alias"             "\\alias"             "\\alias"            
#>  [7] "\\title"             "\\description"       "\\usage"            
#> [10] "\\arguments"         "\\details"           "\\value"            
#> [13] "Further information" "\\examples"          "\\keyword"          
#> [16] "\\keyword"          

## The names of builtin sections include the backslash
Rdo_locate_core_section(rd, "\\title")
#> [[1]]
#> [[1]]$pos
#> [1] 11
#> 
#> [[1]]$title
#> [1] "\\title"
#> 
#> 

## Locate a user defined secion
Rdo_locate_core_section(rd, "Further information")
#> [[1]]
#> [[1]]$pos
#> [1] 23
#> 
#> [[1]]$title
#> [1] "Further information"
#> 
#> 

## The names of builtin sections include the backslash
Rdo_locate_core_section(rd, "\\details")
#> [[1]]
#> [[1]]$pos
#> [1] 19
#> 
#> [[1]]$title
#> [1] "\\details"
#> 
#> 

## All appearances of the requested section are returned
Rdo_locate_core_section(rd, "\\alias")
#> [[1]]
#> [[1]]$pos
#> [1] 3
#> 
#> [[1]]$title
#> [1] "\\alias"
#> 
#> 
#> [[2]]
#> [[2]]$pos
#> [1] 5
#> 
#> [[2]]$title
#> [1] "\\alias"
#> 
#> 
#> [[3]]
#> [[3]]$pos
#> [1] 7
#> 
#> [[3]]$title
#> [1] "\\alias"
#> 
#> 
#> [[4]]
#> [[4]]$pos
#> [1] 9 2 1
#> 
#> [[4]]$title
#> [1] "\\alias"
#> 
#> 
#> [[5]]
#> [[5]]$pos
#> [1] 10  2  1
#> 
#> [[5]]$title
#> [1] "\\alias"
#> 
#> 
Rdo_locate_core_section(rd, "\\keyword")
#> [[1]]
#> [[1]]$pos
#> [1] 27
#> 
#> [[1]]$title
#> [1] "\\keyword"
#> 
#> 
#> [[2]]
#> [[2]]$pos
#> [1] 29
#> 
#> [[2]]$title
#> [1] "\\keyword"
#> 
#> 
```
