\name{rdo_text_restore}
\alias{rdo_text_restore}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Ensure exported fragments of Rd are as the original}
\description{

  For an Rd object imported from a file, this function ensures that
  fragments that were not not changed during the editing of the object
  remain unchanged in the exported file. This function is used by
  reprompt() to ensure exactly that. 

}
\usage{
rdo_text_restore(cur, orig, pos_list, file)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{cur}{an Rd object}
  \item{orig}{an Rd object}
  \item{pos_list}{a list of srcref objects specifying portions of files
    to replace, see 'Details'.}
  \item{file}{a file name, essentially a text representation of
    \verb{cur}.}
}
\details{

  This is essentially internal function. It exists because, in general,
  it is not possible to restore the original Rd file from the Rd object
  due to the specifications of the Rd format.  The file exported from
  the parsed Rd file is functionally equivalent to the original but
  equivalent things for the computer are not necessarily equally
  pleasant for humans.

  This function is used by \code{reprompt} when the source is from a
  file and the option to keep the source of unchanged sections as in the
  original.

  \strong{todo:} needs clean up, there are unnecessary arguments in
  particular.

}
\value{
  the main result is the side effect of replacing sections in
  \code{file} not changed by \code{reprompt} with the original ones.
}
\author{
  Georgi N. Boshnakov
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{reprompt}}
}
\keyword{RdoProgramming}
