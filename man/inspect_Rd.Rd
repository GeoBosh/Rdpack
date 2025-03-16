\name{inspect_Rd}

\alias{inspect_Rd}
\alias{inspect_Rdfun}
\alias{inspect_Rdmethods}
\alias{inspect_Rdclass}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Inspect and update an Rd object or file
}
\description{
  Inspect and update an Rd object or file.
}

\usage{
inspect_Rd(rdo, package = NULL)

inspect_Rdfun(rdo, alias_update = TRUE)

inspect_Rdmethods(rdo, package = NULL)

inspect_Rdclass(rdo)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object or file name}
  \item{package}{name of a package}
  \item{alias_update}{if \code{TRUE}, add missing alias entries for
    functions with usage statements.}
}

\details{
  These functions check if the descriptions of the objects in \code{rdo}
  are consistent with their current definitions and update them, if
  necessary. The details depend on the type of the documented topic.
  In general, the functions update entries that can be produced
  programmatically, possibly accompanied with a suggestion to the author
  to write some additional text.

  \code{inspect_Rd} checks the \verb{\name} section of \code{rdo} and
  dispatches to one of the other \code{inspect_XXX} functions depening
  on the type of the topic.

  \code{inspect_Rdfun} processes documentation of functions.  It checks
  the usage entries of all functions documented in \code{rdo} and
  updates them if necessary. It appends "\verb{\alias}" entries for
  functions that do not have them. Entries are created for any arguments
  that are missing from the "\verb{\arguments}" section. Warning is
  given for arguments in the "\verb{\arguments}" section that are not
  present in at least one usage entry. \code{inspect_Rdfun} understands
  the syntax for S3 methods and S4 methods used in "usage" sections, as
  well. The S4 methods may also be in a section as produced by
  \code{promptMethods}. 

  \code{inspect_Rdmethods} checks and updates documentation of an S4
  generic function.

  \code{inspect_Rdclass} checks and updates documentation of an S4
  class.

  Since method signatures and descriptions  may be present in
  documentation of a class, as well as in that of methods, the question
  arises where to put "\verb{\alias}" entries to avoid duplication.
  Currently, alias entries are put in method descriptions.
}





\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




% \examples{
% ##---- Should be DIRECTLY executable !! ----
% }

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoProgramming}
