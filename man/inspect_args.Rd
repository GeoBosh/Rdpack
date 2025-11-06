\name{inspect_args}

\alias{inspect_args}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Inspect the argument section of an Rd object
}

\description{
  Inspect the argument section of an Rd object.
}

\usage{
inspect_args(rdo, i_usage)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object describing functions.}
  \item{i_usage}{see Details.}
}

\details{
  \code{inspect_args} checks if the arguments in the documentation
  object \code{rdo} match the (union of) the actual arguments of the
  functions it describes.

  If \code{i_usage} is missing, it is computed by inspecting the current
  definitions of the functions described in \code{rdo}, see
  \code{inspect_usage}. This argument is likely to be supplied if the
  function calling \code{inspect_args} has already computed it for other
  purposes.
}


\value{
  TRUE if the arguments in the documentation match the (union of) the
  actual arguments of the described functions, FALSE otherwise.

  The returned logical value has attribute `details' which is a list
  with the following components.

  \item{rdo_argnames}{arguments described in the documentation object, \code{rdo}.}
  \item{cur_argnames}{arguments in the current definitions of the
    described functions.}
  \item{added_argnames}{new arguments}
  \item{removed_argnames}{removed (dropped) arguments.}
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~






% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
\keyword{RdoUsage}
%\keyword{RdFunction}
