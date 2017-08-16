\name{Rdo_get_argument_names}
\alias{Rdo_get_argument_names}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Get the names of arguments in usage sections of Rd objects}
\description{Get the names of arguments in usage sections of Rd objects.}
\usage{
Rdo_get_argument_names(rdo)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rdo object.}
}
\details{

  All arguments names in the "arguments" section of \code{rdo} are
  extracted. If there is no such section, the results is a character
  vector of length zero.

  Arguments which have different descriptions for different OS'es
  are included and not duplicated.

  Arguments which have descriptions for a particular OS are included,
  irrespectively of the OS of the running R process.
  (\strong{todo:} introduce argument to control this?)

}
\value{
  a character vector
}
% \references{
% %% ~put references to the literature/web site here ~
% }
\author{Georgi N. Boshnakov}
% \note{
% %%  ~~further notes~~
% }
%
% %% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  \code{\link{Rdo_get_item_labels}}
}
\examples{
##---- Should be DIRECTLY executable !! ----
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }

