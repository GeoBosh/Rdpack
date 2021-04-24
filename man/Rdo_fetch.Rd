\name{Rdo_fetch}
\alias{Rdo_fetch}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Get help pages as Rd objects}
\description{
  Get a help page as an Rd object from an installed or source package. 
}
\usage{
Rdo_fetch(Rd_name = character(0), package, dir = ".", installed = TRUE)
}
\arguments{
  \item{Rd_name}{
    names of one or more Rd help pages. \code{name} here is the name of
    an Rd file stripped from the extension.
  }
  \item{package}{
    the package from which to get the Rd object, a character string. 
  }
  \item{dir}{
    a character string giving the root directory of a source package.
    Used only if \code{package} is missing.
  }
  \item{installed}{
    if \code{TRUE}, the default, the Rd object is taken unconditionally
    from the installed \code{package}. 
    If \code{FALSE}, the help page may be taken from a source tree, if
    appropriate (typically if \code{package} is in `developer's mode
    under devtools, see Details). 
  }
}
\details{

  If \code{Rd_name} is a character string (typical use case), the
  corresponding help page is returned as an object from class
  \code{"Rd"}.  If the length of \code{Rd_name} is greater than one, the
  result is a Rd_named list containing the corresponding \code{"Rd"}
  objects.  The default \code{Rd_name = character(0)} requests all Rd
  pages in the package.

  Note that \code{Rd_name} does not contain the extention \code{".Rd"}
  but the names in the returned list do.

  Argument \code{package} names the package from which to fetch the
  documentation object. With the default \code{installed = TRUE} the
  object is taken unconditionally from the installed package. To get it
  from the source tree of a package, use argument \code{"dir"} instead.
  The default, \code{""}, for \code{dir} is suitable for workflows where
  the working directory is the root of the desired package.

  Argument \code{installed} concerns primarily development under package
  \code{"devtools"}. \code{"devtools"} intercepts and modifies several
  base \R commands, concerning access to system files and getting help,
  with the aim of rerouting them to the source trees of packages under
  developer's mode.  If argument \code{installed} is \code{TRUE}, the
  default, the requested pages are taken from the installed package,
  even if it is in development mode. If argument \code{installed} is
  \code{FALSE}, the Rd objects are taken from the corresponding source
  tree, if the specified package is under developer's mode, and from the
  installed package otherwise.
  
  Argument \code{Rd_name} is the name used in the \code{\\name} section
  of Rd files.

  When working off the source tree of a package, \code{Rdo_fetch}
  processes the Rd files, so \code{roxygen2} users need to update
  them if necessary.

}
\value{
  if \code{length(Rd_name) = 1}, an object of class \code{"Rd"},
  otherwise a list of \code{"Rd"} objects.
}
\author{Georgi N. Boshnakov}
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
## get a single help page
rdo <- Rdo_fetch("viewRd", package = "Rdpack")
Rdo_show(rdo)

## get a list of help pages
rdo <- Rdo_fetch(c("viewRd", "reprompt"), package = "Rdpack")
names(rdo)
}
\keyword{documentation}
% use one of  RShowDoc("KEYWORDS")
