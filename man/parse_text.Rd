\name{parse_text}
\alias{parse_text}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Parse expressions residing in character vectors}
\description{Parse expressions residing in character vectors.}
\usage{
parse_text(text, ..., keep = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{text}{the text to parse, normally a character vector but can be
    anything that \code{parse} accepts for this artgument.}
  \item{\dots}{additional arguments to be passed on to \code{parse}.}
  \item{keep}{required setting for option \verb{keep.source}, see
    details.}
}
\details{
  This is like \code{parse(text=text,\dots)} with the additional feature
  that if the setting of option "keep.source" is not as requested by
  argument \code{keep}, it is set to \code{keep} before calling
  \code{parse} and restored afterwards.

  This function is no longer exported by \pkg{Rdpack} since it is here
  for historical reasons and to avoid unnecessary dependence on
  \pkg{gbutils}. Use the equivalent \code{gbutils::parse_text} instead.
  
}
\value{
  an expression representing the parsed text, see \code{link{parse}} for
  details
}
\author{Georgi N. Boshnakov}
\note{
  The usual setting of option "keep.source" in interactive sessions is
  TRUE. However, in `R CMD check' it is FALSE.

  As a consequence, examples from the documentation may run fine when
  copied and pasted in an R session but (rightly) fail `R CMD check',
  when they depend on  option "keep.source" being \code{TRUE}.

}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{parse}},
  \code{\link[gbutils]{parse_text}}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{programming}
\keyword{internal}
