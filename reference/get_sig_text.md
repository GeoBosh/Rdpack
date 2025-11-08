# Produce the textual form of the signatures of available methods for an S4 generic function

Produce the textual form of the signatures of available methods for an
S4 generic function.

## Usage

``` r
get_sig_text(rdo, package = NULL)
```

## Arguments

- rdo:

  an Rd object.

- package:

  if of class "character", give only methods defined by `package`,
  otherwise give all methods.

## Details

Signatures are found using function `findMethodSignatures` from package
"methods".

Here we find all methods for `show()` defined in package `"methods"` and
print the first few of them:

    fn <- utils::help("show-methods", package = "methods")
    rdo <- utils:::.getHelpFile(fn)
    head(get_sig_text(rdo))
    ##: [1] "signature(object = \"ANY\")"
    ##: [2] "signature(object = \"classGeneratorFunction\")"
    ##: [3] "signature(object = \"classRepresentation\")"
    ##: [4] "signature(object = \"envRefClass\")"
    ##: [5] "signature(object = \"externalRefMethod\")"
    ##: [6] "signature(object = \"genericFunction\")"

## Value

A character vector with one element for each method.

## Author

Georgi N. Boshnakov

## Note

todo: It would be better to call promptMethods() to get the signatures
but in version R-2.13.x I had trouble with argument \`where' (could not
figure out how to use it to restrict to functions from a package; also,
promptMethods() seemed to call the deprecated function getMethods()).
Check how these things stand in current versions of R, there may be no
problem any more (checked, in 2.14-0 it is the same).

## Examples

``` r
## load another package with some S4 methods ("methods" is already loaded)
require("stats4") 

rdo <- Rdo_fetch("show", package = "methods")
## alternatively:
#fn <- help("show-methods", package = "methods")
#rdo <- utils:::.getHelpFile(fn)

## this will find all methods for "show" in currently loaded packages
## (print only some of them)
head(get_sig_text(rdo))
#> [1] "signature(object = \"ANY\")"                      
#> [2] "signature(object = \"MethodDefinition\")"         
#> [3] "signature(object = \"MethodDefinitionWithTrace\")"
#> [4] "signature(object = \"MethodSelectionReport\")"    
#> [5] "signature(object = \"MethodWithNext\")"           
#> [6] "signature(object = \"MethodWithNextWithTrace\")"  

## this will select only the ones from package "stats4"
get_sig_text(rdo, package = "stats4")
#> [1] "signature(object = \"mle\")"         "signature(object = \"summary.mle\")"

## this is also fine (interactively) but need to choose
## the appropriate element of "fn" if length(fn) > 1
#fn <- help("show-methods")

## this finds nothing
#fn <- help("logLik-methods", package = "methods")
#fn
Rdo_fetch("logLik-methods", package = "methods")
#> NULL

## this does
#fn <- help("logLik-methods", package = "stats4")
#rdo <- utils:::.getHelpFile(fn)
rdo2 <- Rdo_fetch("logLik-methods", package = "stats4")

get_sig_text(rdo2)
#> [1] "signature(object = \"ANY\")" "signature(object = \"mle\")"
get_sig_text(rdo2, package = "stats4")
#> [1] "signature(object = \"ANY\")" "signature(object = \"mle\")"

## only default method defined
## using this:
setGeneric("f1", function(x, y){NULL})
#> [1] "f1"
## since the following gives error in pkgdown:
#f1 <- function(x, y){NULL}
#setGeneric("f1")

fn <- tempfile()

reprompt("f1", filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#>  success: documentation generated using a 'prompt' function.
#>  The Rd content was written to file  /tmp/RtmpYjkkCT/file1d932e7d0ec2 
#> [1] "/tmp/RtmpYjkkCT/file1d932e7d0ec2"
rdo <- tools::parse_Rd(fn)
get_sig_text(rdo)
#> [1] "signature(x = \"ANY\")"

setClass("aRdpack")
setClass("bRdpack")

## several methods defined
setGeneric("f4", function(x, y){NULL})
#> [1] "f4"
setMethod("f4", c("numeric", "numeric"), function(x, y){NULL})
setMethod("f4", c("aRdpack", "numeric"), function(x, y){NULL})
setMethod("f4", c("bRdpack", "numeric"), function(x, y){NULL})
setMethod("f4", c("aRdpack", "bRdpack"), function(x, y){NULL})

reprompt("f4", filename = fn)
#> Rd source not supplied, looking for installed documentation.
#> Rd source not supplied and installed documentation not found.
#> Trying a 'prompt' function to generate documentation for the object.
#>  success: documentation generated using a 'prompt' function.
#>  The Rd content was written to file  /tmp/RtmpYjkkCT/file1d932e7d0ec2 
#> [1] "/tmp/RtmpYjkkCT/file1d932e7d0ec2"
rdo <- tools::parse_Rd(fn)
get_sig_text(rdo)
#> [1] "signature(x = \"ANY\", y = \"ANY\")"        
#> [2] "signature(x = \"aRdpack\", y = \"bRdpack\")"
#> [3] "signature(x = \"aRdpack\", y = \"numeric\")"
#> [4] "signature(x = \"bRdpack\", y = \"numeric\")"
#> [5] "signature(x = \"numeric\", y = \"numeric\")"

unlink(fn)
```
