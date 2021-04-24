\name{format_funusage}
\alias{format_funusage}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Format the usage text of functions}
\description{Formats the usage text of a function so that each line
  contains no more than a given number of characters.}
\usage{
format_funusage(x, name = "", width = 72, realname)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a character vector containing one element for each argument
    of the function, see `Details'.}
  \item{name}{the name of the function whose usage is described, a
    string.}
  \item{width}{maximal width of each line of output.}
  \item{realname}{the printed form of \code{name}, see `Details', a
    string.}
}
\details{
  \code{format_funusage} formats the usage text of a function for
  inclusion in Rd documentation files.  If necessary, it splits the text
  into more lines in order to fit it within the requested width.

  Each element of argument \code{x} contains the text for one argument
  of function \code{name} in the form \code{arg} or \code{arg = default}.
  \code{format_funusage} does not look into the content of
  \code{x}, it does the necessary pasting to form the complete usage
  text, inserting new lines and indentation to stay within the specified
  width.  Elements of \code{x} are never split. If an argument (i.e.,
  element of \code{x}) would cause the width to be exceeded, the entire
  argument is moved to the following line.

  The text on the second and subsequent lines of each usage item starts
  in the column just after the opening parenthesis which follows the
  name of the function on the first line.

  In descriptions of S3 methods and S4 methods, argument \code{name} may
  be a TeX macro like \verb{\method{print}{ts}}. In that case the number
  of characters in \code{name} has little bearing on the actual number
  printed. In this case argument \code{realname} is used for counting
  both the number of characters on the first line of the usage message
  and the indentation for the subsequent lines.

}

\value{
  The formatted text as a length one character vector.
}


\author{Georgi N. Boshnakov}
\note{
  Only the width of \code{realname} is used (for counting). The
  formatted text contains \code{name}.

  The width of strings is determined by calling \code{nchar} with
  argument \code{type} set to "width".
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{deparse_usage1}}
}
\examples{
# this function is essentially internal,
# see deparse_usage1 and as.character.f_usage which use it.
}
%\keyword{RdoProgramming}
\keyword{RdoUsage}
%\keyword{RdFunction}
