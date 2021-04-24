\name{Rdo_modify_simple}

\alias{Rdo_modify_simple}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Simple modification of Rd objects}

\description{Simple modification of Rd objects.}

\usage{
Rdo_modify_simple(rdo, text, section, ...)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object.}
  \item{text}{a character vector}
  \item{section}{name of an Rd section, a string.}
  \item{\dots}{additional arguments to be passed to \code{Rdo_modify}.}
}

\details{

  Argument \code{text} is used to modify (as a replacement of or
  addition to) the content of section \code{section} of \code{rdo}.

  This function can be used for simple modifications of an Rd object
  using character content without converting it separately to Rd.

  \code{text} is converted to Rd with \code{char2Rdpiece(text, section)}.
  The result is passed to \code{Rdo_modify}, together with
  the remaining arguments.
}

\value{
  an Rd object
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{Rdo_modify}}
}

\keyword{RdoBuild}
