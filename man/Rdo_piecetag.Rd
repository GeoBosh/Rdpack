\name{Rdo_piecetag}

\alias{Rdo_piecetag}
\alias{Rdo_sectype}
\alias{is_Rdsecname}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Give information about Rd elements
}

\description{
  Give information about Rd elements.
}

\usage{
Rdo_piecetag(name)

Rdo_sectype(x)

is_Rdsecname(name)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{name}{the name of an Rd macro, a string.}
  \item{x}{the name of an Rd macro, a string.}
}

\details{
  \code{Rdo_piecetag} gives the "Rd_tag" of the Rd macro \code{name}.

  \code{Rdo_sectype} gives the "Rd_tag" of the Rd section \code{x}.

  \code{is_Rdsecname(name)} returns TRUE if \code{name} is the name of a
  top level Rd section.

  The information returned by these functions is obtained from the
  charater vectors \code{Rdo_piece_types} and
  \code{Rdo_predefined_sections}.
}





\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~


\seealso{
  \code{\link{Rdo_piece_types}} and
  \code{\link{Rdo_predefined_sections}}
}

\examples{
Rdo_piecetag("eqn")  # ==> "VERB"
Rdo_piecetag("code") # ==> "RCODE"

Rdo_sectype("usage") # ==> "RCODE"
Rdo_sectype("title") # ==> "TEXT"

Rdo_sectype("arguments")
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoProgramming}
