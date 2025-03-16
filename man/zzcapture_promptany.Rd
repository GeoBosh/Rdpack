\name{.capture_promptAny}

\alias{.capture_promptAny}
\alias{.capture_installed_help}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{Internal functions used by reprompt}

\description{Internal functions used by reprompt.}

\usage{
.capture_promptAny(fnam, type, package, final, \dots, methods)

.capture_installed_help(fnam, type = NULL, package = NULL,
                        suffix = NULL)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{fnam}{extended name of the object, such as "fun", "gen-methods",
  "S4cl-class" or "pkname-package", see details.}
  \item{final}{if TRUE,  put dummy title and description to make the
  file immediately usable.}
  \item{\dots}{further arguments to pass on to the prompt function(s).}
  \item{methods}{methods to consider, used only when describing S4 methods.}
  \item{type}{type of documentation, such as "methods" and  "class", see
    Details.}
  \item{package}{the package where to look for objects or documentation,
    useful if more objects of the same name exist.}
  \item{suffix}{a character string to be appended to \code{fnam} to
    obtain the complete name of the help topic, e.g. "-class",
    "-method".
  }
}

\details{
  These functions are used internally by \code{reprompt}. It falls back
  to them when only when the user has not supplied an Rd file in the
  call.

  Note that for editing it is preferable to use the source Rd files
  (when available), since some hard coded information in the installed
  help may have been produced by more elaborated code in the Rd sources,
  most notably Sweave expressions.

  \code{.capture_promptAny} is used to generate documentation when none
  has been supplied by the user or loaded in the session.
  \code{.capture_promptAny} parses \code{fnam} to obtain the name of the
  object and the type of the required documentation (function, methods,
  class), then generates it. Currently this is done with the built in
  functions of the \code{promptXXX} family.

  \code{.capture_installed_help} does exactly that --- it captures the
  currently installed requested help topic. This function needs clean
  up. It was originally written at a time when both the old and new help
  formats where co-existing.
}

\value{
  an Rd object on success or a \code{try-error} object otherwise
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
##---- Should be DIRECTLY executable !! ----
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{internal}
