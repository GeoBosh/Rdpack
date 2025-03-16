\name{S4formals}
\alias{S4formals}
\title{Give the formal arguments of an S4 method}
\description{Give the formal arguments of an S4 method.}
\usage{
S4formals(fun, \dots)
}
\arguments{
  \item{fun}{name of an S4 generic, a string, or the method, see Details.}
  \item{\dots}{further arguments to be passed to \code{getMethod}, see
    Details.}
}
\details{
  \code{S4formals} gives the formal arguments of the requested method.
  If \code{fun} is not of class \code{methodDefinition}, it calls
  \code{getMethods}, passing on all arguments.

  Typically, \code{fun} is the name of a generic function and the
  second argument is the signature of the method as a character
  vector. Alternatively, \code{fun} may be the method itself (e.g. obtained
  previously from \code{getMethod}) and in that case the \verb{"\dots"}
  arguments are ignored. See \code{\link{getMethod}} for full details
  and other acceptable arguments.

}
\value{
  a pairlist, like \code{\link{formals}}
}
\note{
  Arguments of a method after those used for dispatch may be different from
  the arguments of the generic. The latter  may simply have a \verb{"\dots"}
  argument there.

  todo: there should be a similar function in the "methods" package, or
        at least use a documented feature to extract it.
}
\author{
  Georgi N. Boshnakov
}
\examples{
require(stats4) # makes plot() S4 generic

S4formals("plot", c(x = "profile.mle", y = "missing"))

m1 <- getMethod("plot", c(x = "profile.mle", y = "missing"))
S4formals(m1)
}
\keyword{methods}
