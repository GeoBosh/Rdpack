\name{Rdo_append_argument}

\alias{Rdo_append_argument}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Append an item for a new argument to an Rd object
}

\description{
  Append an item for a new argument to an Rd object.
}

\usage{
Rdo_append_argument(rdo, argname, description = NA, indent = "  ", create = FALSE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
  \item{argname}{name of the argument, a character vector.}
  \item{description}{description of the argument, a character vector.}
  \item{indent}{a string, typically whitespace.}
  \item{create}{not used (todo: remove?)}
}

\details{
  Appends one or more items to the section describing arguments of
  functions in an Rd object. The section is created if not present.

  If \code{description} is missing or NA, a "todo" text is inserted.

  The inserted text is indented using the string \code{indent}.

  The lengths of \code{argname} and \code{description} should normally
  be equal but if \code{description} is of length one, it is repeated to
  achieve this when needed.
}

\value{
  an Rd object
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
# the following creates Rd object rdo
dummyfun <- function(x) x
fn <- tempfile("dummyfun", fileext=".Rd")
reprompt(dummyfun, filename=fn)
rdo <- parse_Rd(fn)

dottext <- "further arguments to be passed on."

# rdo2 <- Rdo_append_argument(rdo, "\dots", dottext, create = TRUE)
rdo2 <- Rdo_append_argument(rdo, "\\dots", dottext, create = TRUE)
rdo2 <- Rdo_append_argument(rdo2, "z", "a numeric vector")
Rdo_show(reprompt(rdo2))

# todo: Rdo_show(rdob) for some reason does not show the arguments.
#       investigate! Rdo_show uses Rd2txt. Is it possible that the
#       latter needs srcref's in the Rd object? They are only refreshed
#       Rd_parse is called.


unlink(fn)

}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoBuild}
%\keyword{RdoElements}

