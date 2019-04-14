\name{makeVignetteReference}
\alias{makeVignetteReference}
\alias{vigbib}
\title{Make bibtex references for vignettes}
\description{Make bibtex references for vignettes}
\usage{
makeVignetteReference(package, vig = 1, verbose = TRUE, title, author, 
                      type = "pdf", bibtype = "Article", key = NULL)

vigbib(package, verbose = TRUE, \dots, vig = NULL)
}
\arguments{
  \item{package}{
    a character string, the name of an installed package.
  } 
  \item{vig}{
    an integer number or a character string identifying a vignette.
  }
  \item{verbose}{
    if \code{TRUE}, print the references in Bibtex format.
  }
  \item{title}{a character string, title of the vignette, see Details.}
  \item{author}{a character string, title of the vignette, see Details.}
  \item{type}{a character string, type of the vignette, such as
    \code{"pdf"} or \code{"html"}. Currently ignored.
  }
  \item{bibtype}{a character string, Bibtex type for the reference,
    defaults to \code{"Article"}.
  }
  \item{key}{a character string specifying a key for the Bibtex entry.
    If missing, suitable key is generated automatically.
  }
  \item{...}{
    arguments passed by \code{vigbib()} to \code{makeVignetteReference()}. 
  }
}
\details{

  \code{vigbib()} generates Bibtex references for all vignettes in a
  package. \code{makeVignetteReference()} produces a Bibtex entry for a
  particular vignette.

  There seems to be no standard way to cite vignettes in R packages.
  For vignettes that are complete journal papers (most notably in the
  Journal of Statistical Software), the authors would usually
  prefer the papers to be cited, rather than the vignette. In any case,
  consulting the output of \code{citation("a_package")} is the best
  starting point. If the vignette has been extended substantially after
  the paper was published, cite both.
  
  In many cases it is sufficient to give the command that opens the
  vignette, e.g.:

  \code{vignette("Inserting_bibtex_references", package = "Rdpack")}.

  \code{makeVignetteReference()} makes a Bibtex entry for one
  vignette. It looks for the available vignettes using
  \code{vignette(package=package)}. Argument \code{vig} can be a
  character string identifying the vignette by the name that would be
  used in a call to \code{vignette()}. It can also be an integer,
  identifying the vignette by the index (in the order in which the
  vignettes are returned by \code{vignette()}). By default the first
  vignette is returned. If \code{vig} is not suitable, a suitable list
  of alternatives is printed.

  For \code{vigbib()} it is sufficient to give the name of a package. It
  accepts all arguments of \code{makeVignetteReference()} except
  \code{vig} (actually, supplying \code{vig} is equivallent to calling
  \code{makeVignetteReference()} directly). 

  The remaining arguments can be used to overwrite some automatically
  generated entries. For example, the vignette authors may not be the
  same as the package authors.
  
}
\value{
  a bibentry object containing the generated references
  (the Bibtex entries are also printed, so that they can be copied to a
  bib file)
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
vigbib("Rdpack")
makeVignetteReference("Rdpack", vig = 1)
makeVignetteReference("Rdpack", vig = "Inserting_bibtex_references")
## the first few characters of the name suffice:
makeVignetteReference("Rdpack", vig = "Inserting_bib")

## this gives an error but also prints the available vignettes:
## makeVignetteReference("Matrix", vig = "NoSuchVignette")

vigbib("utils")
makeVignetteReference("utils", vig = 1)
## commented out since can be slow:
## high <- installed.packages(priority = "high")
## highbib <- lapply(rownames(high), function(x) try(Rdpack:::vigbib(x, verbose = FALSE)))
}
\keyword{bibtex}
% use one of  RShowDoc("KEYWORDS")
