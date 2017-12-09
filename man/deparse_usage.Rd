\name{deparse_usage}
\alias{deparse_usage}
\alias{deparse_usage1}
\alias{as.character.f_usage}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Convert f_usage objects to text appropriate for usage sections in
  Rd files
}
\description{Converts f_usage objects to text appropriate for usage sections in
  Rd files. Handles S3 methods.
}
\usage{
deparse_usage(x)
deparse_usage1(x, width = 72)
\method{as.character}{f_usage}(x, \dots )
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{an object from class \code{f_usage}}
  \item{width}{maximal width of text on a line}
  \item{...}{ignored; this argument is present for consistency with the
    generic \code{as.character}}
}
\details{
  \code{deparse_usage1} is internal function. For users
  \code{as.character} is more convenient.
}
\value{
  For \code{deparse_usage1} and \code{as.character.f_usage}, a named
  character vector of length one (the name is the function name).

  For \code{deparse_usage}, a named character vector with one entry for
  the usage text for each function.
}

\author{Georgi N. Boshnakov}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
 \code{\link{pairlist2f_usage}} and
 \code{\link{pairlist2f_usage1}}
}
\examples{
cur_wd <- getwd()
setwd(tempdir())

# as for prompt() the default to save in current dir as "seq.Rd".
fnseq <- reprompt(seq)

# let's parse the saved Rd file
rdoseq <- tools::parse_Rd(fnseq)

# the usage of 'seq' has several entries, parse them all

ut <- get_usage_text(rdoseq)
cat(ut,"\n")

utp <- parse_usage_text(ut)

# format some of them
as.character(utp[[1]])
deparse_usage1(utp[[1]])  # same

cat(deparse_usage1(utp[[2]]))
cat(as.character(utp[[2]]))   # same


unlink(fnseq)
}
%\keyword{RdoProgramming}
\keyword{RdoUsage}
%\keyword{RdFunction}
