\name{get_bibentries}
\alias{get_bibentries}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Get all references from a Bibtex file}
\description{Get all references from a Bibtex file.}
\usage{
get_bibentries(\dots, package = NULL, bibfile = "REFERENCES.bib", 
               url_only = FALSE, stop_on_error = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{arguments to be passed on to the file getting functions,
    character strings, see `Details'.}
  \item{package}{name of a package, a character string or NULL.}
  \item{bibfile}{name of a Bibtex file, a character string.}
  \item{url_only}{
    if TRUE, restrict percent escaping to BibTeX field \code{"URL"}.} 
  \item{stop_on_error}{
    if \code{TRUE} stop on error, otherwise issue a warning and return
    an empty \code{bibentryRd} object.
  }
}
\details{

  \code{get_bibentries} parses the specified file using \code{read.bib}
  from package \pkg{bibtex} \insertCite{Rpack:bibtex}{Rdpack} and sets its
  \code{names} attribute to the keys of the bib elements
  (\code{read.bib()} does this since version version 0.4.0 of
  \pkg{bibtex}, as well). Here is what
  \code{get_bibentries} does on top of \code{read.bib} (the details are
  further below): 

  \itemize{
     \item \code{get_bibentries} deals with percent signs in URL's.

    \item if the current working directory is in the development
        directory of \code{package}, \code{get_bibentries} will first
        search for the bib file under that directory.
  }

  \code{bibfile} should normally be the base name of the Bibtex file.
  Calling \code{get_bibentries} without any \code{"\dots"} arguments
  results in looking for the Bibtex file in the current directory if
  package is NULL or missing, and in the installation directory of the
  specified package, otherwise.
  Argument "\dots" may be used to specify directories.
  If \code{package} is missing or NULL, the complete path is obtained
  with \code{file.path(..., bibfile)}. Otherwise \code{package} must be
  a package name and the file is taken from the installation directory
  of the package. Again, argument "\dots" can specify subdirectory
  as in \code{system.file}.

  If the current working directory is in the development directory of
  \code{package}, the bib file is first sought there before resorting to
  the installation directory.

  Although the base \R packages do not have files REFERENCES.bib,
  argument \code{package} can be set to one of them,
  e.g. \code{"base"}. This works since package \pkg{bibtex} provides bib
  files for the core packages.

  By default, \code{get_bibentries} escapes unescaped percent signs in
  all fields of bibtex objects. To restrict this only to field "url",
  set argument \code{url_only} to \code{FALSE}.

  \code{get_bibentries} returns an object from class
  \code{"bibentryRd"}, which inherits from bibentry. The printing method
  for \code{"bibentryRd"} unescapes percent signs in URLs for some
  styles where the escapes are undesirable. 

}
\value{
  a bibentryRd object inheriting from bibentry
}
\references{
  \insertAllCited{}
}
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
\examples{
r <- get_bibentries(package = "Rdpack")
r
print(r, style = "html")

b <- get_bibentries(package = "stats")
print(b[[1]], style = "R")
print(b[[1]], style = "citation")

## here the url field contains percent encoding
fn_url <- system.file("examples", "url_with_percents.bib", package = "Rdpack") 
u <- get_bibentries(bibfile = fn_url)

## the links produced by all of the following are valid
## and can be put in a browser
print(u, style = "html")
print(u, style = "bibtex")
print(u, style = "R")
print(u, style = "text")
print(u, style = "citation")

## The link here contains escapes but when put in a LaTeX document
## which uses the JSS style it generates correct clickable link,
## (see Details section) 
print(u, style = "latex")

## here the journal field contains percent encoding
fn_other <- system.file("examples", "journal_with_percents.bib", package = "Rdpack") 
j <- get_bibentries(bibfile = fn_url)
print(j, style = "html")
print(j, style = "bibtex")
print(j, style = "R")
print(j, style = "text")
print(j, style = "citation")
      
print(j, style = "latex")
}
\keyword{ bibtex }
\keyword{programming}
