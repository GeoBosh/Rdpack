\name{c_Rd}
\alias{c_Rd}
\title{Concatenate Rd objects or pieces}
\description{Concatenates Rd objects or pieces}
\usage{
c_Rd(...)
}
\arguments{
  \item{\dots}{objects to be concatenated, Rd objects or character
    strings, see `Details'.
  }
}
\details{
  The arguments may be a mixture of lists and character strings. The
  lists are typically "Rd" objects or pieces. The character strings may
  also be elements of "Rd" objects carrying "Rd_tag" attributes. The
  "Rd_tag" attribute of character strings for which it is missing is set
  to "TEXT". Finally, each character element of \code{"\dots"} is
  enclosed in \code{list}.

  Eventually all arguments become lists and they are concatenated using
  \code{c()}. If any of the arguments is of class "Rd", the class of the
  result is set to "Rd". Otherwise, the "Rd_tag" of the result is set to
  the first (if any) non-null "Rd_tag" in the arguments.

  The structure of "Rd" objects is described by
  \insertCite{parseRd;textual}{Rdpack}.

}
\value{
  An Rd object or a list whose attribute "Rd_tag" is set as descibed in
  `Details' 
}

\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{list_Rd}}
}
\references{
  \insertAllCited{}
}
\examples{
a1 <- char2Rdpiece("Dummyname", "name")
a2 <- char2Rdpiece("Dummyallias1", "alias")
a3 <- char2Rdpiece("Dummy title", "title")
a4 <- char2Rdpiece("Dummy description", "description")

## The following are equivalent
## (gbRd::Rdo_empty() creates an empty list of class 'Rd')
if(requireNamespace("gbRd")){
b1 <- c_Rd(gbRd::Rdo_empty(), list(a1), list(a2), list(a3), list(a4))
c1 <- c_Rd(gbRd::Rdo_empty(), list(a1, a2, a3, a4))
d1 <- c_Rd(gbRd::Rdo_empty(), list(a1, a2), list(a3, a4))
identical(c1, b1)
identical(c1, d1)
Rdo_show(b1)

## insert a newline
d1n <- c_Rd(gbRd::Rdo_empty(), list(a1, a2), Rdo_newline(), list(a3, a4))
str(d1n)
}

## When most of the arguments are character strings
## the function 'list_Rd' may be more convenient.
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class = TRUE )
Rdo_show(u1)
}
\keyword{RdoBuild}
%\keyword{RdoProgramming}
