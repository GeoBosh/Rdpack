\name{Rdpack_bibstyles}
\alias{Rdpack_bibstyles}

\title{Set up a custom style for references in help pages}

\description{Set up a custom style for references in help pages.}

\usage{
Rdpack_bibstyles(package, authors)
}

\arguments{
  \item{package}{the name of a package, a character string.}
  \item{authors}{if equal to "LongNames", use full names of authors in
    reference lists, see Details.}
}

\details{

  This is the initial implementation of support for styles for lists of
  bibliography references.

  Currently setting \code{authors} to \code{"LongNames"} will cause the
  references to appear with full names, eg John Smith rather than in the
  default Smith J style.

  Package authors can request this feature by adding the following line
  to their \code{.onLoad} function (if their package has one):
\preformatted{
    Rdpack::Rdpack_bibstyles(package = pkg, authors = "LongNames")
}
  of just copy the following definition in a package that does not have
  \code{.onLoad}  : 
\preformatted{
    .onLoad <- function(lib, pkg){
        Rdpack::Rdpack_bibstyles(package = pkg, authors = "LongNames")
        invisible(NULL)
    }
}
  After building and installing the package the references should be
  using long names.

  
}
\value{
  if called with no arguments, a list of the names of all styles.

  if called with one argument (\code{package}) only, the name of the
  bib style, a character string, requested by that package. The style
  is created if hadn't been set up before. As a special case
  \code{package = ""} will return the default Rdpack style.

  if called with two arguments, the function set up a bibstyle as
  discussed in section \sQuote{Details}. It returns the name of that
  style.

}
%\references{
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{documentation}
\keyword{bibtex}
% use one of  RShowDoc("KEYWORDS")
