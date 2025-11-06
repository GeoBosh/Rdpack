\name{Rdo_collect_aliases}
\alias{Rdo_collect_aliases}
\alias{Rdo_collect_metadata}
\title{Collect aliases or other metadata from an Rd object}
\description{Collect aliases or other metadata from an Rd object.}
\usage{
Rdo_collect_aliases(rdo)

Rdo_collect_metadata(rdo, sec)
}
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

  \code{Rdo_collect_metadata} is a generalisation of the above. It
  collects the metadata from section(s) \code{sec}, where \code{sec} is
  the name of a section without the leading backslash.
  \code{sec} is assumed to be a section containing a single word, such
  as "keyword", "alias", "name".

  Currently \code{Rdo_collect_metadata} is not exported.

}
\value{
  a named character vector, as described in Details.
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{tools:::.Rd_get_metadata}
}
\examples{
## this example originally (circa 2012) was:
##     infile <- file.path(R.home(), "src/library/base/man/timezones.Rd")
## but the OS conditional alias in that file has been removed.
## So, create an artificial example:
infile <- system.file("examples", "tz.Rd", package = "Rdpack")

## file.show(infile)
rd <- tools::parse_Rd(infile)

## The functions described here handle "ifdef" and similar directives.
## This detects OS specific aliases (windows = "onlywin" and unix = "onlyunix"):
Rdo_collect_aliases(rd)
Rdpack:::Rdo_collect_metadata(rd, "alias") # same

## In contrast, the following do not find "onlywin" and "onlyunix":
sapply(rd[which(tools:::RdTags(rd)=="\\alias")], as.character)
tools:::.Rd_get_metadata(rd, "alias")

Rdpack:::Rdo_collect_metadata(rd, "name")
Rdpack:::Rdo_collect_metadata(rd, "keyword")
}
\keyword{Rd}
