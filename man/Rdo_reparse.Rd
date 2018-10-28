\name{Rdo_reparse}
\alias{Rdo_reparse}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Reparse an Rd object}
\description{Reparse an Rd object.}
\usage{
Rdo_reparse(rdo)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object}
}
\details{
  \code{Rdo_reparse} saves \code{rdo} to a temporary file and parses it
  with \code{parse_Rd}. This ensures that the Rd object is a "canonical"
  one, since one and the same Rd file can be produced by different (but
  equivalent) Rd objects.

  Also, the functions in this package do not attend to attribute
  "srcref" (and do not use it) and reparsing takes care of this.
  (todo: check if there is a problem if the tempfile disappears.)

  %insertCite{@see @parseRd,@Rpack:bibtex}{Rdpack}  % only for testing!

  \insertCite{parseRd,Rpack:bibtex}{Rdpack}  % only for testing!
}
\references{
\insertAllCited{} % only for testing
}




%% ~Make other sections like Warning with \section{Warning }{....} ~


\examples{
# the following creates Rd object rdo
dummyfun <- function(x) x
fn <- tempfile("dummyfun", fileext = "Rd")

reprompt(dummyfun, filename = fn)
rdo <- tools::parse_Rd(fn)

dottext <- "further arguments to be passed on."

rdo2 <- Rdo_append_argument(rdo, "\\dots", dottext, create = TRUE)
rdo2 <- Rdo_append_argument(rdo2, "z", "a numeric vector")

Rdo_show(Rdo_reparse(rdo2))

# the following does ot show the arguments. (todo: why?)
#    (see also examples in Rdo_append_argument)
Rdo_show(rdo2)

unlink(fn)
}
\keyword{Rd}
