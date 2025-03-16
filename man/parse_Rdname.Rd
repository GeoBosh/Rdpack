\name{parse_Rdname}

\alias{parse_Rdname}

%- Also NEED an '\alias' for EACH other topic documented here.

\title{
  Parse the name section of an Rd object
}
\description{
  Parse the name section of an Rd object.
}

\usage{
parse_Rdname(rdo)
}

%- maybe also 'usage' for other objects documented here.

\arguments{
  \item{rdo}{an Rd object}
}

\details{
  The content of section "\verb{\name}" is extracted. If it contains a
  hyphen, `-', the part before the hyphen is taken to be the topic
  (usually a function name), while the part after the hyphen is the
  type. If the name does not contain hyphens, the type is set to the
  empty string.  }

\value{
  a list with two components:
  \item{fname}{name of the topic, usually a function}
  \item{type}{type of the topic, such as \verb{"method"}}
}



\author{Georgi N. Boshnakov}




%% ~Make other sections like Warning with \section{Warning }{....} ~




\examples{
u1 <- list_Rd(name = "Dummyname", alias = "Dummyallias1",
              title = "Dummy title", description = "Dummy description",
              Rd_class=TRUE )

parse_Rdname(u1)

u2 <- list_Rd(name = "dummyclass-class", alias = "Dummyclass",
              title = "Class dummyclass",
              description = "Objects and methods for something.",
              Rd_class=TRUE )

parse_Rdname(u2)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the

% R documentation directory.

\keyword{RdoProgramming}
