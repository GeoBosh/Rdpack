\name{inspect_signatures}

\alias{inspect_signatures}
\alias{inspect_clmethods}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Inspect signatures of S4 methods
}

\description{
  Inspect signatures of S4 methods.
}
\usage{
inspect_clmethods(rdo, final = TRUE)

inspect_signatures(rdo, package = NULL, sec = "Methods")
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object.}
  \item{package}{the name of a package, a character string or NULL.}
  \item{sec}{the name of a section to look into, a character string.}
  \item{final}{If not TRUE insert text with suggestions, otherwise
    comment the suggestions out.
  }
}

\details{

  Signatures in documentation of S4 classes and methods are stored
  somewhat differently. \code{inspect_signatures} inspects signatures in
  documentation of methods of a function.  \code{inspect_clmethods}
  inspects signatures in documentation of a class.

  \code{inspect_signatures} was written before
  \code{inspect_clmethods()} and was geared towards using existing code
  for ordinary functions (mainly \code{parse_usage_text()}.

  If new methods are found, the functions add entries for them in the Rd
  object \code{rdo}.

  If \code{rdo} documents methods that do not exist, a message inviting
  the user to remove them manually is printed but the offending entries
  remain in the object.
  At the time of writing, \verb{R CMD check} does not warn about this.

}

\value{
  an Rd object
}

\note{todo: need consolidation.}

\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~






% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoS4}
