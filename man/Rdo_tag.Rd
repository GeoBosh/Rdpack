\name{Rdo_tag}

\alias{Rdo_comment}
\alias{Rdo_verb}
\alias{Rdo_Rcode}
\alias{Rdo_text}
\alias{Rdo_tag}
\alias{Rdo_newline}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Set the Rd_tag of an object
}
\description{
  Set the Rd_tag of an object.
}
\usage{
Rdo_comment(x = "\%\%")

Rdo_tag(x, name)

Rdo_verb(x)

Rdo_Rcode(x)

Rdo_text(x)

Rdo_newline()
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{x}{an object, appropriate for the requested Rd_tag.}
  \item{name}{the tag name, a string.}
}

\details{
  These functions simply set attribute "\verb{Rd_tag}" of \code{x}, effectively
  assuming that the caller has prepared it as needed.

  \code{Rdo_tag} sets the "\verb{Rd_tag}" attribute of \code{x} to \code{name}.
  The other functions are shorthands with a fixed name and no second
  argument.

  \code{Rdo_comment} tags an Rd element as comment.

  \code{Rdo_newline} gives an Rd element representing an empty line.
}

\value{
  \code{x} with its "\verb{Rd_tag}" set to
        \code{name} (\code{Rdo_tag}),
        "TEXT" (\code{Rdo_text}),
        "VERB"  (\code{Rdo_verb}) or
        "RCODE"  (\code{Rdo_Rcode}).
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
%\keyword{RdoElements}
\keyword{RdoBuild}
