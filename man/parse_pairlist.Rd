\name{parse_pairlist}
\alias{parse_pairlist}
%\alias{pairlist2f_usage}
\alias{pairlist2f_usage1}
\title{Parse formal arguments of functions}
\description{Parse formal arguments of functions and convert them to
  f_usage objects.}
\usage{
parse_pairlist(x)

pairlist2f_usage1(x, name, S3class = "", S4sig = "", infix = FALSE,
                  fu = TRUE)
}
\arguments{
  \item{x}{a pairlist representing the arguments of a function.}
  \item{name}{function name.}
  \item{S3class}{S3 class, see `Details'}
  \item{S4sig}{S4 signature, see Details.}
  \item{infix}{if \code{TRUE} the function usage is in infix form, see
    Details.}
  \item{fu}{if TRUE the object is a function, otherwise it is something
    else (e.g. a variable or a constant like \code{pi} and \code{Inf}).
  }
}
\details{
  These functions are mostly internal.

  % \code{x} is a single pairlist object for \code{parse_pairlist} and
  % \code{pairlist2f_usage1}.
  % For \code{pairlist2f_usage} it may be a list of pairlist objects.
  % (\code{pairlist2f_usage} has been removed)
  
  \code{parse_pairlist} parses the pairlist object, \code{x}, into a
  list with two components. The first component contains the names of
  the arguments. The second component is a named list containing the
  default values, converted to strings. Only arguments with default
  values have entries in the second component (so, it may be of length
  zero).  If \code{x} is empty or \code{NULL}, both components have
  length zero. An example:
  \printExample{parse_pairlist(formals(system.file))}

  \code{pairlist2f_usage1()} creates an object of S3 class
  \code{"f_usage"}. The object contains the result of parsing \code{x}
  with \code{parse_pairlist(x)} and a number of additional components
  which are copies of the remaining arguments to the function (without
  any processing). The components are listed in section Values.
  \code{S3class} is set to an S3 class for for S3 methods, \code{S4sig}
  is the signature of an S4 method (as used in Rd macro
  \verb{\S4method}). \code{infix} is \code{TRUE} for the rare occations
  when the function is primarily used in infix form. 

  Class \code{"f_usage"} has a method for \code{as.character()} which
  generates a text suitable for inclusion in Rd documentation.
  \printExample{pairlist2f_usage1(formals(summary.lm), "summary", S3class = "lm")}

}
\value{
  For \code{parse_pairlist}, a list with the following components:
  \item{argnames}{the names of all arguments, a character vector}
  \item{defaults}{
    a named character vector containing the default values, converted to
    character strings. Only arguments with defaults have entries in this
    vector. 
  }

  For \code{pairlist2f_usage1}, an object with S3 class
  \code{"f_usage"}. This is a list as for \code{parse_pairlist} and
  the following additional components:

  \item{name}{function name, a character string.}
  \item{S3class}{
    S3 class, a character string; \code{""} if not an S3 method.
  } 
  \item{S4sig}{S4 signature; \code{""} if not an S4 method.} 
  \item{infix}{a logical value, \code{TRUE} for infix operators.}
  \item{fu}{
    indicates the type of the object, usually \code{TRUE}, see Details.
  }

  % For \code{pairlist2f_usage}, a list of \code{"f_usage"} objects.
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{promptUsage}} accepts \code{f_usage} objects,
  \code{\link{get_usage}}
}
\examples{
parse_pairlist(formals(lm))
parse_pairlist(formals(system.file))
s_lm <- pairlist2f_usage1(formals(summary.lm), "summary", S3class = "lm")
s_lm
as.character(s_lm)
}
\keyword{RdoBuild}
