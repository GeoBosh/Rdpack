\name{promptUsage}
\alias{promptUsage}
\alias{get_usage}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Usage text for a function, S3 method or S4 method}
\description{
  Obtains the usage text for a function, S3 method or S4 method for
  inclusion in the usage section of Rd documentation.
}
\usage{
get_usage(object, name = NULL, force.function = FALSE, \dots,
          S3class = "", S4sig = "", infix = FALSE, fu = TRUE,
          out.format = "text")

promptUsage(\dots, usage)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{
    for \code{promptUsage}, arguments to be passed on to
    \code{get_usage}; for \code{get_usage}, currently not used.
  }
  \item{usage}{an usage object, see Details.}
  \item{object}{a function object or a character name of one.}
  \item{name}{the name of a function, a string.}
  \item{force.function}{enforce looking for a function.}
  \item{S3class}{the S3 class of the function, a character vector.}
  \item{out.format}{if "\verb{text}", return the result as a character
    vector.}
  \item{S4sig}{(the signature of an S4 method, as used in Rd macro
    \verb{\S4method}).}
  \item{infix}{if TRUE the function is an infix operator.}
  \item{fu}{if TRUE the object is a function, otherwise it is something
    else (e.g. a variable or a constant like \code{pi} and \code{Inf}).
  }
}
\details{
  Argument \code{usage} could probably only be useful in programming
  when the usage text has been obtained (or generated) programmatically.
  \code{usage} may be an "\verb{f_usage}" object obtained e.g. from
  \code{get_usage()}.

  Use \code{cat()} to print the result for copying and pasting into Rd
  documentation (or saving to a file). Otherwise, if the usage text
  contains backslashes, they may appear duplicated.
}
\value{
  a character string or an object of S3 class "\verb{f_usage}",
  see \code{\link{pairlist2f_usage}} for its format.
}

\author{Georgi N. Boshnakov}
\note{
  For an S3 or S4 generic, use the name of the function, not the object,
  see the examples.

  These functions are for usage descriptions as they appear in the "usage"
  section of Rd files. Descriptions of S4 methods for "Methods" sections
  are dealt with by other functions.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{parse_pairlist}}
}

\examples{
u <- get_usage(lm)    # a long usage text
cat(u)

# if there are additional arguments in S3 methods,
# use names of the functions, not the objects, e.g.
get_usage("droplevels",S3class="data.frame")
get_usage(name="droplevels",S3class="data.frame")
# (both give "\method{droplevels}{data.frame}(x, except = NULL, \dots)")

# but this gives the args of the generic:  "\method{droplevels}{data.frame}(x, \dots)"
get_usage(droplevels,S3class="data.frame")

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Rd}
