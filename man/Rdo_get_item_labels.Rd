\name{Rdo_get_item_labels}
\alias{Rdo_get_item_labels}
\title{Get the labels of items in an Rd object}
\description{Get the labels of items in an Rd object.}
\usage{
Rdo_get_item_labels(rdo)
}
\arguments{
  \item{rdo}{an Rd object.}
}
\details{

  \code{Rdo_get_item_labels(rdo)} gives the labels of all
  \code{"\item"}s in \code{rdo}. Argument \code{rdo} is often a section
  or other Rd object fragment, see the examples.
  
}
\value{
  a character vector
}
\author{Georgi N. Boshnakov}
\examples{
infile <- system.file("examples", "tz.Rd", package = "Rdpack")
rd <- tools::parse_Rd(infile)

## get item labels found anywhere in the Rd object
(items <- Rdo_get_item_labels(rd))

## search only in section "arguments" (i.e., get argument names)
## (note [[1]] - there is only one arguments section)
pos.args <- Rdo_locate_core_section(rd, "\\\\arguments")[[1]]
(args <- Rdo_get_item_labels(rd[[pos.args$pos]]))

## search only in section "value"
pos.val <- Rdo_locate_core_section(rd, "\\\\value")[[1]]
(vals <- Rdo_get_item_labels(rd[[pos.val$pos]]))

## There are no other items in 'rd', so this gives TRUE:
all.equal(items, c(args, vals)) # TRUE
}
\keyword{RdoProgramming}
