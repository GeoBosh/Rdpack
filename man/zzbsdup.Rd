\name{.bsdup}

\alias{.bsdup}
\alias{.bspercent}
\alias{.anypercent}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Escape backslashes and percent in Rd code}

\description{Escape backslashes and percent in Rd code.}

\usage{

.bspercent(x)

.anypercent(x)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{x}{a character string}
}

\details{
  \code{.bsdup(x)} duplicates backslashes.

  \code{.bspercent(x)} escapes  percent signs.

  \code{.anypercent(x)} also escapes percent signs but but only if the
  \code{Rd_tag} attribute of \code{x} is not COMMENT.

}





\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
##---- Should be DIRECTLY executable !! ----
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{internal}
