\name{Rdo_tags}
\alias{Rdo_tags}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Give the Rd tags at the top level of an Rd object}
\description{Give the Rd tags at the top level of an Rd object.}
\usage{
Rdo_tags(rdo, nulltag = "")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object.}
  \item{nulltag}{a value to use when \code{Rd_tag} is missing or NULL.}
}
\details{

  The \verb{"Rd_tag"} attributes of the top level elements of \code{rdo} are
  collected in a character vector. Argument \code{nulltag} is used for
  elements without that attribute. This guarantees that the result is a
  character vector.

  \code{Rdo_tags} is similar to the internal function
  \code{tools:::RdTags}. Note that \code{tools:::RdTags} may return a
  list in the rare cases when attribute \code{Rd_tags} is not present in
  all elements of \code{rdo}.

%%  ~~ If necessary, more details than the description above ~~
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

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{Rdo_which}},
  \code{\link{Rdo_which_tag_eq}},
  \code{\link{Rdo_which_tag_in}}
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
}
\keyword{Rd}







