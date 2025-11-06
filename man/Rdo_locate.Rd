\name{Rdo_locate}
\alias{Rdo_locate}
\title{Find positions of elements in an Rd object}
\description{
  Find positions of elements for which a function returns
  TRUE. Optionally, apply another function to the selected elements and
  return the results along with the positions.
}
\usage{
Rdo_locate(object, f = function(x) TRUE, pos_only = TRUE,
           lists = FALSE, fpos = NULL, nested = TRUE)
}
\arguments{
  \item{object}{an Rd object}
  \item{f}{a function returning TRUE if an element is desired and FALSE
    otherwise.}
  \item{pos_only}{if TRUE, return only the positions; if this argument
    is a function, return also the result of applying the function to
    the selected element, see Details.}
  \item{lists}{if FALSE, examine only leaves, if TRUE, examine also
    lists, see Details.}
  \item{fpos}{a function with two arguments, \code{object}
    and position,  it is called and the value is returned along with the
    position, see Details.}

  \item{nested}{a logical value, it has effect only when \code{lists} is
    TRUE, see `Details'.
  }
}
\details{

  With the default setting of \code{lists = FALSE}, the function
  \code{f} is applied to each leave (a character string) of the Rd
  object. If \code{lists = TRUE} the function \code{f} is applied also
  to each branch (a list). In this case, argument \code{nested} controls
  what happens when \code{f} returns TRUE. If \code{nested} is TRUE,
  each element of the list is also inspected recursively, otherwise this
  is not done and, effectively, the list is considered a leaf. If
  \code{f} does not return TRUE, the value of \code{nested} has no
  effect and the elements of the list are inspected.

  The position of each object for which \code{f} returns TRUE is
  recorded as a numeric vector.

  \code{fpos} and \code{pos_only} provide two ways to do something with
  the selected elements.  Argument \code{fpos} is more powerful than
  \code{pos_only} but the latter should be sufficient and simpler to use
  in most cases.

  If \code{fpos} is a function, it is applied to each selected element
  with two arguments, \code{object} and the position, and the result
  returned along with the position. In this case argument
  \code{pos_only} is ignored. If \code{fpos} is NULL the action depends
  on \code{pos_only}.

  If \code{pos_only = TRUE}, \code{Rdo_locate} returns a list of such
  vectors (not a matrix since the positions of the leaves are, in
  general, at different depths).

  If \code{pos_only} is a function, it is applied to each selected
  element and the result returned along with the position.
}
\value{
  a list with one entry for each selected element. Each entry is a
  numeric vector or a list with two elements:
  \item{pos}{the position, a vector of positive integers,}
  \item{value}{the result of applying the function to the element at
    \code{pos}.}
}
\author{Georgi N. Boshnakov}
\note{
  The following needs additional thought.

  In some circumstances an empty list, tagged with \code{Rd_tag} may
  turn up, e.g. \code{list()} with \verb{Rd_tag="\\dots"} in an
  \verb{\\arguments} section.

  On the one hand this is a list. On the other hand it may be considered
  a leaf. It is not clear if any attempt to recurse into such a list
  should be made at all.
}
\seealso{
  \code{\link{Rdo_sections}} and
  \code{\link{Rdo_locate_core_section}}
  which locate top level sections
}

\examples{
# todo: put examples here!
}
\keyword{Rd}
