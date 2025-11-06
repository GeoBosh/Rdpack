\name{Rdo_show}
\alias{Rdo_show}
\title{Convert an Rd object to text and show it}
\description{Render an Rd object as text and show it.}
\usage{
Rdo_show(rdo)
}
\arguments{
  \item{rdo}{an Rd object}
}
\details{

  \code{Rdo_show} renders the help page represented by \code{rdo} as
  text and shows it with \code{file.show()}.

  \code{Rdo_show} is a simplified front end to \code{utils::Rd2txt}.
  See \code{\link{viewRd}} for more complete rendering, including of
  references and citations.

}
\value{
  Invisible \code{NULL}.
  The function is used for the side effect of showing the text
  representation of \code{rdo}.
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{viewRd}}
}
\examples{
## create a minimal Rd object
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class = TRUE )
\dontrun{
## run this interactively:    
Rdo_show(u1)
}
}
\keyword{Rd}
