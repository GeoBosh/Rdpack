\name{Rdpack-package}
\alias{Rdpack-package}
\alias{Rdpack}
\docType{package}
\title{
  \Sexpr[stage=build,results=hide]{require(Rdpack)}
  \Sexpr[stage=build,results=hide]{pd <- packageDescription("Rdpack")}
  \Sexpr[stage=build,results=hide]{lb <- library(help="Rdpack", character.only=TRUE)}
  \Sexpr[stage=build]{pd$Title}
}
\description{
  \Sexpr[stage=build]{pd$Description}
}
\details{
   \tabular{ll}{
   Package:  \tab \Sexpr[stage=build]{pd$Package}\cr
   Type:     \tab \Sexpr[stage=build]{pd$Type}\cr
   Version:  \tab \Sexpr[stage=build]{pd$Version} \cr
   Date:     \tab \Sexpr[stage=build]{pd$Date}\cr
   License:  \tab \Sexpr[stage=build]{pd$License}\cr
   LazyLoad: \tab \Sexpr[stage=build]{pd$LazyLoad}\cr
   Built:    \tab \Sexpr[stage=build]{pd$Built}\cr
   }

   Index:

  \Sexpr[stage=build,results=rd]{paste("\\\\preformatted{", paste(if(!is.null(lb$info[[2]])) lb$info[[2]] else "No entries",collapse="\\n"), "}", sep="")}


  Package \code{Rdpack} may help authors of \R packages to keep their
  documentation up to date during development.  Although base R and
  package \code{methods} have functions for creation of skeleton
  documentation, if a function gets a new argument or a generic gets a
  new method, then updating existing documentation is somewhat
  inconvenient. This package provides functions that update parts of the
  Rd documentation that can be dealt with automatically and leave manual
  changes untouched. For example, usage sections for functions are
  updated and if there are undescribed arguments, additional items are
  put in the `arguments' section.

  Another set of functions is for management of bibliographic
  references.

  The main functions provided by this package are
  \code{\link{reprompt}}, \code{\link{promptPackageSexpr}}, and
  \code{\link{rebib}}.

  \strong{NEW:} References are most easily inserted with the help of the
  macro \code{\\insertRef{key}{package}}. This facility works in Rd
  files and roxygen comments, see \code{\link{insertRef}} and the
  vignette for details and examples. The function \code{\link{viewRd}}
  renders a documentation file in a source package and displays it as
  text or in a browser. Convenience functions
  \code{\link{makeVignetteReference}} and \code{\link{vigbib}}
  generate Bibtex entries for vignettes.


  \code{\link{reprompt}} produces a skeleton documentation for the
  requested object, similarly to functions like \code{prompt},
  \code{promptMethods}, and \code{promptClass}.  Unlike those functions,
  \code{\link{reprompt}} updates existing documentation (installed or in
  an Rd object or file) and produces a skeleton from scratch as a last
  resort only. If the documentation object describes more than one
  function, all descriptions are updated.  Basically,
  \code{\link{reprompt}} updates things that are generated
  automatically, leaving manual editing untouched.

  The typical use of \code{reprompt} is with one argument, as in
  \preformatted{
    reprompt(infile = "./Rdpack/man/reprompt.Rd")
    reprompt(reprompt)
    reprompt("reprompt")
  }
  \code{reprompt} updates the documentation of all objects described in
  the Rd object or file, and writes the updated Rd file in the current
  working directory, see \code{\link{reprompt}} for details.


  \code{\link{promptPackageSexpr}} creates a skeleton for a
  package overview in file \verb{name-package.Rd}. Then the file can be
  edited as needed. This function needs to be called only once for a
  package since automatic generation of information in
  \verb{name-package.Rd} is achieved with Sexpr's at build time, not
  with verbatim strings as \code{promptPackage} does.

  For example, the source of this help page is file
  `Rdpack-package.Rd'. It was initially produced using
  \preformatted{
    promptPackageSexpr("Rdpack")
  }
  The factual information at the beginning of this help topic (the index
  above, the version and other stuff that can be determined
  automatically) is kept automatically up to date.

  \code{\link{rebib}} updates the bibliographic references in an Rd
  file. Rdpack uses a simple scheme for inclusion of
  bibliographic references. The key for each reference is in a TeX comment
  line, as in:
  \preformatted{\references{
    ...
    \% bibentry: key1
    \% bibentry: key2
    ...
  }
  }
  \code{rebib} puts each reference after the line containing its
  key. It does nothing if the reference has been put by a previous call
  of \code{rebib}. If the Bibtex entry for some references changes, it
  may be necessary to update them in the Rd file, as well. Call
  \code{rebib} with \code{force = TRUE} to get this effect. There is
  also a facility to include all references from the Bibtex file, see
  the documentation of \code{\link{rebib}} for details.

  The Bibtex source for the references is by default a file
  "REFERENCES.bib" located in the root of the package installation
  folder.


  Note that there are other, more sophisticated, approaches to keeping
  documentation and code in synchron, for example package \verb{roxygen2}
  (todo: give references here).


  It can hardly get simpler than using a single function,
  \code{reprompt}, with one argument (the doc file or the object to be
  updated) to update all sorts of Rd documentation files. Some may find
  that this is all they need and not bother with the rest of this
  documentation.


  Other functions that may be useful are \code{Rdo2Rdf}, \code{Rdapply}
  and \code{Rd_combo}. Here is also brief information about some more
  technical functions that may be helpful in certain circumstances.

  \code{\link{c_Rd}} concatenates Rd pieces, character strings and lists
  to create a larger Rd piece or a complete Rd object.
  \code{\link{list_Rd}} is similar to \code{\link{c_Rd}} but provides
  additional features for convenient assembling of Rd objects.

  \code{\link{parse_Rdpiece}} is technical function for parsing pieces
  of Rd source text but it has an argument to return formatted help text
  which may be useful when one wishes to show it to the user.

  \code{Rdo_set_section} can be used to set a section, such as
  "\verb{\author}".

  The remaining functions in the package are for programming with Rd
  objects (and probably many of them should not be exported).

}
\author{
  \Sexpr[stage=build]{pd$Author}

Maintainer: \Sexpr[stage=build]{pd$Maintainer}
}
\references{
  \insertRef{Rpack:bibtex}{Rdpack}

  \insertRef{parseRd}{Rdpack}

}
\note{
  All processing is done on the parsed Rd objects, i.e. objects of class
  "Rd" or pieces of such objects.

  The following terminology is used (todo: probably not yet
  consistently) throughout the documentation.

  "Rd object" - an object of class Rd, or part of such object.

  "Rd piece" - part of an object of class Rd. Fragment is also used but
  note that \code{parse_Rd} defines fragment more restrictively.

  "Rd text", "Rd source text", "Rd format" - these refer to the text of
  the Rd files.
}
% ~~ Optionally other standard keywords, one per line, from file KEYWORDS in ~~
% ~~ the R documentation directory ~~
\keyword{ package }
\seealso{
%  \code{\link[<pkg>:<pkg>-package]{<pkg>}} ~~
  \code{\link{reprompt}},
  \code{\link{promptPackageSexpr}},
  \code{\link{rebib}},
  
  \code{\link{viewRd}},
  \code{\link{vigbib}},
  \code{\link{makeVignetteReference}},
  
  \code{vignette("Inserting_bibtex_references", package = "Rdpack")}
}
\examples{
# The examples below show typical use.
# Simply insert the path to your Rd file, the name of the object or the
# object itself.
# For executable examples see main functions,
# reprompt and promptPackageSexpr

\dontrun{
# update the doc. from the Rd source and save myfun.Rd
#     in the current directory (like prompt)
reprompt(infile="path/to/mypackage/man/myfun.Rd")

# update doc of myfun() from the installed doc (if any);
#     if none is found, create it like prompt
reprompt("myfun")
reprompt(myfun)      # same

# update doc. for S4 methods from Rd source
reprompt(infile="path/to/mypackage/man/myfun-methods.Rd")

# update doc. for S4 methods from installed doc (if any);
#     if none is found, create it like promptMethods
reprompt("myfun", type = "methods")
reprompt("myfun-methods")  # same


# update doc. for S4 class from Rd source
reprompt(infile="path/to/mypackage/man/myclass-class.Rd")

# update doc. of S4 class from installed doc.
#     if none is found, create it like promptClass
reprompt("myclass-class")
reprompt("myclass", type = "class")  # same


# create a skeleton "mypackage-package.Rd"
promptPackageSexpr("mypackage")

# update the references in "mypackage-package.Rd"
rebib(infile="path/to/mypackage/man/mypackage-package.Rd", force=TRUE)
}
}

% # the usage of 'seq' has several entries, parse them all
%
%
% seq(\dots)
%
% \method{seq}{default}(from = 1, to = 1, by = ((to - from)/(length.out - 1)),
%     length.out = NULL, along.with = NULL, \dots)
%
% seq.int(from, to, by, length.out, along.with, \dots)
%
% seq_along(along.with)
% seq_len(length.out)
