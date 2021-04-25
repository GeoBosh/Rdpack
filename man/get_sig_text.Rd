\name{get_sig_text}

\alias{get_sig_text}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Produce the textual form of the  signatures of available methods for
  an S4 generic function
  \Sexpr[stage=build,results=hide]{require(Rdpack)}
}

\description{
  Produce the textual form of the  signatures of available methods for
  an S4 generic function.
}

\usage{
get_sig_text(rdo, package = NULL)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object.}
  \item{package}{if of class "character", give only  methods defined by
    \code{package}, otherwise give all methods.
  }
}

\details{
  Signatures are found using function \code{findMethodSignatures} from
  package "methods".


  Here we find all methods for \code{show()} defined in package
  \code{"methods"} and print the first few of them: 
  \printExample{fn <- utils::help("show-methods", package = "methods"); rdo <- utils:::.getHelpFile(fn); head(get_sig_text(rdo))}
  
}

\value{
  A character vector with one element for each method.
}



\author{Georgi N. Boshnakov}

\note{
  todo: It would be better to call promptMethods() to get the signatures
  but in version R-2.13.x I had trouble with argument `where' (could not
  figure out how to use it to restrict to functions from a package; also,
  promptMethods() seemed to call the deprecated function
  getMethods()). Check how these things stand in current versions of \R,
  there may be no problem any more (checked, in 2.14-0 it is the same).
}


%% ~Make other sections like Warning with \section{Warning }{....} ~


\examples{
## load another package with some S4 methods ("methods" is already loaded)
require("stats4") 

rdo <- Rdo_fetch("show", package = "methods")
## alternatively:
#fn <- help("show-methods", package = "methods")
#rdo <- utils:::.getHelpFile(fn)

## this will find all methods for "show" in currently loaded packages
## (print only some of them)
head(get_sig_text(rdo))

## this will select only the ones from package "stats4"
get_sig_text(rdo, package = "stats4")

## this is also fine (interactively) but need to choose
## the appropriate element of "fn" if length(fn) > 1
#fn <- help("show-methods")

## this finds nothing
#fn <- help("logLik-methods", package = "methods")
#fn
Rdo_fetch("logLik-methods", package = "methods")

## this does
#fn <- help("logLik-methods", package = "stats4")
#rdo <- utils:::.getHelpFile(fn)
rdo2 <- Rdo_fetch("logLik-methods", package = "stats4")

get_sig_text(rdo2)
get_sig_text(rdo2, package = "stats4")

## only default method defined
## using this:
setGeneric("f1", function(x, y){NULL})
## since the following gives error in pkgdown:
#f1 <- function(x, y){NULL}
#setGeneric("f1")

fn <- tempfile()

reprompt("f1", filename = fn)
rdo <- tools::parse_Rd(fn)
get_sig_text(rdo)

setClass("aRdpack")
setClass("bRdpack")

## several methods defined
setGeneric("f4", function(x, y){NULL})
setMethod("f4", c("numeric", "numeric"), function(x, y){NULL})
setMethod("f4", c("aRdpack", "numeric"), function(x, y){NULL})
setMethod("f4", c("bRdpack", "numeric"), function(x, y){NULL})
setMethod("f4", c("aRdpack", "bRdpack"), function(x, y){NULL})

reprompt("f4", filename = fn)
rdo <- tools::parse_Rd(fn)
get_sig_text(rdo)

unlink(fn)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoS4}
%\keyword{RdoProgramming}
