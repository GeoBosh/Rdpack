\name{Rdo_set_section}

\alias{Rdo_set_section}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Replace a section in an Rd file
}

\description{
  Replace a section in an Rd file.
}

\usage{
Rdo_set_section(text, sec, file, \dots)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{text}{the new text of the section, a character vector.}
  \item{sec}{name of the section.}
  \item{file}{name of the file.}
  \item{...}{arguments to be passed on to \code{Rdo_modify}.}
}

\details{
  Parses the file, replaces the specified section with the new content
  and writes the file back. The text is processed as appropriate for the
  particular section (\code{sec}).

  For example:

  \code{Rdo_set_section("Georgi N. Boshnakov", "author", "./man/Rdo2Rdf.Rd")}

  (Some care is needed with the author field for "xxx-package.Rd" files, such
  as  "Rdpack-package.Rd",  where the \verb{Author(s)} field has
  somewhat different layout.)

  By default \code{Rdo_set_section} does not create the section if it
  does not exist, since this may not be desirable for some Rd files.  The
  "..."  arguments can be used to change this, they are passed on to
  \code{\link{Rdo_modify}}, see its documentation for details.

}

\value{
  This function is used mainly for the side effect of changing \code{file}.
  It returns the Rd formatted text as a character vector.
}



\author{Georgi N. Boshnakov}

%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
  \code{\link{Rdo_modify}}
}
\examples{
fnA <- tempfile("dummyfun", fileext = "Rd")
dummyfun <- function(x) x
reprompt(dummyfun, filename = fnA)
Rdo_show(tools::parse_Rd(fnA))

## set the author section, create it if necessary.
Rdo_set_section("A.A. Author", "author", fnA, create = TRUE)
Rdo_show(tools::parse_Rd(fnA))

## replace the author section
Rdo_set_section("Georgi N. Boshnakov", "author", fnA)
Rdo_show(tools::parse_Rd(fnA))

unlink(fnA)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoBuild}
