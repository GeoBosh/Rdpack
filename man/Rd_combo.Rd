\name{Rd_combo}

\alias{Rd_combo}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Manipulate a number of Rd files}

\description{Manipulate a number of Rd files.}

\usage{
Rd_combo(rd, f, ..., .MORE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rd}{names of Rd files, a character vector.}
  \item{f}{function to apply, see Details.}
  \item{\dots}{further arguments to pass on to \code{f}.}
  \item{.MORE}{another function to be applied for each file to the
    result of \code{f}.}
}

\details{

  \code{Rd_combo} parses each file in \code{rd}, applies \code{f} to the
  Rd object, and applies the function \code{.MORE} (if supplied) on the
  results of \code{f}.

  A typical value for \code{.MORE} is \code{reprompt} or another
  function that saves the resulting Rd object.

  todo: \code{Rd_combo} is already useful but needs further work.
}


%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
\dontrun{
rdnames <- dir(path = "./man", pattern=".*[.]Rd$", full.names=TRUE)

Rd_combo(rdnames, reprompt)
for(nam in rdnames) try(reprompt(nam))
for(nam in rdnames) try(reprompt(nam, sec_copy=FALSE))

}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{Rd}
%\keyword{Rdprocessing}
