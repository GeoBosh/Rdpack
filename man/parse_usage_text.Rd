\name{parse_usage_text}

\alias{parse_usage_text}
\alias{parse_1usage_text}

%- Also NEED an '\alias' for EACH other topic documented here.

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

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{text}{content of the usage section of an Rd object, a character
    vector.}
}

\details{
  \code{parse_usage_text} does some preprocessing of \code{text} then
  calls \code{parse_1usage_text} for each usage statement.

  The preprocessing changes "\verb{\\}\verb{dots}" to "\verb{...}" and converts
  S3 method descriptions to a form suitable for \code{parse()}. The text
  is then parsed (with \code{parse}) and "\verb{srcref}" attribute
  removed from the parsed object.

  todo: currently no checks is made for Rd comments in \code{text}.

}

\value{
  a list containing one element for each usage entry, as prepared by
  \code{parse_1usage_text}
}
\author{Georgi N. Boshnakov}
\keyword{RdoUsage}
