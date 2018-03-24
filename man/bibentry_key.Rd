\name{bibentry_key}
\alias{bibentry_key}
\title{Give the key associated with a bibentry element}
\description{Give the key associated with a bibentry element}
\usage{
bibentry_key(x)
}
\arguments{
  \item{x}{a single bibentry element.}
}
\details{

  2018-03-24: This function is deprecated (and not used in the package
  for a long time).
  
  This is a convenience function to get the "key" attribute of a
  reference represented by a bibentry element.

  There should be a better way to do this, I must be missing something
  here. (2018-03-24: indeed: \code{unlist(x$key)} or \code{x[[1]]$key},
  was this available back then?)
}
\value{
  a character string
}
\author{Georgi N. Boshnakov}

\keyword{bibtex}
\keyword{programming}
\keyword{internal}
