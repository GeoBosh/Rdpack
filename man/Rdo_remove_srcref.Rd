\name{Rdo_remove_srcref}
\alias{Rdo_remove_srcref}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Remove srcref attributes from Rd objects}
\description{Removes srcref attributes from Rd objects.}
\usage{
Rdo_remove_srcref(rdo)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object}
}
\details{
  \code{srcref} attrbutes (set by \code{parse_Rd}) may be getting in the
  way during manipulation of Rd objects, such as comparisons, addition
  and replacement of elements. This function traverses the
  argument and removes the \code{srcref} attribute from all of its elements.
}
\value{
  an Rd object with no srcref attributes.
}

\author{Georgi N. Boshnakov}


%% ~Make other sections like Warning with \section{Warning }{....} ~


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{RdoProgramming}
