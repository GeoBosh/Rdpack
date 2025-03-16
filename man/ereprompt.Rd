\name{ereprompt}
\alias{ereprompt}
\title{Update an Rd file and open it in an editor}
\description{
  Update an Rd file and open it in an editor. This is a wrapper for
  reprompt with different defaults for some parameters.
}
\usage{
ereprompt(..., edit = TRUE, filename = TRUE)
}
\arguments{

  \item{\dots}{
    passed on to \code{\link{reprompt}}, see its documentation for
    details.}
  \item{edit}{if \code{TRUE}, the default, open an editor when finished.}
  \item{filename}{if \code{TRUE}, the default, replace and/or edit the
    original Rd file.}
}
\details{

  \code{ereprompt} calls \code{reprompt} to do the actual job but has
  different defaults for the arguments described on this page. By
  default, it replaces the original Rd file with the updated
  documentation and opens it in an editor. 

}
\value{
  called for the side effect of updating Rd documentation file and
  opening it in an editor
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
    \code{\link{reprompt}} which does the actual work
}
\examples{
## this assumes that the current working directory is
## in any subdirectory of the development directory of  Rdpack 
\dontrun{
ereprompt(infile = "reprompt.Rd")
}
}
\keyword{documentation}
% use one of  RShowDoc("KEYWORDS")
