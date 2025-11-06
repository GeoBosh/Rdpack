\name{Rdo_which}
\alias{Rdo_which}
\alias{Rdo_which_tag_eq}
\alias{Rdo_which_tag_in}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Find elements of Rd objects for which a condition is true}
\description{Find elements of Rd objects for which a condition is true.}
\usage{
Rdo_which(rdo, fun)

Rdo_which_tag_eq(rdo, tag)

Rdo_which_tag_in(rdo, tags)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object.}
  \item{fun}{a function to evaluate with each element of \code{rdo}.}
  \item{tag}{a character string.}
  \item{tags}{a character vector.}
}
\details{

  These functions return the indices of the (top level) elements of
  \code{rdo} which satisfy a condition.

  \code{Rdo_which} finds elements of \code{rdo} for which
  the function \code{fun} gives TRUE.

  \code{Rdo_which_tag_eq} finds elements with a specific \code{Rd_tag}.

  \code{Rdo_which_tag_in} finds elements whose \code{Rd_tag}'s are among
  the ones specified by \code{tags}.

%%  ~~ If necessary, more details than the description above ~~
}
\value{
  a vector of positive integers
}
% \references{
% %% ~put references to the literature/web site here ~
% }
\author{Georgi N. Boshnakov}
% \note{
% %%  ~~further notes~~
% }

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{Rdo_locate}} which searches recursively the Rd object.
}
\examples{
## get the help page for topoc seq()
rdo_seq <- tools::Rd_db("base")[["seq.Rd"]]
## find location of aliases in the topic
( ind <- Rdo_which_tag_eq(rdo_seq, "\\alias") )
## extract the first alias
rdo_seq[[ ind[1] ]]
\dontrun{
## extract all aliases
rdo_seq[ind]
}

## db_bibtex <- tools::Rd_db("bibtex")
## names(db_bibtex)
## ## Rdo object for read.bib()
## rdo_read.bib <- db_bibtex[["read.bib.Rd"]]
## Rdo_tags(rdo_read.bib)
## 
## ## which elements of read.bib are aliases?
## Rdo_which_tag_eq(rdo_read.bib, "\\alias")
## rdo_read.bib[[3]]
## 
## ## which elements of read.bib contain R code?
## Rdo_which(rdo_read.bib, function(x) any(Rdo_tags(x) == "RCODE") )
## rdo_read.bib[[5]]
## ## which contain prose?
## Rdo_which(rdo_read.bib, function(x) any(Rdo_tags(x) == "TEXT") )
}
\keyword{Rd}
