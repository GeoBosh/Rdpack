\name{Rdo_sections}
\alias{Rdo_sections}
\alias{Rdo_locate_core_section}
\title{Locate the sections in Rd objects}
\description{Locate the Rd sections in an Rd object and return a list of
  their positions and names.}
\usage{
Rdo_sections(rdo)

Rdo_locate_core_section(rdo, sec)
}
\arguments{
  \item{rdo}{an Rd object.}
  \item{sec}{the name of a section, a character string. For builtin
    sections the leading backslash should be included.}
}
\details{

  \code{Rdo_sections} locates all sections at the top level in an Rd
  object. This includes the predefined sections and the user defined
  sections. Sections wrapped in \verb{#ifdef} directives are also found.

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
  one. 

  \insertCite{parseRd}{Rdpack}  % only for testing!
  \insertCite{Rpack:bibtex}{Rdpack}  % only for testing!

}
\value{
  A list giving the positions and titles of the sections in \code{rdo}
  as described in 'Details'. The format is essentially that of
  \code{\link{Rdo_locate}}, the difference being that field  "value"
  from that function is renamed to "title" here.

  \item{pos}{the position, a vector of positive integers,}
  \item{title}{a standard section name, such as \verb{"\\name"} or, in
    the case of "\\section", the actual title of the section.
  }
}
\author{Georgi N. Boshnakov}
\note{
  
  I wrote \code{Rdo_sections} and \code{Rdo_locate_core_section} after
  most of the core functionality was tested. Currently these functions
  are underused---they can replace a number of internal and exported
  functions.

}
\seealso{
  \code{\link{Rdo_locate}}
}
\references{
\insertAllCited{} % only for testing
}
\examples{
infile <- system.file("examples", "tz.Rd", package = "Rdpack")
rd <- tools::parse_Rd(infile)

## Locate all top level sections in rd
sections <- Rdo_sections(rd)
## How many sections there are in rd?
length(sections)
## What are their titles?
sapply(sections, function(x) x$title)

## The names of builtin sections include the backslash
Rdo_locate_core_section(rd, "\\\\title")

## Locate a user defined secion
Rdo_locate_core_section(rd, "Further information")

## The names of builtin sections include the backslash
Rdo_locate_core_section(rd, "\\\\details")

## All appearances of the requested section are returned
Rdo_locate_core_section(rd, "\\\\alias")
Rdo_locate_core_section(rd, "\\\\keyword")
}
\keyword{Rd}


