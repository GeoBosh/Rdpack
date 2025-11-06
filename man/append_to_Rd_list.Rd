\name{append_to_Rd_list}

\alias{append_to_Rd_list}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Add content to the element of an Rd object or fragment at a given
  position
}

\description{
  Add content to the element of an Rd object or fragment at a given
  position.
}

\usage{
append_to_Rd_list(rdo, x, pos)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
  \item{x}{the content to append, an Rd object or a list of Rd objects.}
  \item{pos}{position at which to append \code{x}, typically an integer
    but may be anything accepted by the operator "[[".
  }
}

\details{
  The element  of \code{rdo} at position \code{pos} is replaced by its
  concatenation with \code{x}. The result keeps the "Rd_tag" of
  \code{rdo[[pos]]}.

  Argument \code{pos} may specify a position at any depth of the Rd
  object.

  This function is relatively low level and is mainly for use by other
  functions.
}

\value{
  the modified \code{rdo} object
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
#rdoseq <- utils:::.getHelpFile(help("seq"))
rdoseq <- Rdo_fetch("seq", "base")
iusage <- which(tools:::RdTags(rdoseq) == "\\\\usage")
iusage
attr(rdoseq[[iusage]], "Rd_tag")

## append a new line after the last usage line
rdoseq2 <- append_to_Rd_list(rdoseq, list(Rdo_newline()), iusage)

## Suppose that we wish to describe the function 'sequence' in the same Rd file.
## We append an usage statement for 'sequence()', without worrying about its
## actual signature.
rdoseq2 <- append_to_Rd_list(rdoseq2, list(Rdo_Rcode("sequence()")), iusage)
Rdo_show(rdoseq2)

## the two operations can be done in one step
rdoseq3 <- append_to_Rd_list(rdoseq, list(Rdo_newline(), Rdo_Rcode("sequence()")), iusage)
Rdo_show(rdoseq3)

## now run reprompt() to update rdoseq3, namely:
##    (1) it corrects the signature of 'sequence' in section \usage.
##    (2) reports new argument "nvec"
##    (3) inserts \item for the new argument(s) in section \arguments.
reprompt(rdoseq3, filename=NA)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
\keyword{RdoBuild}
