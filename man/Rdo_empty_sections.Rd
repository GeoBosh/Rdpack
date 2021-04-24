\name{Rdo_empty_sections}

\alias{Rdo_empty_sections}
\alias{Rdo_drop_empty}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Find or remove empty sections in Rd objects}

\description{Find or remove empty sections in Rd objects}

\usage{
Rdo_empty_sections(rdo, with_bs = FALSE)

Rdo_drop_empty(rdo, sec = TRUE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object or Rd source text.}
  \item{with_bs}{if \code{TRUE} return the section names with the
    leading backslash.}
  \item{sec}{not used}
}
\details{
  The function \code{checkRd} is used to determine which sections are
  empty.
}

\value{
  For \code{Rdo_empty_sections}, the names of the empty sections as a
  character vector.

  For \code{Rdo_drop_empty}, the Rd object stripped from empty
  sections.
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
dummyfun <- function(x) x
rdo8 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x,y)",
              value = "numeric vector",
              author = "",
              details = "",
              note = "",
              Rd_class=TRUE )

Rdo_empty_sections(rdo8)        # "details" "note"    "author"

rdo8a <- Rdo_drop_empty(rdo8)
Rdo_empty_sections(rdo8a)       # character(0)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{Rdprocessing}
\keyword{RdoBuild}

