\name{insert_citeOnly}
\alias{insert_citeOnly}
\title{Generate citations from bibtex keys}
\description{Generate citations from bibtex keys.}
\usage{
insert_citeOnly(keys, package = NULL, before = NULL, after = NULL,
                bibpunct = NULL, ..., cached_env = NULL,
                cite_only = FALSE, dont_cite = FALSE)
}
\arguments{
  \item{keys}{

    a character string containing bibtex key(s) prefixed with the symbol
    \code{@}, intermixed with free text. The format is the same as for
    Rd macro \verb{\\insertCite}. Put \verb{;textual} at the end of the
    string to get a textual citation. Similarly, \verb{;nobrackets}
    requests parenthesised citation without the enclosing parentheses.

  }
  \item{package}{name of an R package.}
  \item{before}{see \code{\link{citeNatbib}}.}
  \item{after}{see \code{\link{citeNatbib}}.}
  \item{bibpunct}{see \code{\link{citeNatbib}}.}
  \item{\dots}{further arguments; for internal use.}
  \item{cached_env}{for internal use.}
  \item{cite_only}{for internal use.}
  \item{dont_cite}{for internal use.}
}
\details{

  This is the function behind \verb{\\insertCite} and related macros.
  Argument \code{"keys"} has the syntax of the first argument of
  \verb{\\insertCite}.

}
\value{
  a character vector containing the references with Rd markup
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{insert_ref}} for description of all available Rd macros
}
\examples{
insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd", package = "Rdpack")
## (see also Boshnakov and Putman 2020 and Murdoch 2010)

insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd;nobrackets",
  package = "Rdpack")
## see also Boshnakov and Putman 2020 and Murdoch 2010

insert_citeOnly("@see also @Rpackage:rbibutils and @parseRd;textual",
  package = "Rdpack")
## see also Boshnakov and Putman (2020) and Murdoch (2010)
}
\keyword{documentation}
