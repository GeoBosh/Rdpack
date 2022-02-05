\name{viewRd}
\alias{viewRd}
\title{View Rd files in a source package}
\description{View Rd files in a source package.}
\usage{
viewRd(infile, type = getOption("help_type"), stages = NULL)
}
\arguments{
  \item{infile}{name of an Rd file, a character string.}
  \item{type}{one of \code{"text"} or \code{"html"}}
  \item{stages}{
    a character vector specifying which stages of the R installation
    process to immitate. The default,
    \code{c("build", "install", "render")}, should be fine in most cases.
  }
}
\details{

  This function can be used to view Rd files from the source directory
  of a package. The page is presented in text format or in html browser,
  according to the setting of argument \code{type}. The default is
  \code{getOption("help_type")}.

}
\value{
  the function is used for the side effect of showing the help page in a
  text help window or a web browser.
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
\note{

  Developers with \code{"devtools"} can use \code{viewRd()} instead of
  \code{help()} for documentation objects that contain Rd macros, such
  as \code{insertRef}, see vignette:

  \code{vignette("Inserting_bibtex_references", package = "Rdpack")}.

}
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%}
\keyword{documentation}
% use one of  RShowDoc("KEYWORDS")
