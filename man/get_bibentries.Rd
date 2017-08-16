\name{get_bibentries}
\alias{get_bibentries}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Get all references from a Bibtex file}
\description{Get all references from a Bibtex file.}
\usage{
get_bibentries(\dots, package = NULL, bibfile = "REFERENCES.bib")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{arguments to be passed on to the file getting functions,
    character strings, see `Details'.}
  \item{package}{name of a package, a character string or NULL.}
  \item{bibfile}{name of a Bibtex file, a character string.}
}
\details{

  This function parses the specified file using \code{read.bib} from
  package "bibtex" and sets its \code{names} attribute to the keys of
  the bib elements.

  \code{bibfile} should normally be the base name of the Bibtex file.
  Calling \code{get_bibentries} without any \code{\dots} arguments
  results in looking for the Bibtex file in the current directory if
  package is NULL or missing, and in the installation directory of the
  specified package, otherwise.

  Argument "\dots" may be used to specify directories.
  If \code{package} is missing or NULL, the complete path is obtained
  with \code{file.path(..., bibfile)}. Otherwise \code{package} must be
  a package name and the file is taken from the installation directory
  of the package. Again, argument "\dots" can specify subdirectory
  as in \code{\link{system.file}}.

}
\value{
  a bibentry object
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
% \seealso{
% %% ~~objects to See Also as \code{\link{help}}, ~~~
% }
% \examples{
% }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ bibtex }
\keyword{programming}
