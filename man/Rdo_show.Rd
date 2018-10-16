\name{Rdo_show}
\alias{Rdo_show}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Convert an Rd object to text and show it}
\description{Convert an Rd object to text and show it with \code{file.show()}.}
\usage{
Rdo_show(rdo)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object}
}

\value{
  Invisible \code{NULL}.
  The function is used for the side effect of showing the text
  representation of \code{rdo}.
}

\author{Georgi N. Boshnakov}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\examples{
## create a minimal Rd object
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class = TRUE )
\dontrun{
## run this interactively:    
Rdo_show(u1)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Rd}
