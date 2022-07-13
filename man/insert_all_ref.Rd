\name{insert_all_ref}
\alias{insert_all_ref}
\title{Insert references cited in packages}
\description{Insert references cited in packages. }
\usage{
insert_all_ref(refs, style = "", empty_cited = FALSE)
}
\arguments{
  \item{refs}{
    % TODO: is this description up-to-date? 
    a matrix specifying key-package pairs of the references to insert.
    Can also be a cached environment, see Details.
  }
  \item{style}{a bibstyle, see Details.}
  \item{empty_cited}{
    if \code{TRUE}, empty the list of currently cited items.
  }
}
\details{

  \code{insert_all_ref} is the workhorse behind several Rd macros for
  inclusion of references in Rd documentation.

  Argument \code{refs} is a two-column character matrix.  The first
  column specifies bibtex keys.  To specify more than one key in a
  single element, separate them by commas. The second column specifies the
  package in which to look for the keys.

  A key equal to "*" requests all keys in the corresponding package. 
  
  \code{insert_all_ref} drops duplicated keys, collects the references,
  and converts them to Rd textual representation for inclusion in Rd
  documentation files.

  \code{refs} can be a cached environment. This is for internal use and
  not documented.

}
\value{
  for \code{insert_all_ref}, a character string containing a textual
  representation of the references, suitable for inclusion in an Rd
  file 
}
\references{
  Currently there are no citations. Nevethelese, I have put
  \verb{\insertAllCited{}} just after this paragraph to show the message
  that it prints when there are no citations. This seems better than
  printing nothing but it may be argued also that there should be a
  warning as well.
  
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
## a reference from package Rdpack
cat(insert_all_ref(matrix(c("Rpack:bibtex", "Rdpack"), ncol = 2)), "\n")

## more than one reference from package Rdpack, separate the keys with commas
cat(insert_all_ref(matrix(c("parseRd,Rpack:bibtex", "Rdpack"), ncol = 2)), "\n")

## all references from package Rdpack
cat(insert_all_ref(matrix(c("*", "Rdpack"), ncol = 2)), "\n")

## all references from package Rdpack and rbibutils
m <- matrix(c("*", "Rdpack",  "*", "rbibutils"), ncol = 2, byrow = TRUE)
cat(insert_all_ref(m), "\n")
}
\keyword{documentation}
% use one of  RShowDoc("KEYWORDS")
