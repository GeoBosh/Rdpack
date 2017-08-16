\name{.asym_compare}

\alias{.asym_compare}
\alias{.ocompare}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Tensor comparison and asymmetric comparison between two vectors}

\description{Tensor comparison and asymmetric comparison between two
  vectors.}

\usage{
.ocompare(x, y)

.asym_compare(x, y)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{x}{
%%     ~~Describe \code{x} here~~
}
  \item{y}{
%%     ~~Describe \code{y} here~~
}
}

\details{
  \code{.ocompare} (for "outer compare") returns a matrix whose (i,j)th
  element is TRUE if x[i] is identical to y[j], and FALSE otherwise.

  \code{.asym_compare} calls \code{.ocompare} and iterprets its result
  asymmetrically. Elements of \code{x} that are not in \code{y} ae
  considered "new". Similarly, Elements of \code{y} that are not in
  \code{x} ae considered "removed". Elements that are in both are
  "common".

  Todo: check if the above is correct or the other way round! !!!

}

\value{
  For \code{.ocompare}, a matrix as described in Details.

  For \code{.asym_compare} a list with indices as follows.
  \item{i_new}{new elements, indices in \code{x} of elements that are not
    in \code{y}.}
  \item{i_removed}{removed elements, indices in \code{y} of elements that are not
    in \code{x}.}
  \item{i_common}{common elements, indices in \code{x} of elements that
  are in both, \code{x} and \code{y}.}
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
##---- Should be DIRECTLY executable !! ----
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{internal}
