\name{insert_ref}
\alias{insert_ref}
\alias{insertRef}
\title{Insert bibtex references in Rd and roxygen2 documentation}
\description{

  Package Rdpack provides Rd macros for inserting references and
  citations from bibtex files into R documentation.  Function
  \code{insert_ref()} is the workhorse behind this mechanism. The
  description given on this page should be sufficient, for more details
  see the vignette.

}
\usage{
insert_ref(key, package = NULL, \dots, cached_env = NULL)
}
\arguments{
  \item{key}{the bibtex key of the reference, a character string.}
  \item{package}{the package in which to look for the bibtex file.}
  \item{\dots}{
    further arguments to pass on to \code{get_bibentries()}. The only
    one of interest to users is \code{bibfile}, whose default is
    "REFERENCES.bib", see \code{\link{get_bibentries}}.
  }
  \item{cached_env}{
    environment, used to avoid repeatedly pasing the bib
    file from scratch, mainly useful by the Rd macros.
  }
}
\details{
  
  \code{insert_ref} extracts a bibliograhic reference from a bibtex
  file, converts it to Rd format and returns a single string with
  embedded newline characters. It is the workhorse in the provided
  mechanism but most users do not even need to know about
  \code{insert_ref}.

  Package \pkg{Rdpack} provides several Rd macros for inserting
  references and citations in the documentation of a package. All macros
  work in both, manually written Rd files and in \pkg{roxygen2}
  documentation chunks. The macros look for references in file
  \code{"REFERENCES.bib"} in the root of the installation directory of
  the package. When a package is in development mode under
  \pkg{devtools}, \code{"inst/REFERENCES.bib"} in the development
  directory of the package is checked first. See also
  \code{\link{get_bibentries}} but note that while direct calls to
  \code{insert_ref()} can specify a different file, the filename and the
  places where it is looked for are fixed for the Rd macros.
  
  The description below assumes that \pkg{Rdpack} has been added to file
  DESCRIPTION, as described in \code{\link{Rdpack-package}} and vignette
  \code{"Inserting_bibtex_references"}. The Rd macros are put in the
  text of documentation sources (\sQuote{Rd} files or \sQuote{roxygen2}
  chunks).

  
  \subsection{Rd macro insertRef}{
  
    \verb{\\insertRef{key}{package}} inserts the reference with bibtex key
    \verb{key} from file \code{"REFERENCES.bib"} in package
    \verb{package}. Argument \sQuote{package} can be any installed \R
    package, not necessarily the one of the documentation object, as long
    as it contains file \code{"REFERENCES.bib"} in the root of its
    installation directory.  The references are partially processed when
    the package is built.
    
    References inserted with \verb{\\insertRef} appear in the place where
    the macro is put, usually in a dedicated references section
    (\verb{\\references} in Rd files, \verb{@references} in roxygen
    chunks).
    
    For example, section \sQuote{References} of this help page shows
    (among other things)) the rendered results of the following lines in
    the Rd source file:
    \preformatted{
        \\insertRef{Rpackage:rbibutils}{Rdpack}
    
        \\insertRef{parseRd}{Rdpack}
        
        \\insertRef{bibutils6.10}{rbibutils}
    }
    
    A roxygen2 documentation chunk might look like this:
    \preformatted{
        #' @references
        #' \\insertRef{Rpackage:rbibutils}{Rdpack}
        #' 
        #' \\insertRef{parseRd}{Rdpack}
        #' 
        #' \\insertRef{bibutils6.10}{rbibutils}
    }
    
    The first reference has label \verb{Rpackage:rbibutils} and is taken
    from file \code{"REFERENCES.bib"} in package \pkg{Rdpack}. The third
    reference is from the file \code{"REFERENCES.bib"} in package
    \pkg{rbibutils}.
    
    For more details see vignette \code{"Inserting_bibtex_references"}.
  }

  \subsection{Rd macro insertCite}{

    \code{\\insertCite{key}{package}} cites the key and records it for use
    by \code{\\insertAllCited}, see below. \code{key} can contain more
    keys separated by commas.
    
    \tabular{lll}{
       \code{\\insertCite{parseRd,Rpackage:rbibutils}{Rdpack}} \tab \insertCite{parseRd,Rpackage:rbibutils}{Rdpack} \cr
       \code{\\insertCite{Rpackage:rbibutils}{Rdpack}}   \tab \insertCite{Rpackage:rbibutils}{Rdpack} \cr
       \code{\\insertCite{bibutils6.10}{rbibutils}} \tab \insertCite{bibutils6.10}{rbibutils}
    }
    By default the citations are parenthesised
    \insertCite{parseRd}{Rdpack}.  To get textual citations, like
    \insertCite{parseRd;textual}{Rdpack}, put the string \code{;textual}
    at the end of the key. The references in the last two sentences were
    produced with \code{\\insertCite{parseRd}{Rdpack}} and
    \code{\\insertCite{parseRd;textual}{Rdpack}}, respectively.  This
    also works with several citations, e.g.
    \cr
      \code{\\insertCite{parseRd,Rpackage:rbibutils;textual}{Rdpack}}
    produces: \insertCite{parseRd,Rpackage:rbibutils;textual}{Rdpack}.

    To mix the citations with other text, such as \sQuote{see also} and
    \sQuote{chapter 3}, write the list of keys as free text, starting it
    with the symbol \code{@} and prefixing each key with it.  The
    \code{@} symbol will not appear in the output. For example, the
    following code
    \preformatted{
        \insertCite{@see also @parseRd and @Rpackage:rbibutils}{Rdpack},
    
        \insertCite{@see also @parseRd; @Rpackage:rbibutils}{Rdpack},
    
        \insertCite{@see also @parseRd and @Rpackage:rbibutils;textual}{Rdpack}.
    }
    produces:

    \tabular{l}{
      \insertCite{@see also @parseRd and @Rpackage:rbibutils}{Rdpack}, \cr
      \insertCite{@see also @parseRd; @Rpackage:rbibutils}{Rdpack}, \cr
      \insertCite{@see also @parseRd and @Rpackage:rbibutils;textual}{Rdpack}.
    }
    
    In the parenthesised form, adding \verb{;nobrackets} at the end of the
    list of keys causes the enclosing parentheses to be dropped. This is
    useful if you wish to use markup for the text surrounding the
    references. For example,
      \preformatted{
        (\emph{see also}  \insertCite{@@parseRd; @Rpackage:rbibutils;nobrackets}{Rdpack}).
      }
    gives: (\emph{see also}  \insertCite{@@parseRd; @Rpackage:rbibutils;nobrackets}{Rdpack}).
    Without \sQuote{\verb{;nobrackets}} the result would be
      (\emph{see also}  \insertCite{@@parseRd; @Rpackage:rbibutils}{Rdpack}).

  }
  
  \subsection{Rd macro insertNoCite}{
  
  The macro \code{\\insertNoCite{key}{package}} records one or more
  references for \code{\\insertAllCited} but does not cite it. Setting
  \code{key} to \code{*} will include all references from the specified
  package. For example, \code{\\insertNoCite{parseRd}{Rdpack}} and
  \code{\\insertNoCite{*}{rbibutils}} record the specified references
  for inclusion by \code{\\insertAllCited}.

  }
  
  \subsection{Rd macro insertAllCited}{
  
    \code{\\insertAllCited} inserts all references cited with
    \code{\\insertCite} and \code{\\insertNoCite}. Putting this macro
    in the references section will keep the references up to date automatically. 
    The Rd section may look something like:
    \preformatted{
       \\references{    
         \\insertAllCited{}
       }
    }
    or in roxygen2, the references chunk might look like this:
    \preformatted{
       #' @references
       #'   \\insertAllCited{}
    }

  }

  \subsection{Rd macro insertNoCite}{

    \code{\\insertCiteOnly{key}{package}} is as \code{\\insertCite} but
    does not include the key in the list of references for
    \code{\\insertAllCited}.

  }

}


  
\value{
  for \code{insert_ref}, a character string
}
\references{
  For illustrative purposes there are two sets of citations below
  The first set of references is obtained with \code{\\insertRef} for
  each reference: 

  \insertRef{parseRd}{Rdpack}

  \insertRef{Rpackage:rbibutils}{Rdpack}

  \insertRef{bibutils6.10}{rbibutils}
  
    ---- 

  The following references are obtained with a single \code{\\insertAllCited{}}. 
  The references are sorted automatically by the surnames of the authors:

     \insertAllCited{}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{Rdpack-package}} for overview,

  \code{vignette("Inserting_bibtex_references", package = "Rdpack")} for
  further details on the citation macros

  \code{\link{insert_citeOnly}} for the function generating citations
}
\examples{
cat(insert_ref("Rpackage:rbibutils", "Rdpack"), "\n")
}
\keyword{documentation}
\keyword{Rd}
