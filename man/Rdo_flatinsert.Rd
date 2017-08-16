\name{Rdo_flatinsert}
\alias{Rdo_flatinsert}
\alias{Rdo_flatremove}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Insert content in an Rd fragment}
\description{Insert content in an Rd fragment.}
\usage{
Rdo_flatinsert(rdo, val, pos, before = TRUE)

Rdo_flatremove(rdo, from, to)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object.}
  \item{val}{the value to insert.}2
  \item{pos}{poistion.}
  \item{before}{if TRUE insert pushing the elemnt at pos forward.}
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
% \references{
% %% ~put references to the literature/web site here ~
% }
\author{Georgi N. Boshnakov}
% \note{
% %%  ~~further notes~~
% }
%
% %% ~Make other sections like Warning with \section{Warning }{....} ~
%
% \seealso{
% %% ~~objects to See Also as \code{\link{help}}, ~~~
% }
% \examples{
% }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ RdoProgramming }
