\name{Rdo_flatinsert}
\alias{Rdo_flatinsert}
\alias{Rdo_flatremove}
\title{Insert or remove content in an Rd fragment}
\description{Insert or remove content in an Rd fragment.}
\usage{
Rdo_flatinsert(rdo, val, pos, before = TRUE)

Rdo_flatremove(rdo, from, to)
}
\arguments{
  \item{rdo}{an Rd object.}
  \item{val}{the value to insert.}
  \item{pos}{position.}
  \item{before}{if TRUE, insert the new content at pos, pushing the
    element at pos forward.
  }
  \item{from}{beginning of the region to remove.}
  \item{to}{end  of the region to remove.}
}
\details{
  \code{Rdo_flatinsert} inserts \code{val} at position \code{pos},
  effectively by concatenation.

  \code{Rdo_flatremove} removes elements from \code{from} to \code{to}.
}
\value{
  the modified \code{rdo}
}
\author{Georgi N. Boshnakov}
% \seealso{
% %% ~~objects to See Also as \code{\link{help}}, ~~~
% }
%\examples{
%}
\keyword{ RdoProgramming }
