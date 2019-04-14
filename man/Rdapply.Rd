\name{Rdapply}
\alias{Rdapply}
\alias{rattr}
\alias{Rdtagapply}
\title{Apply a function over an Rd object}
\description{Apply a function recursively over an Rd object, similarly
  to rapply but keeping attributes.}
\usage{
Rdapply(x, \dots)

Rdtagapply(object, FUN, rdtag, classes = "character", how = "replace",
           \dots)

rattr(x, y)
}
\arguments{
  \item{x}{the Rd object on which to apply a function.}
  \item{object}{the Rd object on which to apply a function.}
  \item{FUN}{The function to apply, see details}
  \item{rdtag}{apply FUN only to elements whose \code{Rd_tag} attribute
    is \code{rdtag}.}
  \item{y}{an Rd object with the same structure as \code{x}, see `Details'.}
  \item{\dots}{arguments to pass to \code{rapply}, see `Details'.}
  \item{classes}{a character vector, passed on to \code{\link{rapply}},
    see `Details'.
  }
  \item{how}{a character string, passed on to \code{\link{rapply}},
    see `Details'.
  }
}
\details{
  \code{Rdapply} works like \code{rapply} but preserves the attributes
  of \code{x} and (recursively) any sublists of it.  \code{Rdapply}
  first calls \code{rapply}, passing all arguments to it. Then it
  restores recursively the attributes by calling \code{rattr}.

  Note that the object returned by \code{rapply} is assumed to have
  identical structure to the original object. This means that argument
  \code{how} of \code{rapply} must not be "unlist" and normally will be
  "replace".  \code{Rdtagapply} gives sensible default values for
  \code{classes} and \code{how}.  See the documentation of
  \code{\link{rapply}} for details and the possible choices for
  \code{classes}, \code{how} or other arguments passed to it via
  \code{"\dots"}.

  \code{Rdtagapply} is a convenience variant of \code{Rdapply} for the
  common task of modifying or examining only elements with a given
  \code{Rd_tag} attribute. Since the Rd equation macros \verb{\eqn} and
  \verb{\deqn} are assigned Rd tag "VERB" but are processed differently
  from other "VERB" pieces,  pseudo-tags
  "mathVERB" and "nonmathVERB" are provided, such that "mathVERB" is for
  actions on the first argument of the mathematical macros \verb{\eqn} and
  \verb{\deqn}, while "nonmathVERB" is for actions on "VERB" macros in
  all other contexts. There is also a pseudo-tag "nonmath" for anything
  that is not math.

  \code{rattr} is an auxilliary function which takes two Rd objects
  (with identical structure) and recursively examines them. It makes the
  attributes of any lists in the first argument identical to the
  corresponding attributes in the second.
}
\value{
  
  For \code{Rdapply} and \code{Rdtagapply}, an Rd object with some of
  its leaves replaced as specified above.

  For \code{rattr}, the object \code{x} with attributes of any list
  elements of it set to the corresponding attributes of \code{y}.
}
\author{Georgi N. Boshnakov}
\note{
  todo: may be it is better to rename the argument FUN of \code{Rdtagapply} to
  \code{f}, which is its name in \code{rapply}.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{rapply}}
}
\examples{
# create an Rd object for the sake of example
u1 <- list_Rd(name = "Dummyname", alias = "dummyfun",
              title = "Dummy title", description = "Dummy description",
              usage = "dummyfun(x)",
              value = "numeric vector",
              author = "A. Author",
              examples = "\na <- matrix(1:6,nrow=2)\na \%*\% t(a)\nt(a) \%*\% a",
              Rd_class=TRUE )

# correct R code for examples but wrong for saving in Rd files
Rdo_show(u1)

# escape percents everywhere except in comments
#  (actually, .anypercent escapes only unescaped percents)
rdo <- Rdapply(u1, Rdpack:::.anypercent, classes = "character", how = "replace")

# syntactically wrong R code for examples but ok for saving in Rd files
Rdo_show(rdo)


# Rdo2Rdf does this by default for examples and other R code,
#   so code can be kept syntactically correct while processing.
#   (reprompt() takes care of this too as it uses Rdo2Rdf for saving)

fn <- tempfile("u1", fileext="Rd")
Rdo2Rdf(u1, file = fn)

# the saved file contains escaped percents but they disappear in parsing:
file.show(fn)
Rdo_show(tools::parse_Rd(fn))

# if you think that sections should start on new lines,
# the following makes the file a little more human-friendly
#   (by inserting new lines).
\dontshow{# todo: additional arg. for list_Rd for this?
}
u2 <- Rdpack:::.Rd_tidy(u1)
Rdo2Rdf(u2, file = fn)
file.show(fn)

unlink(fn)
}

\keyword{RdoProgramming}

