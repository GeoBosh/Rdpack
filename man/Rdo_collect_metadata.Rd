\name{Rdo_collect_metadata}
\alias{Rdo_collect_aliases}
\alias{Rdo_collect_metadata}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Collect aliases or other metadata from an Rd object}
\description{Collect aliases  or other metadata from an Rd object}
\usage{
Rdo_collect_aliases(rdo)

Rdo_collect_metadata(rdo, sec)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object}
  \item{sec}{the kind of metadata to collect, a character string, such
    as "alias" and "keyword".}
}
\details{
  \code{Rdo_collect_aliases} finds all aliases in \code{rdo} and returns
  them as a named character vector. The name of an alias  is usually the
  empty string, \code{""}, but it may also be  "windows" or "unix" if
  the alias is wrapped in a \verb{#ifdef} directive with the
  corresponding first argument.

  \code{Rdo_collect_metadata} is a generalisation of the above which
  collect the metadata from sections \code{sec}, where \code{sec} is the
  name of a section without the leading backslash.

  \code{sec} is assumed to be a section containing a single word,
  such as "keyword", "alias", "name".

}
\value{
  a named character vector, as described in details.
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{tools:::.Rd_get_metadata}
}
\examples{
\dontrun{
# this needs "timezones.Rd".

infile <- file.path(R.home(), "src/library/base/man/timezones.Rd")
rd <- parse_Rd(infile)

# The functions described here handle also "ifdef" and similar
# directives. This contains an element windows = "TZDIR"
Rdo_collect_aliases(rd)

# In contrast, the following do  not find "TZDIR"
sapply(rd[which(tools:::RdTags(rd)=="\\alias")], as.character)
tools:::.Rd_get_metadata(rd, "alias")
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Rd}



