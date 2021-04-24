\name{char2Rdpiece}

\alias{char2Rdpiece}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Convert a character vector to Rd piece
}

\description{
  Convert a character vector to Rd piece.
}

\usage{
char2Rdpiece(content, name, force.sec = FALSE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{content}{a character vector.}
  \item{name}{name of an Rd macro, a string.}
  \item{force.sec}{TRUE or FALSE, see `Details'.}
}

\details{

  Argument \code{content} is converted to an Rd piece using
  \code{name} to determine the format of the result.

  The \verb{Rd tag} of \code{content} is set as appropriate for \code{name}.
  More specifically, if \code{name} is the name of a macro (without the
  leading `\verb{\\}') whose content has a known "Rdtag", that tag is
  used. Otherwise the tag is set to "TEXT".

  If \code{force.sec} is TRUE, \code{name} is treated as the name of a
  top level section of an Rd object. A top level section is exported as
  one argument macro if it is a standard section (detected with
  \code{\link{is_Rdsecname}}) and as the two argument macro
  "\verb{\section}" otherwise.

  If \code{force.sec} is FALSE, the content is exported as one argument
  macro without further checks.
}





\author{Georgi N. Boshnakov}

\note{
  This function does not attempt to escape special symbols like `\%'.
}


%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
## add a keyword section
a1 <- char2Rdpiece("graphics", "keyword")
a1
## "keyword" is a standard Rd top level section, so 'force.sec' is irrelevant
a2 <- char2Rdpiece("graphics", "keyword", force.sec = TRUE)
identical(a1, a2)

## an element suitable to be put in a "usage" section
char2Rdpiece("log(x, base = exp(1))", "usage")

## a user defined section "Todo"
char2Rdpiece("Give more examples for this function.", "Todo", force.sec = TRUE)
}
%\keyword{RdoProgramming}
%\keyword{RdoElements}
\keyword{RdoBuild}

