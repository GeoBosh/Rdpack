\name{Rdreplace_section}
\alias{Rdreplace_section}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Replace the contents of a section in one or more Rd files}
\description{Replace the contents of a section in one or more Rd files.}
\usage{
Rdreplace_section(text, sec, pattern, path = "./man", exclude = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{text}{the replacement text, a character string.}
  \item{sec}{the name of the section without the leading backslash, as
    for \code{Rdo_set_section}.}
  \item{pattern}{regular expression for R files to process, see
    Details.}
  \item{path}{the directory were to look for the Rd files.}
  \item{exclude}{regular expression for R files to exclude, see
    Details.}
  \item{\dots}{not used.}
}
\details{

  \code{Rdreplace_section} looks in the directory specified by
  \code{path} for files whose names match \code{pat} and drops those
  whose names match \code{exclude}. Then it replaces section \code{sec}
  in the files selected in this way.

  \code{Rdreplace_section} is a convenience function to replace a
  section (such as a keyword or author) in several files in one go.
  It calls \code{\link{Rdo_set_section}} to do the work.
}
\value{
  A vector giving the full names of the processed Rd files, but the
  function is used for the side effect of modifying them as described in
  section Details.
}
% \references{
% %% ~put references to the literature/web site here ~
% }
\author{
  Georgi N. Boshnakov
}
% \note{
% %%  ~~further notes~~
% }
%
%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{Rdo_set_section}}
}
\examples{
\dontrun{
# replace the author in all Rd files except pkgname-package
Rdreplace_section("A. Author", "author", ".*[.]Rd$", exclude = "-package[.]Rd$")
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{RdoBuild}


