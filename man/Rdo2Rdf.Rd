\name{Rdo2Rdf}
\alias{Rdo2Rdf}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Convert an Rd object to Rd file format
}
\description{
  Converts an Rd object to Rd format and saves it to a file or returns
  it as a character vector. It escapes percents where necessary and
  (optionally) backslashes in the examples section.
}
\usage{
Rdo2Rdf(rdo, deparse = FALSE, ex_restore = FALSE, file = NULL,
        rcode = TRUE, srcfile = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{rdo}{an Rd object or a character vector, see `Details'.}
  \item{deparse}{logical, passed to the print method for Rd objects,
    see `Details'.
  }
  \item{ex_restore}{logical, if \code{TRUE} escapes backslashes where
    necessary.
  }
  \item{file}{a filename where to store the result. If \code{NULL} or
    "missing", the result is returned as a character vector.
  }
  \item{rcode}{if TRUE, duplicate backslahes in RCODE elements, see
    Details.
  }
  \item{srcfile}{NULL or a file name, see 'Details'.}
}
\details{
  The description here is rather technical and incomplete. In any case
  it concerns almost exclusively Rd files which use escape sequences
  containing multiple consecutive backslashes or escaped curly braces
  (such things appear in regular expressions, for example).

  In principle, this function should be redundant, since the
  \code{print} and \code{as.character} methods for objects of class "Rd"
  would be expected to do the job. I was not able to get the desired
  result that way (the \code{deparse} option to \code{print} did not
  work completely for me either).

  Arguments \code{ex_restore} and \code{rcode} were added on an ad-hoc
  basis. \code{rcode} is more recent and causes \code{Rdo2Rdf} to
  duplicate backslashes found in any element \code{Rd_tag}-ed with
  "RCODE". \code{ex_restore} does the same but only for the examples
  section. In effect, if \code{rcode} is TRUE, \code{ex_restore} is
  ignored.

  The initial intent of this function (and the package Rdpack as a whole
  was not to refer to the Rd source file. However, there is some
  flexibility in the Rd syntax that does not allow the source file to be
  restored identically from the parsed object. This concerns mainly
  backslahes (and to some extent curly braces) which in certain contexts
  may or may not be escaped and the parsed object is the same. Although
  this does not affect functionality, it may be annoying if the escapes
  in sections not examined by \code{reprompt} were changed.

  If \code{srcfile} is the name of a file, the file is parsed and the Rd
  text of sections of \code{rdo} that are identical to sections from
  \code{srcfile} is taken directly from \code{srcfile}, ensuring that
  they will be identical to the original.



}
\value{
  \code{NULL}, if \code{file} is not \code{NULL}. Otherwise the Rd
  formatted text as a character vector.
}

\author{Georgi N. Boshnakov}

\note{
  Here is an example when the author's Rd source cannot be restored
  exactly from the parsed object.

  In the Rd source "author" has two backslashes here: \verb{\\author}.

  In the Rd source "author" has one backslash here: \verb{\author}.

  Both sentences are correct and the parsed file contains only one
  backslash in both cases. If \code{reprompt} looks only at the parsed
  object it will export one backslash in both cases. So, further
  reprompt()-ing will not change them again. This is if \code{reprompt}
  is called with \code{sec_copy = FALSE}.  With the default
  \code{sec_copy = TRUE}, \code{reprompt} calls \code{Rdo2Rdf} with
  argument \code{srcfile} set to the name of the Rd file and since
  \code{reprompt} does not modify section "Note", its text is copied
  from the file and the author's original preserved.


  However, the arguments of \verb{\eqn} are parse_Rd-ed differently (or
  so it seems) even though they are also in verbatim.


}
%% ~Make other sections like Warning with \section{Warning }{....} ~


\examples{
# # this keeps the backslashes in "author" (see Note above)
# reprompt(infile="./man/Rdo2Rdf.Rd")

# # this outputs "author" preceded by one backslash only.
# reprompt(infile="./man/Rdo2Rdf.Rd", sec_copy = FALSE)
}
\keyword{Rd}
