\name{Rdo_macro}

\alias{Rdo_macro}
\alias{Rdo_macro1}
\alias{Rdo_macro2}
\alias{Rdo_item}
\alias{Rdo_sigitem}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Format Rd fragments as macros (todo: a baffling title!)
}

\description{
  Format Rd fragments as macros, generally by putting them in a list and
  setting the "Rd_tag" as needed.
}

\usage{
Rdo_macro(x, name)

Rdo_macro1(x, name)

Rdo_macro2(x, y, name)

Rdo_item(x, y)

Rdo_sigitem(x, y, newline = TRUE)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{x}{an object.}
  \item{y}{an object.}
  \item{name}{the "\verb{Rd_tag}", a string.}
  \item{newline}{currently ignored.}
}

\details{
  \code{Rdo_macro1} wraps \code{x} in a list with "\verb{Rd_tag}"
  \code{name}. This is the representation of Rd macros with one argument.

  \code{Rdo_macro2} basically wraps a possibly transformed \code{x} and
  \code{y} in a list with "\verb{Rd_tag}" \code{name}. More specifically,
  if \code{x} has a non-NULL "\verb{Rd_tag}", \code{x} is wrapped in
  \code{list}. Otherwise \code{x} is left as is, unless \code{x} is a
  character string, when it is converted to a text Rd element and
  wrapped in \code{list}. \code{y} is processed in the same way.
  This is the representation of Rd macros with two arguments.

  \code{Rdo_macro} returns an object with "\verb{Rd_tag}" \code{name},
  constructed as follows. If \code{x} is not of class "character", its
  attribute "\verb{Rd_tag}" is set to \code{name} and the result
  returned without further processing. Otherwise, if it is of class
  "character", \code{x} is tagged as an Rd "TEXT" element. It is then
  wrapped in a list but only if \code{name} is one of "\verb{\eqn}" or
  "\verb{\deqn}". Finally, \code{Rdo_macro1} is called on the
  transformed object.

  \code{Rdo_item} is equivalent to \code{Rdo_macro2} with \code{name}
  set to "\verb{\item}".

  \code{Rdo_sigitem} is for items which have the syntax used in
  description of signatures. In that case the first argument of
  "\verb{\item}" is wrapped in "\verb{\code}". If \code{y} is missing,
  a text inviting the author to provide a description of the function
  for this signature is inserted.

}

\value{
  An Rd element with appropriately set \verb{Rd_tag}, as described in
  `Details'.
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
%\keyword{RdoElements}
\keyword{RdoBuild}
