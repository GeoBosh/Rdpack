\name{compare_usage1}
\alias{compare_usage1}
\title{
  Compare usage entries for a function to its actual arguments
}
\description{
  Compare usage entries for a function to its actual arguments.
}
\usage{
compare_usage1(urdo, ucur)
}
\arguments{
  \item{urdo}{
    usage text for a function or S3 method from an Rd object or file.
  }
  \item{ucur}{usage generated from the actual object.}
}

\details{
  Compares the usage statements for functions in the Rd object or file
  \code{urdo} to the usage inferred from the actual definitions of the
  functions. The comparison is symmetric but the interpretation assumes
  that \code{ucur} may be more recent.

  Note: do not compare the return value to TRUE with \code{identical} or
  \code{isTRUE}. The attribute makes the returned value not identical to
  TRUE in any case.
}

\value{
  TRUE if the usages are identical, FALSE otherwise.
  The return value has attribute "details", which is a list providing
  details of the comparison. The elements of this list should be
  referred by name, since if one of \code{urdo} or \code{ucur} is NULL
  or NA, the list contains only the fields "obj_removed", "obj_added",
  "rdo_usage", "cur_usage", and "alias".

  \item{identical_names}{a logical value, TRUE if the `name'  is the same in both objects.}
  \item{obj_removed}{names present in \code{urdo} but not in \code{ucur}}
  \item{obj_added                }{names present in \code{ucur} but not in \code{urdo}}
  \item{identical_argnames       }{a logical value,
    TRUE if the argument names in both objects are the same.}
  \item{identical_defaults       }{a logical value,
    TRUE if the defaults for the arguments in both objects are the same.}
  \item{identical_formals        }{a logical value, TRUE if the formals
    are the same, i.e. fields \code{identical_argnames} and
    \code{identical_defaults} are both TRUE.}
  \item{added_argnames  }{names of arguments in \code{ucur} but not in \code{urdo}.}
  \item{removed_argnames}{names of arguments in \code{urdo} but not in \code{ucur}.}
  \item{names_unchanged_defaults }{names of arguments whose defaults are the same.}
  \item{rdo_usage                }{a copy of \code{urdo}.}
  \item{cur_usage                }{a copy of \code{ucur}.}
  \item{alias                    }{alias of the name of the object, see `Details'.}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{inspect_usage}}
}
\keyword{RdoUsage}
