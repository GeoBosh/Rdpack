\name{Rdo_insert}

\alias{Rdo_insert}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Insert a new element in an Rd object possibly surrounding it with new
  lines
}

\description{
  Insert a new element in an Rd object possibly surrounding it with new
  lines.
}

\usage{
Rdo_insert(rdo, val, newline = TRUE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
  \item{val}{the content to insert, an Rd object.}
  \item{newline}{a logical value, controls the insertion of new lines
    before and after \code{val}, see `Details'.
  }
}

\details{

  Argument \code{val} is inserted in \code{rdo} at an appropriate
  position, see \code{\link{Rdo_get_insert_pos}} for detailed
  explanation.

  If \code{newline} is TRUE, newline elements are inserted before and
  after \code{val} but only if they are not already there.

  Typically, \code{val} is a section of an Rd object and \code{rdo} is
  an Rd object which is being constructed or modified.

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
