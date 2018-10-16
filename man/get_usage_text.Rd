\name{get_usage_text}

\alias{get_usage_text}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Get the text of the usage section of Rd documentation
}

\description{
  Get the text of the usage section of Rd documentation.
}

\usage{
get_usage_text(rdo)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object or a character string}
}

\details{
  If \code{rdo} is a string, it is parsed to obtain an Rd object.

  The content of section "\verb{\usage}" is extracted and converted to string.
}

\value{
  a string
}



\author{Georgi N. Boshnakov}

\note{
  todo: \code{get_usage_text} can be generalised to any Rd section but it is
        better to use a different approach since \code{print.Rd()} does not
        take care for some details (escaping \%, for example). Also, the
        functions that use this one assume that it returns \R code, which
        may not be the case if the usage section contains Rd comments.
}


%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
## get the Rd object documenting Rdo_macro
#h <- utils::help("Rdo_macro", lib.loc = .libPaths())
#rdo <- utils:::.getHelpFile(h)
rdo <- Rdo_fetch("Rdo_macro", "Rdpack")
# extract the usage section and print it:
ut <- get_usage_text(rdo)
cat(ut, sep = "\n")
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

%\keyword{RdoProgramming}
\keyword{RdoUsage}
%\keyword{RdFunction}
