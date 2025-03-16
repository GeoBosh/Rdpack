\name{Rdo_locate_leaves}
\alias{Rdo_locate_leaves}
\title{Find leaves of an Rd object using a predicate}
\description{Apply a function to the character leaves of an Rd object
  and return the indices of those for which the result is TRUE.}
\usage{
Rdo_locate_leaves(object, f = function(x) TRUE)
}
\arguments{
  \item{object}{the object to be examined, usually a list.}
  \item{f}{a function (predicate) returning TRUE for elements with the
    desired property.
  }
}
\details{
  \code{object} can be any list whose elements are character strings or
  lists. The structure is examined recursively. If \code{object} is a
  character vector, it is enclosed in a list.

  This function provides a convenient way to locate leaves of an Rd
  object with a particular content. The function is not limited to Rd
  objects but it assumes that the elements of \code{object} are either
  lists or charater vectors and currently does not check if this is the
  case.

  \strong{todo:} describe the case of \code{list()} (\code{Rd_tag}'ed.)
}
\value{
  a list of the positions of the leaves for which the predicate gives
  \code{TRUE}. Each position is an integer vector suitable for the
  \code{"[["} operator.
}

\author{Georgi N. Boshnakov}

\examples{
dummyfun <- function(x) x

fn <- tempfile("dummyfun", fileext = "Rd")
reprompt(dummyfun, filename = fn)
rdo <- tools::parse_Rd(fn)

f <-  function(x) Rdo_is_newline(x)

nl <- Rdo_locate_leaves(rdo, f )

length(nl)  # there are quite a few newline leaves!

unlink(fn)
}
%\keyword{Rdlookup}
\keyword{Rd}
