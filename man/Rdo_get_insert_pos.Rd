\name{Rdo_get_insert_pos}

\alias{Rdo_get_insert_pos}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Find the position of an "Rd_tag"
}

\description{
  Find the position of an "Rd_tag".
}

\usage{
Rdo_get_insert_pos(rdo, tag)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
  \item{tag}{the "Rd_tag" to search for, a string}
}

\details{

  This function returns a position in \code{rdo}, where the next element
  carrying "Rd_tag" \code{tag} should be inserted. The position is
  determined as follows.

  If one or more elements of \code{rdo} have "Rd_tag" \code{tag}, then
  the position is one plus the position of the last such element.

  If there are no elements with "Rd_tag" \code{tag}, the position is one
  plus the length of \code{rdo}, unless \code{tag} is a known top level
  Rd section. In that case, the position is such that the standard
  ordering of sections in an Rd object is followed. This is set in the
  internal variable \code{.rd_sections}.
}

\value{
  an integer
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
h <- help("Rdo_macro")
rdo <- utils:::.getHelpFile(h)

ialias <- which(tools:::RdTags(rdo) == "\\\\alias")
next_pos <- Rdo_get_insert_pos(rdo, "\\\\alias") # 1 + max(ialias)
stopifnot(next_pos == max(ialias) + 1)

ikeyword <- which(tools:::RdTags(rdo) == "\\\\keyword")
next_pos <- Rdo_get_insert_pos(rdo, "\\\\keyword") # 1 + max(ikeyword)
stopifnot(next_pos == max(ikeyword) + 1)

}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoProgramming}
