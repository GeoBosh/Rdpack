\name{parse_Rdtext}

\alias{parse_Rdtext}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Parse Rd source text as the contents of a section
}

\description{
  Parse Rd source text as the contents of a given section.
}

\usage{
parse_Rdtext(text, section = NA)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{text}{Rd source text, a character vector.}
  \item{section}{the section name, a string.}
}

\details{

  If \code{section} is given, then \code{parse_Rdtext} parses
  \code{text} as appropriate for the content of section \code{section}.
  This is achieved by inserting \code{text} as an argument to the TeX
  macro \code{section}. For example, if \code{section} is
  "\verb{\usage}", then a line "\verb{\usage\{}" is inserted at the
  begiinning of \code{text} and a closing "\verb{\}}" at its end.

  If \code{section} is NA then \code{parse_Rdtext} parses it without
  preprocessing. In this case \code{text} itself will normally be
  a complete section fragment.
}

\value{
  an Rd fragment
}



\author{Georgi N. Boshnakov}

\note{
   The text is saved to a temporary file and parsed using
   \code{parse_Rd}. This is done for at least two reasons. Firstly,
   \code{parse_Rd} works most reliably (at the time of writing this)
   from a file. Secondly, the saved file may be slightly different
   (escaped backslashes being the primary example).
   It would be a nightmare to ensure that all concerned functions know
   if some Rd text is read from a file or not.

   The (currently internal) function \code{.parse_Rdlines} takes a
   character vector, writes it to a file (using \code{cat}) and calls
   \code{parse_Rd} to parse it.
}


%% ~Make other sections like Warning with \section{Warning }{....} ~


\seealso{
 \code{\link{parse_Rdpiece}}
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoProgramming}
