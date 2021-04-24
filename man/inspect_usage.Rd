\name{inspect_usage}

\alias{inspect_usage}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Inspect the usage section in an Rd object
}

\description{
  Inspect the usage section in an Rd object.
}

\usage{
inspect_usage(rdo)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object.}
}

\details{
  The usage section in the Rd object, \code{rdo}, is extracted and
  parsed. The usage of each function described in \code{rdo} is
  obtained also from the actual installed function and compared to the
  one from \code{rdo}.

  The return value is a list, with one element for each function usage
  as returned by \code{compare_usage1}.

  One of the consequences of this is that an easy way to add a usage
  description of a function, say \code{fu} to an existing Rd file is to
  simply add a line \code{fu()} to the usage section of that file and
  run \code{reprompt} on it.
}

\value{
  a list of comparison results as described in `Details'
  (todo: give more details here)
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{inspect_args}}
}


% \examples{
% ##---- Should be DIRECTLY executable !! ----
% }

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{ ~kwd1 }
\keyword{RdoUsage}
%\keyword{RdFunction}
