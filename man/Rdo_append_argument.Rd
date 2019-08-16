\name{Rdo_append_argument}
\alias{Rdo_append_argument}
\title{
  Append an item for a new argument to an Rd object
}
\description{
  Append an item for a new argument to an Rd object.
}
\usage{
Rdo_append_argument(rdo, argname, description = NA, indent = "  ", create = FALSE)
}
\arguments{
  \item{rdo}{an Rd object.}
  \item{argname}{name of the argument, a character vector.}
  \item{description}{description of the argument, a character vector.}
  \item{indent}{a string, typically whitespace.}
  \item{create}{not used (todo: remove?)}
}
\details{
  Appends one or more items to the section describing arguments of
  functions in an Rd object. The section is created if not present.

  If \code{description} is missing or NA, a "todo" text is inserted.

  The inserted text is indented using the string \code{indent}.

  The lengths of \code{argname} and \code{description} should normally
  be equal but if \code{description} is of length one, it is repeated to
  achieve this when needed.
}
\value{
  an Rd object
}
\author{Georgi N. Boshnakov}
\examples{
## the following creates Rd object rdo
dummyfun <- function(x) x
fn <- tempfile("dummyfun", fileext = ".Rd")
reprompt(dummyfun, filename = fn)
rdo <- tools::parse_Rd(fn)

## add documentation for arguments
## that are not in the signature of 'dummyfun()'
dottext <- "further arguments to be passed on."
rdo2 <- Rdo_append_argument(rdo, "\\dots", dottext, create = TRUE)
rdo2 <- Rdo_append_argument(rdo2, "z", "a numeric vector")

## reprompt() warns to remove documentation for non-existing arguments:
Rdo_show(reprompt(rdo2, filename = fn))

unlink(fn)
}
\keyword{RdoBuild}
%\keyword{RdoElements}

