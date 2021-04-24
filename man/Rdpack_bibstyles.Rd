\name{Rdpack_bibstyles}
\alias{Rdpack_bibstyles}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Set up a custom style for references in help pages}
\description{Set up a custom style for references in help pages.}
\usage{
Rdpack_bibstyles(package, authors)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{package}{the name of a package, a character string.}
  \item{authors}{if equal to "LongNames", use full names of authors in
    reference lists, see Details.}
}
\details{

  This is the initial implementation of support for styles for lists of
  bibliography references.

  Currently setting "authors" to "LongNames" will cause the references
  to appear with full names, eg John Smith rather than in the default
  Smith J style. 

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
  in .onLoad(), the function is used purely to set up a bibstyle as
  discussed in Details.

  Internally, \pkg{Rdpack} uses it to extract styles set up by packages: 

  - if called with argument \code{package} only, the style requested
    by that package;

  - if called with no arguments, a list of all styles.
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
