\name{dummyfun}
\alias{a1}
\alias{a2}
\alias{a3}
#ifdef windows
\alias{onlywin}
#endif
#ifdef unix
\alias{onlyunix}
#endif
\title{Example in Rdpack}
\description{Dummy description}
\usage{dummyfun(x)}
\details{Dummy details.
#ifdef unix
  These are on unix.
#endif
#ifdef windows
  These are on windows.
#endif
}
\examples{
dummyfun(1)
#ifdef windows
    ## example on Windows
#endif
#ifdef unix
\dontrun{
## need to supply a suitable file path (if any) for your system
## example on unix
}
#endif
}
\keyword{kw1}
\keyword{kw2}
