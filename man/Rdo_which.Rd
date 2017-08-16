\name{Rdo_which}
\alias{Rdo_which}
\alias{Rdo_which_tag_eq}
\alias{Rdo_which_tag_in}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Find elements of Rd objects for which a condition is true}
\description{Find elements of Rd objects for which a condition is true.}
\usage{
Rdo_which(rdo, fun)

Rdo_which_tag_eq(rdo, tag)

Rdo_which_tag_in(rdo, tags)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object.}
  \item{fun}{a function to evaluate with each element of \code{rdo}.}
  \item{tag}{a character string.}
  \item{tags}{a character vector.}
}
\details{

  These functions return the indices of the (top level) elements of
  \code{rdo} which satisfy a condition.

  \code{Rdo_which} finds elements of \code{rdo} for which
  the function \code{fun} gives TRUE.

  \code{Rdo_which_tag_eq} finds elements with a specific \code{Rd_tag}.

  \code{Rdo_which_tag_in} finds elements whose \code{Rd_tag}'s are among
  the ones specified by \code{tags}.

%%  ~~ If necessary, more details than the description above ~~
}
\value{
  a vector of positive integers
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
  \code{\link{Rdo_locate}} which searches recursively the Rd object.
}
\examples{
##---- Should be DIRECTLY executable !! ----
}
\keyword{Rd}
