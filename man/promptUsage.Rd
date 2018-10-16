\name{promptUsage}
\alias{promptUsage}
\alias{get_usage}
\title{Generate usage text for functions and methods}
\description{
  
  Generates usage text for a function, S3 method or S4 method.  The text
  is suitably formatted for inclusion in the usage section of Rd
  documentation.

}
\usage{
get_usage(object, name = NULL, force.function = FALSE, \dots,
          S3class = "", S4sig = "", infix = FALSE, fu = TRUE,
          out.format = "text")

promptUsage(\dots, usage)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{a function object or a character name of one, can be
    anonymous function.}
  \item{name}{the name of a function, a string.}
  \item{force.function}{enforce looking for a function.}
  \item{S3class}{the S3 class of the function, a character vector.}
  \item{out.format}{if "\verb{text}", return the result as a character
    vector.}
  \item{S4sig}{(the signature of an S4 method, as used in Rd macro
    \verb{\S4method}).}
  \item{infix}{if TRUE the function is an infix operator.}
  \item{fu}{if TRUE the object is a function, otherwise it is something
    else (e.g. a variable or a constant like \code{pi} and \code{Inf}).
  }
  \item{usage}{an usage object, see Details.}
  \item{\dots}{
    for \code{promptUsage}, arguments to be passed on to
    \code{get_usage}; for \code{get_usage}, currently not used.
  }
}
\details{

  \code{get_usage()} takes a function object, or the name of one, and
  creates text suitable for inclusion in the usage section of Rd
  documentation.  The usage is generated from the function object.  When
  in interactive \R session, use \code{cat()} to print the result for
  copying and pasting into Rd documentation or saving to a file
  (otherwise, if the usage text contains backslashes, they may appear
  duplicated).  Long text is wrapped on two or more lines. For example,
  \printExample{cat( get_usage(lm) )}
  Argument \code{"name"} can be used to specify a print name for the function.
  This is most often needed for S3 methods. Compare
  \printExample{cat( get_usage(summary.lm) )}
  and
  \printExample{cat( get_usage(summary.lm, name = "summary") )}
  The call is just \code{summary()} in the latter. This fairly reflects
  the fact that S3 methods are normally called via the generic, but
  adding some explanatory text around the command is usually a good
  idea. For programmatically generated usage sections in help pages,
  argument \code{S3class} can be used to get the standard Rd markup for
  S3 methods.
  \printExample{cat( get_usage(summary.lm, "summary", S3class = "lm") )}
  (Note that \verb{\method} can only be used in Usage sections.)
  
  When \code{object} is an anonymous function, argument \code{name} is compulsory.
  For example,
  % this code  prints ugly: \printExample{cat( get_usage(function(x = 3, y="a"){}, "f") )} 
  %  so do it manually in two steps:
  \code{cat( get_usage(function(x = 3, y = "a"){}, "f") )}

% TODO: this is commented out from the pkgdown site, since pkgdown() doesn't handle
%  results=verbatim yet.
%\Sexpr[stage=build,results=verbatim]{cat("##: ", get_usage(function(x = 3, y = "a"){}, "f"), "\n" )}

  \code{get_usage()} can also be used to insert dynamically signatures
  of functions located in other objects, such as environments and lists,
  see the examples.

  If a function is used as an infix operator, set \code{infix = TRUE}.
  \printExample{get_usage("+", infix = TRUE); get_usage("\\\%in\\\%", infix = TRUE)}
  The name of the operator may be in a variable:
  \printExample{op <- "+"; get_usage(op, infix = TRUE)}
  
  Backticks are ok, as well,
  \printExample{get_usage(`+`, infix = TRUE)}
  But if a backticked operator is in a variable, surprise springs: 
  \printExample{op <- `+`; get_usage(op, infix = TRUE)}
  In this case, don't use backticks  or, if you must, evaluate the argument:
  \printExample{op <- `+`; get_usage(eval(op), name = "+", infix = TRUE)}


  % \Sexpr[stage=build,results=hide]{wrap_percent <- function(x) paste0("\%", x, "\%")}
  % \printExample{op <- wrap_percent("in"); get_usage(op,  infix = TRUE)}
  % \printExample{op <- as.name(wrap_percent("in")); get_usage(eval(op), name = "in", infix = TRUE)}
  % \printExample{op <- as.name(wrap_percent("in")); get_usage(eval(op), name = wrap_percent("in"), infix = TRUE)}
  % \printExample{op <- as.name(wrap_percent("in")); get_usage(`\\\%in\\\%`, name = wrap_percent("in"), infix = TRUE)}

    
  % \strong{Sexpr:}
  % \Sexpr[stage=build,results=verbatim]{op <- as.name(wrap_percent("in")); get_usage(eval(op), name = wrap_percent("in"), infix = TRUE)}
  % \Sexpr[stage=build,results=verbatim]{op}
  % \Sexpr[stage=build,results=verbatim]{cat(wrap_percent("in"), "\n")}
  % \Sexpr[stage=build,results=verbatim]{e <- environment(); ls(e)}

  
  \code{promptUsage()} is mostly for internal use. It is like
  \code{get_usage()} with an additional argument, \code{usage}, used to
  pass a specially parsed argument list of class \verb{"f_usage"},
  produced by other functions in \pkg{Rdpack}. In particular it could
  have been generated by a previous call to \code{get_usage()}.

}
\value{
  a character string or an object of S3 class "\verb{f_usage}",
  see \code{\link{pairlist2f_usage1}} for its format.
}

\author{Georgi N. Boshnakov}
\note{
  For an S3 or S4 generic, use the name of the function, not the object,
  see the examples.

  These functions are for usage descriptions as they appear in the "usage"
  section of Rd files. Descriptions of S4 methods for "Methods" sections
  are dealt with by other functions.
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{parse_pairlist}}
}

\examples{
u <- get_usage(lm)    # a long usage text
cat(u)

# if there are additional arguments in S3 methods,
# use names of the functions, not the objects, e.g.
get_usage("droplevels", S3class = "data.frame")
get_usage(name = "droplevels", S3class = "data.frame")
# (both give "\method{droplevels}{data.frame}(x, except = NULL, \dots)")

# but this gives the args of the generic:  "\method{droplevels}{data.frame}(x, \dots)"
get_usage(droplevels, S3class = "data.frame")

## a list containing some functions
summaries <- list(xbar = function(x) mean(x), rho = function(x, y) cor(x,y))
get_usage(summaries$xbar, name = "xbar")
get_usage(summaries$rho, name = "rho")

## functions in an environment
esummaries <- list2env(summaries)
get_usage(esummaries$xbar, name = "xbar")
get_usage(esummaries$rho, name = "rho")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{documentation}
\keyword{Rd}
