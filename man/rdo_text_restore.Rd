\name{rdo_text_restore}
\alias{rdo_text_restore}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{~~ Dummy title ~~}
\description{~~ Dummy description ~~}
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
  This is an auxilliary function.

  todo: needs clean up,  there are unnecessary arguments in particular.

  This is used by \code{reprompt} when the source is from a file and the
  option to keep the source of unchanged sections as in the original.
  (Note that, in general, it is not possible to restore the original Rd
  file from the Rd object due to the specifications of the Rd
  format. However, equivalent things for the computer are not
  necessarily equally pleasant for humans.
}
\value{
  the main result is the side effect of replacing sections in
  \code{file} not changed by \code{reprompt} with the original ones.
}
\author{
  Georgi N. Boshnakov
}
% \note{
% %%  ~~further notes~~
% }

%% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{
% %% ~~objects to See Also as \code{\link{help}}, ~~~
% }
\keyword{RdoProgramming}
