\name{parse_Rdpiece}

\alias{parse_Rdpiece}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Parse a piece of Rd source text
}

\description{
  Parse a piece of Rd source text.
}

\usage{
parse_Rdpiece(x, result = "")
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{x}{the piece of Rd text, a character vector.}
  \item{result}{if "text", converts the result to printable text
  (e.g. to be shown to the user), otherwise returns an Rd object.}
}

\details{
  \code{parse_Rdpiece} parses a piece of source Rd text. The text may be
  an almost arbitrary piece that may be inserted in an Rd source file,
  except that it should not be a top level section (use
  \code{\link{parse_Rdtext}} for sections). Todo: it probably can be
  also a parsed piece, check!

  This is somewhat tricky since \code{parse_Rd} does not accept
  arbitrary piece of Rd text. It handles either a complete Rd source or
  a fragment, defined (as I understand it) as a top level section.  To
  circumvent this limitation, this function constructs a minimal
  complete Rd source putting argument \code{x} in a section (currently
  "Note") which does not have special formatting on its own. After
  parsing, it extracts only the part corresponding to \code{x}.

  \code{parse_Rdpiece} by default returns the parsed Rd piece. However,
  if \code{result="text"}, then the text is formatted as the help system
  would do when presenting help pages in text format.

  \strong{TODO:} add an argument for macros?

}

\value{
  a parsed Rd piece or its textual representation as described in Details
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
# the following creates Rd object rdo
dummyfun <- function(x) x
u1 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x,y)",
              value = "numeric vector",
              author = "A. Author",
              Rd_class = TRUE )
fn <- tempfile("dummyfun", fileext = "Rd")
reprompt(dummyfun, filename = fn)
rdo <- tools::parse_Rd(fn)

# let's prepare a new item
rd <- "\\\\item{...}{further arguments to be passed on.}"
newarg <- parse_Rdtext(rd, section = "\\\\arguments")

# now append 'newarg' to the arguments section of rdo
iarg <- which(tools:::RdTags(rdo) == "\\\\arguments")
rdoa <- append_to_Rd_list(rdo, newarg, iarg)

Rdo_show(rdoa)

# for arguments and other frequent tasks, there are specialised functions
dots <- paste0("\\\\", "dots")
rdob <- Rdo_append_argument(rdo, dots, "further arguments to be passed on.")

Rdo_show(reprompt(rdob, filename = fn))

unlink(fn)
}
\keyword{RdoProgramming}
