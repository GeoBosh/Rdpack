\name{Rdo_insert_element}

\alias{Rdo_insert_element}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Insert a new element in an Rd object
}

\description{
  Insert a new element at a given position in an Rd object.
}

\usage{
Rdo_insert_element(rdo, val, pos)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
  \item{val}{the content to insert.}
  \item{pos}{position at which to insert \code{val}, typically an integer
    but may be anything accepted by the operator "[[".
  }
}

\details{
  \code{val} is inserted at position \code{pos}, between the elements at
  positions \code{pos-1} and \code{pos}. If \code{pos} is equal to 1,
  \code{val} is prepended to \code{rdo}. If \code{pos} is missing or
  equal to the length of \code{rdo}, \code{val} is appended to
  \code{rdo}.

  todo: allow vector \code{pos} to insert deeper into the object.

  todo: character \code{pos} to insert at a position specified by "tag" for example?

  todo: more guarded copying of attributes?
}

\value{
  an Rd object
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
%\keyword{RdoElements}
\keyword{RdoBuild}
