\name{parse_usage_text}
\alias{parse_usage_text}
\alias{parse_1usage_text}
\title{
  Parse usage text
}
\description{
  Parse usage text.
}
\usage{
parse_1usage_text(text)
parse_usage_text(text)
}
\arguments{
  \item{text}{
    conceptually, the content of the usage section of one or more Rd objects, a
    character vector, see Details.
  }
}
\details{

  For \code{parse_usage_text}, \code{text} is a character vector
  representing the contents of the usage section of an Rdo object.
  \code{parse_usage_text} does some preprocessing of \code{text} then
  calls \code{parse_1usage_text} for each usage statement.
 
  The preprocessing changes "\verb{\\}\verb{dots}" to "\verb{...}" and
  converts S3- and S4-method descriptions to a form suitable for
  \code{parse()}. The text is then parsed (with \code{parse}) and
  "\verb{srcref}" attribute removed from the parsed object.

  todo: currently no checks is made for Rd comments in \code{text}.

  \code{parse_1usage_text} processes the usage statement of one object
  and calls \code{\link{pairlist2f_usage1}} to convert it to an object
  from S3 class \code{"f_usage"}.

}

\value{

  for \code{parse_1usage_text}, an object from S3 class
  \code{"f_usage"}, see \code{\link{pairlist2f_usage1}} for its
  structure.
  
  for \code{parse_usage_text}, a list containing one element for each
  usage entry, as prepared by \code{parse_1usage_text}

}
\author{Georgi N. Boshnakov}
\keyword{RdoUsage}
