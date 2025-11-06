\name{Rdo_modify}

\alias{Rdo_replace_section}
\alias{Rdo_modify}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Replace or modify parts of Rd objects
}

\description{
  Replace or modify parts of Rd objects.
}

\usage{
Rdo_modify(rdo, val, create = FALSE, replace = FALSE, top = TRUE)

Rdo_replace_section(rdo, val, create = FALSE, replace = TRUE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object.}
  \item{val}{an Rd fragment.}
  \item{create}{if TRUE, create a new section, see `Details'.}
  \item{replace}{a logical, if TRUE \code{val} replaces the old content,
    otherwise \code{val} is concatenated with it, see `Details'.
  }
  \item{top}{a logical, if TRUE examine also the "Rd_tag" of \code{rdo},
    see `Details'.
  }
}

\details{

  Argument \code{rdo} is an Rd object (complete or a fragment) to be
  modified. \code{val} is an Rd fragment to use for modification.

  Basically, \code{val} is appended to (if \code{replace} is FALSE) or
  replaces (if \code{replace} is TRUE) the content of an element of
  \code{rdo} which has the same "Rd_tag" as \code{val}.

  Argument \code{top} specifies whether to check the "Rd_tag" of
  \code{rdo} itself, see below.

  Here are the details.

  If \code{top} is TRUE and \code{rdo} and \code{val} have the same
  (non-NULL) "Rd_tag", then the action depends on \code{replace}
  (argument \code{create} is ignored in this case).
  If \code{replace} is TRUE, \code{val} is returned. Otherwise
  \code{rdo} and \code{val} are, effectively, concatenated. For example,
  \code{rdo} may be the "arguments" section of an Rd object and
  \code{val} may also be an "arguments" section containing new
  arguments.

  Otherwise, an element with the "Rd_tag" of \code{val} is searched in
  \code{rdo} using \code{tools:::RdTags()}. If such elements are found,
  the action again depends on \code{replace}.

  \enumerate{
    \item
    If \code{replace} is a character string, then the first element of
    \code{rdo} that is a list whose only element is identical to the
    value of \code{replace} is replaced by \code{val}. If such an
    element is not present and \code{create} is TRUE, \code{val} is
    inserted in \code{rdo}. If \code{create} is FALSE, \code{rdo} is not
    changed.

    \item
    If \code{replace} is TRUE, the first element found is replaced with
    \code{val}.

    \item
    If \code{replace} is FALSE, \code{val} is appended to the first
    element found.
  }

  If no element with the "Rd_tag" of \code{val} is found the action
  depends on \code{create}.  If \code{create} is TRUE, then \code{val}
  is inserted in \code{rdo}, effectively creating a new section. If
  \code{create} is FALSE, an error is thrown.

  \code{Rdo_replace_section} is like \code{Rdo_modify} with argument
  \code{top} fixed to TRUE and the default for argument \code{replace}
  set to TRUE. It hardly makes sense to call \code{Rdo_replace_section}
  with \code{replace = FALSE}  but a character value for it may be
  handy in some cases, see the examples.
}

\value{
  an Rd object or fragment, as described in `Details'
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
# a <- tools::parse_Rd("./man/promptUsage.Rd")
# char2Rdpiece("documentation", "keyword")

# this changes a keyword from Rd to documentation
# Rdo_replace_section(a, char2Rdpiece("documentation", "keyword"), replace = "Rd")
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoBuild}
