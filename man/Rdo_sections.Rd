\name{Rdo_sections}
\alias{Rdo_sections}
\alias{Rdo_locate_core_section}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Locate the sections in Rd objects}
\description{Locate the Rd sections in an Rd object and return a list of
  their positions and names.}
\usage{
Rdo_sections(rdo)

Rdo_locate_core_section(rdo, sec)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object.}
  \item{sec}{the name of a section, a character string.}
}
\details{

  \code{Rdo_sections} locates all sections allowed at the top level in
  an Rd object. This includes the predefined sections and the user
  defined sections. Sections wrapped in \verb{#ifdef} directives are
  also found.

  \code{Rdo_sections} returns a list with one entry for each section in
  \code{rdo}. This entry is a list with components \code{"pos"} and
  \code{"title"} giving the position (suitable for use in \verb{"[["})
  and the title of the section.  For user defined sections the actual
  name is returned, not "section".

  The names of the sections are returned as single strings without
  attributes. The titles of predefined sections are single words but
  user defined sections may have longer titles and sometimes contain
  basic markup.

  \code{Rdo_locate_core_section} works similarly but returns only the
  results for section \code{sec}. Currently it simply calls
  \code{Rdo_sections} and returns only the results for \code{sec}.

  Note that for consistency \code{Rdo_locate_core_section} does not
  attempt to simplify the result in the common case when there is only
  one instance of the requested section---it is put in a list of length
  one. \strong{todo:} maybe create a convenience function for this case
  or (better) introduce an argument to request dropping the outer list?

}
\value{
  A list giving the positions and titles of the sections in \code{rdo}
  as described in 'Details'. The format isessentially that of
  \code{\link{Rdo_locate}}, the difference being that field  "value"
  from that function is renamed to "title" here.

  \item{pos}{the position, a vector of positive integers,}
  \item{title}{a standard section name, such as \verb{"\\name"} or, in
    the case of "\\section", the actual title of the section.
  }
}
\author{Georgi N. Boshnakov}
\note{
  I wrote \code{Rdo_sections} after most of the core functionality was
  tested. Currently this function is underused---it can replace
  a number of internal functions,
}
\seealso{
  \code{\link{Rdo_locate}}
}

\keyword{Rd}


