\name{list_Rd}
\alias{list_Rd}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Combine Rd fragments}
\description{Combine Rd fragments and strings into one object.}
\usage{
list_Rd(..., Rd_tag = NULL, Rd_class = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{named list of objects to combine, see `Details'.}
  \item{Rd_tag}{if non-null, a value for the \verb{Rd_tag} of the result.}
  \item{Rd_class}{logical; if TRUE, the result will be of class "Rd".}
}
\details{

  The names of named arguments specify tags for the corresponding
  elements (not arbitrary tags, ones that are converted to macro names
  by prepending backslash to them). This is a convenient way to specify
  sections, items, etc, in cases when the arguments have not being
  tagged by previous processing. Character string arguments are
  converted to the appropriate Rd pieces.

  Argument \code{...} may contain a mixture of character vactors and Rd
  pieces.
}
\value{
  an Rd object or list with \verb{Rd_tag} attribute, as specified by the
  arguments.
}

\author{Georgi N. Boshnakov}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
     \code{\link{c_Rd}}
}
\examples{
## see also the examples for c_Rd

dummyfun <- function(x, ...) x

u1 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x)",
              value = "numeric vector",
              author = "A. Author",
              Rd_class=TRUE )
Rdo_show(u1)

# call reprompt to fill the arguments section (and correct the usage)
fn <- tempfile("dummyfun", fileext = "Rd")
reprompt(dummyfun, filename = fn)

# check that the result can be parsed and show it.
Rdo_show(tools::parse_Rd(fn))

unlink(fn)
}
\keyword{RdoBuild}

