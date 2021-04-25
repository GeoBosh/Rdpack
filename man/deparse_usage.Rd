\name{deparse_usage}
\alias{deparse_usage}
\alias{deparse_usage1}
\alias{as.character.f_usage}
\title{Convert f_usage objects to text appropriate for usage sections in
  Rd files
  \Sexpr[stage=build,results=hide]{require(Rdpack)}
}
\description{Converts f_usage objects to text appropriate for usage sections in
  Rd files. Handles S3 methods.
}
\usage{
deparse_usage(x)
deparse_usage1(x, width = 72)
\method{as.character}{f_usage}(x, \dots )
}
\arguments{
  \item{x}{
    an object from class \code{"f_usage"}. For \code{deparse_usage},
    \code{x} can also be a list of \code{"f_usage"} objects.
  }
  \item{width}{maximal width of text on a line.}
  \item{...}{ignored.}
}
\details{

  Both, \code{deparse_usage1} and the \code{as.character} method for
  class \code{"f_usage"}, convert an \code{"f_usage"} object to a
  character string suitable for Rd documentation. The
  \code{as.character} method is the user level function (it just calls
  \code{deparse_usage1}), \code{deparse_usage1} is internal function for
  programming. In the example below the first command creates an
  \code{"f_usage"} object, then the second converts it to character string.

  \printExample{(a <- pairlist2f_usage1(formals(cor), "cor"));cat(as.character(a))}  

  Each usage entriy is formatted and, if necessary, split over several
  lines. The width (number of characters) on a line can be changed with
  argument \code{width}.

  \code{deparse_usage} can be used when \code{x} is a list of
  \code{"f_usage"} objects. It calls \code{deparse_usage1} with each of
  them and returns a character vector with one element for each
  component of \code{x}.  When \code{x} is an object from class
  \code{"f_usage"}, \code{deparse_usage} is equivalent to
  \code{deparse_usage1}.

}
\value{
  For \code{deparse_usage1} and \code{as.character.f_usage}, a named
  character vector of length one (the name is the function name).

  For \code{deparse_usage}, a named character vector with one entry for
  the usage text for each function.
}

\author{Georgi N. Boshnakov}
\seealso{
 \code{\link{pairlist2f_usage1}}
}
\examples{
cur_wd <- getwd()
tmpdir <- tempdir()
setwd(tmpdir)

## prepare a list of "f_usage" objects
fnseq <- reprompt(seq)            # get and save the help page of "seq"
rdoseq <- tools::parse_Rd(fnseq)  # parse the Rd file
ut <- get_usage_text(rdoseq)      # get the contents of the usage section
cat(ut, "\n")                     #     of seq() (a character string)
utp <- parse_usage_text(ut)       # parse to a list of "f_usage" objects

## deparse the "f_usage" list - each statement gets a separate string
cat(deparse_usage(utp), sep = "\n")

## explore some of the usage entries individually;
## the generic seq() has a boring signature
utp[[1]]
as.character(utp[[1]])
deparse_usage1(utp[[1]])  # same

## the default S3 method is more interesting
utp[[2]]
cat(deparse_usage1(utp[[2]]))
cat(as.character(utp[[2]]))   # same

unlink(fnseq)
setwd(cur_wd)
unlink(tmpdir)
}
%\keyword{RdoProgramming}
\keyword{RdoUsage}
%\keyword{RdFunction}
