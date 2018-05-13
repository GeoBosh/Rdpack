\name{insert_all_ref}
\alias{insert_all_ref}
\title{Insert references cited in packages}
\description{Insert references cited in packages. }
\usage{
insert_all_ref(refs)
}
\arguments{
  \item{refs}{
    a matrix specifying key-package pairs of the references to insert,
    see Details.
  }
}
\details{

  \code{insert_all_ref} is the work horse behind several Rd macros for
  inclusion of references in Rd documentation.

  Argument \code{refs} is a two-column character matrix.  The first
  column specifies bibtex keys.  To specify more than one key in a
  single element, separate them by commas. The second row specifies the
  package in which to look for the keys.

  A key equal to "*" requests in keys in the corresponding package. 
  
  \code{insert_all_ref} drops duplicated keys, collects the references,
  and converts them to Rd textual representation for inclusion in Rd
  documentation files.
  
}
\value{
  for \code{insert_all_ref}, a character string containing a textual
  representation of the references, suitable for inclusion in an Rd
  file 
}
\references{
  \insertAllCited{}
}
\author{Georgi N. Boshnakov}
% \note{
% %%  ~~further notes~~
% }
% 
% %% ~Make other sections like Warning with \section{Warning }{....} ~
% 
% \seealso{
% %% ~~objects to See Also as \code{\link{help}}, ~~~
% }
\examples{
bibs <- bibtex::read.bib(package = "tools")
bibs


## a reference from package Rdpack
cat(insert_all_ref(matrix(c("Rpack:bibtex", "Rdpack"), ncol = 2)), "\n")

## more than one reference from package Rdpack, separate the keys with commas
cat(insert_all_ref(matrix(c("parseRd,Rpack:bibtex", "Rdpack"), ncol = 2)), "\n")

## all references from package Rdpack
cat(insert_all_ref(matrix(c("*", "Rdpack"), ncol = 2)), "\n")
}
\keyword{documentation}
% use one of  RShowDoc("KEYWORDS")
