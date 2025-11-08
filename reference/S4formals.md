# Give the formal arguments of an S4 method

Give the formal arguments of an S4 method.

## Usage

``` r
S4formals(fun, ...)
```

## Arguments

- fun:

  name of an S4 generic, a string, or the method, see Details.

- ...:

  further arguments to be passed to `getMethod`, see Details.

## Details

`S4formals` gives the formal arguments of the requested method. If `fun`
is not of class `methodDefinition`, it calls `getMethods`, passing on
all arguments.

Typically, `fun` is the name of a generic function and the second
argument is the signature of the method as a character vector.
Alternatively, `fun` may be the method itself (e.g. obtained previously
from `getMethod`) and in that case the `"\dots"` arguments are ignored.
See `getMethod` for full details and other acceptable arguments.

## Value

a pairlist, like [`formals`](https://rdrr.io/r/base/formals.html)

## Note

Arguments of a method after those used for dispatch may be different
from the arguments of the generic. The latter may simply have a
`"\dots"` argument there.

todo: there should be a similar function in the "methods" package, or at
least use a documented feature to extract it.

## Author

Georgi N. Boshnakov

## Examples

``` r
require(stats4) # makes plot() S4 generic
#> Loading required package: stats4

S4formals("plot", c(x = "profile.mle", y = "missing"))
#> $x
#> 
#> 
#> $levels
#> 
#> 
#> $conf
#> c(99, 95, 90, 80, 50)/100
#> 
#> $nseg
#> [1] 50
#> 
#> $absVal
#> [1] TRUE
#> 
#> $...
#> 
#> 

m1 <- getMethod("plot", c(x = "profile.mle", y = "missing"))
S4formals(m1)
#> $x
#> 
#> 
#> $levels
#> 
#> 
#> $conf
#> c(99, 95, 90, 80, 50)/100
#> 
#> $nseg
#> [1] 50
#> 
#> $absVal
#> [1] TRUE
#> 
#> $...
#> 
#> 
```
