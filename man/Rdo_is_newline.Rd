\name{Rdo_is_newline}

\alias{Rdo_is_newline}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Check if an Rd fragment represents a newline character
}

\description{
  Check if an Rd fragment represents a newline character
}

\usage{
Rdo_is_newline(rdo)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
}

\details{
  This is a utility function that may be used to tidy up Rd objects.

  It returns TRUE if the Rd object represents a newline
  character, i.e. it is a character vector of length one containing the
  string \verb{"\n"}. Attributes are ignored.

  Otherwise it returns FALSE.
}

\value{
  TRUE or FALSE
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
%\keyword{RdoElements}
\keyword{RdoBuild}
