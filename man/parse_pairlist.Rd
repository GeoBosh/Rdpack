\name{parse_pairlist}
\alias{parse_pairlist}
\alias{pairlist2f_usage}
\alias{pairlist2f_usage1}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Parse formal arguments of functions}
\description{Parse formal arguments of functions and convert them to
  f_usage objects.}
\usage{
parse_pairlist(x)

pairlist2f_usage1(x, name, S3class = "", S4sig = "", infix = FALSE,
                  fu = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a pairlist or a list of pairlists, see `Details'.}
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

  \code{x} is a single pairlist object for \code{parse_pairlist} and
  \code{pairlist2f_usage1}.
  % For \code{pairlist2f_usage} it may be a list of pairlist objects.

  The pairlist object is parsed into a list whose first component
  contains the names of the arguments. The second component is a named
  list containing the default values, converted to strings. Only
  arguments with default values have entries in the second component
  (so, it may be of length zero).

  \code{pairlist2f_usage1} adds components \code{name} (function name),
  \code{S3class}, \code{S4sig} and \code{infix}. \code{S3class} is set
  for S3 methods, \code{S4sig} is the signature of an S4 method (as used
  in Rd macro \verb{\S4method}). \code{infix} is \code{TRUE} for the
  rare occations of usages of infix operators.  The result is given
  class "f_usage". This class has a method for \code{as.character} which
  generates a text suitable for inclusion in Rd documentation.

}
\value{
  For \code{parse_pairlist}, a list with the following components:
  \item{argnames}{names of arguments, a character vector}
  \item{defaults}{a named character vector containing the default
    values, converted to character strings.}

  For \code{pairlist2f_usage1}, an object with S3 class
  \code{"f_usage"}. This is a list as for \code{parse_pairlist} and
  the following additional components:

  \item{name}{function name, a character string.}
  \item{S3class}{S3 class, a character string.}
  \item{S4sig}{S4 signature.}
  \item{infix}{a logical value, \code{TRUE} for infix operators.}

  % For \code{pairlist2f_usage}, a list of \code{"f_usage"} objects.
}

\author{Georgi N. Boshnakov}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{promptUsage}}
}

\examples{
parse_pairlist(formals(lm))
}
%\keyword{RdoProgramming}
\keyword{RdoBuild}


% pairlist2f_usage(x, nams, S3class = "", S4sig = "", infix = FALSE,
%                  fu = TRUE, verbose = TRUE)
  % \item{nams}{function names, a character vector}
  % \item{verbose}{if TRUE and function names are not supplied, issue a
  %                message.}
