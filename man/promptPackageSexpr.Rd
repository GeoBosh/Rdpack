\name{promptPackageSexpr}
\alias{promptPackageSexpr}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Generates a shell of documentation for an installed package}
\description{
  Generates a shell of documentation for an installed package. The
  content is similar to `promptPackage' but information that can be
  computed is produced with Sexpr's so that it is always up to date.
}
\usage{
promptPackageSexpr(package, filename = NULL, final = TRUE,
                   overview = FALSE, bib = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{package}{name of a package, a string}
  \item{filename}{name of a file where to write the generated Rd
    content, a string. The default should be sufficient in most cases.}
  \item{final}{logical; if \code{TRUE} the content should be usable
    without manual editing.}
  \item{overview}{logical; if \code{TRUE} creates sections with hints
    what to put in them, otherwise such sections are written to the file
    but are commented out.}
  \item{bib}{If TRUE, create a comment line in the references section
    that will cause \code{\link{rebib}} to import all references from
    the default bib file.
  }
}
\details{
  The generated skeleton is functionally (almost) equivalent to that
  produced by \code{promptPackage}. The difference is that while
  \code{promptPackage} computes some information and inserts it verbatim
  in the skeleton, \code{promptPackageSexpr} inserts Sexpr's for the
  computation of the same information at package build time.

  In this way there is no need to manually update information like the
  version of the package. The index of functions (which contains
  their descriptions) does not need manual updating, as well.


  \code{promptPackageSexpr} needs to be called only once to create the
  initial skeleton. Then the Rd file can be edited as needed.

  If the Rd file is generated with the option \code{bib = TRUE} (or the
  appropriate lines are added to the refernces section manually) the
  references can be updated at any time by a call of \code{rebib}.


  todo: At the moment \code{final=FALSE} has the effect
  described for \code{overview}. At the time of writing this
  (2011-11-18) I do not remember if this is intentional or the
  corresponding `if' clause contains \code{|} by mistake.
}
\value{
  the name of the file (invisibly)
}

\author{Georgi N. Boshnakov}
\note{
  The automatically generated information is that of the installed (or
  at least built) package. Usually this is not a problem (and this is
  the idea of the function) but it means that if a developer is adding
  documentation for previously undocumented functions, they will appear
  in the 'Index' section only after the package is installed
  again. Similarly, if the description file of the package is changed,
  the package needs to be installed again for the changes to appear in
  the overview. Since the documentation is installed together with the
  package this is no surprise, of course. This may only cause a problem
  if documentation is produced with \code{R CMD Rd2pdf} before the
  updated version is installed.

  This function is not called \code{repromptXXX} since the idea is that
  it is called only once and then the Rd file can be edited freely, see
  also `Details'.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~



% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Rd}
